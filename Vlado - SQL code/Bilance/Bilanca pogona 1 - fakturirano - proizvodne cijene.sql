USE FeroApp 

SELECT ID_FS, BrojFakture, DatumFakture, (SELECT MT FROM UlazProizvoda WHERE ID_ULP = FaktureDetaljnoViewStat.ID_Ulp) AS MT, VrstaFakture, ID_Par, CAST(KolicinaMat AS Float) AS KolMat, 
	CAST(CijenaMatKom AS Float) AS CijenaMatKom, CAST(KolicinaPro AS Float) AS KolPro, CAST(CijenaProKom AS Float) AS CijenaProKom, CAST(Obrada1 * CijenaObrada1 AS Float) AS Tok_EUR, 
	CAST(((Obrada2 * CijenaObrada2) + (Obrada3 * CijenaObrada3) + (Obrada4 * CijenaObrada4) + (Obrada5 * CijenaObrada5)) AS Float) AS Obrade2345_EUR,
	CAST(dbo.PronadjiTecaj((SELECT DatumDokumenta FROM UlazProizvodaDetaljnoView WHERE ID_ULP = FaktureDetaljnoViewStat.ID_Ulp), 'EUR') AS Float) AS TeèajObrade, 
	CAST(dbo.CalcVrijednostULP(ID_Ulp, 4) AS Float) AS Vrijednost_Ulp, 
	CAST((SELECT (KolicinaPro + VisakPro + OtpadProFaktura) FROM UlazProizvodaDetaljnoView WHERE ID_ULP = FaktureDetaljnoViewStat.ID_Ulp) AS Float) AS Kolicina_ULP, 
	ID_Skl
	FROM FaktureDetaljnoViewStat 
	WHERE DatumFakture BETWEEN '2015-07-01' AND '2015-09-30'
	AND ID_Ulp IS NOT NULL
	AND (Obrada2 = 1 OR Obrada3 = 1 OR Obrada4 = 1 OR Obrada5 = 1)
	ORDER BY ID_Skl, DatumFakture, BrojFakture