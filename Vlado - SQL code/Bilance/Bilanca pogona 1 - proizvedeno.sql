USE FeroApp

SELECT ID_ULP, BrojDokumenta, DatumDokumenta, MT, ID_Pro, CAST(KolicinaMat AS Float) AS KolMat, CAST((KolicinaPro + OtpadProFaktura) AS Float) AS KolicinaPro, 
	CAST(OtpadProUkupno AS Float) AS OtpadPro, CAST(OtpadMat AS Float) AS OtpadMat, CAST(Obrada1 * CijenaObrada1 AS Float) AS Tok_EUR, 
	CAST(((Obrada2 * CijenaObrada2) + (Obrada3 * CijenaObrada3) + (Obrada4 * CijenaObrada4) + (Obrada5 * CijenaObrada5)) AS Float) AS Obrade2345_EUR,
	CAST(dbo.CalcVrijednostIZR(ID_IZR) AS Float) AS Iznos_IZR, CAST((SELECT Kolicina FROM IzlazRobe WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR) AS Float) AS Kolicina_IZR,
	CAST((SELECT TecajValute FROM UlazRobeDetaljnoView WHERE ID_ULR = dbo.PronadjiULR(UlazProizvodaDetaljnoView.ID_ULP, 'ULP')) AS Float) AS TeèajMat, 
	CAST(dbo.PronadjiTecaj(DatumDokumenta, 'EUR') AS Float) AS TeèajObrade, 
	CAST((SELECT PostotakManTro FROM Skladista WHERE ID_Skl = UlazProizvodaDetaljnoView.ID_Skl) AS Float) AS PostoOtpada, ID_Skl
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2015-07-01' AND '2015-09-30' 
	AND (KolicinaPro + OtpadProUkupno) <> 0
	AND (Obrada2 = 1 OR Obrada3 = 1 OR Obrada4 = 1 OR Obrada5 = 1)
	ORDER BY ID_Skl, DatumDokumenta, BrojDokumenta