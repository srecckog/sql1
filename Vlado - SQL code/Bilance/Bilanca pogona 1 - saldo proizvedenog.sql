USE FeroApp ; DECLARE @TmpDanStanja date ; SET @TmpDanStanja = '2016-06-30'

SELECT ID_ULP, ID_Skl, BrojDokumenta, DatumDokumenta, MT, ID_Pro, CAST(KolicinaMat AS Float) AS KolicinaMat, CAST((KolicinaPro + OtpadProFaktura) AS Float) AS KolicinaPro, CAST(OtpadProUkupno AS Float) AS OtpadPro, 
	CAST(OtpadMat AS Float) AS OtpadMat, CAST(Obrada1 * CijenaObrada1 AS Float) AS Tok_EUR, 
	CAST(((Obrada2 * CijenaObrada2) + (Obrada3 * CijenaObrada3) + (Obrada4 * CijenaObrada4) + (Obrada5 * CijenaObrada5)) AS Float) AS Obrade2345_EUR,
	CAST(dbo.CalcVrijednostIZR(ID_IZR) AS Float) AS Iznos_IZR, CAST((SELECT Kolicina FROM IzlazRobe WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR) AS Float) AS Kolicina_IZR,
	CAST((SELECT TecajValute FROM UlazRobeDetaljnoView WHERE ID_ULR = dbo.PronadjiULR(UlazProizvodaDetaljnoView.ID_ULP, 'ULP')) AS Float) AS TeèajMat, 
	CAST(dbo.PronadjiTecaj(DatumDokumenta, 'EUR') AS Float) AS TeèajObrade, 
	CAST((SELECT PostotakManTro FROM Skladista WHERE ID_Skl = UlazProizvodaDetaljnoView.ID_Skl) AS Float) AS PostoOtpada,
	CAST(dbo.CalcVrijednostULP(ID_ULP, 4) AS Float) AS VrijednostULP,
	CAST((KolicinaPro + VisakPro + OtpadProFaktura - dbo.CalcStanjeProizvoda(ID_ULP, @TmpDanStanja, 'ULPP')) AS Float) AS SaldoPro
	FROM UlazProizvodaDetaljnoView 
	WHERE ID_Skl IN(SELECT ID_Skl FROM Skladista WHERE RacunajOmjerMatProOtkivak = 1 AND ID_Skl <> 109)
	AND DatumDokumenta <= @TmpDanStanja
	AND (KolicinaPro + VisakPro + OtpadProFaktura - dbo.CalcStanjeProizvoda(ID_ULP, @TmpDanStanja, 'ULPP')) <> 0
	ORDER BY ID_Skl, MT, DatumDokumenta, BrojDokumenta
	