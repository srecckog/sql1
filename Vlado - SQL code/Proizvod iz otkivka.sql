USE FeroApp

SELECT ID_ULP, ID_Skl, BrojDokumenta, DatumDokumenta, BrojRN, ID_Pro, KolicinaMat, OtpadMat, KolicinaPro, OtpadProUkupno, 
	(SELECT ID_Mat FROM IzlazRobe WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR) AS ID_Mat,
	(SELECT OmjerPro FROM Materijali WHERE ID_Mat = (SELECT ID_Mat FROM IzlazRobe WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR)) AS Omjer,
	(SELECT SUM(KolicinaMat) FROM UlazProizvodaKorekcija WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) AS Korekcija_mat, 
	(SELECT SUM(KolicinaPro) FROM UlazProizvodaKorekcija WHERE ID_ULP = UlazProizvodaDetaljnoView.ID_ULP) AS Korekcija_pro
	FROM UlazProizvodaDetaljnoView 
	WHERE DatumDokumenta >= '2013-01-01'
	AND ID_Skl IN (109,126,128,151)
	AND ABS((KolicinaMat * (SELECT OmjerPro FROM Materijali WHERE ID_Mat = (SELECT ID_Mat FROM IzlazRobe WHERE ID_IZR = UlazProizvodaDetaljnoView.ID_IZR))) - (KolicinaPro + OtpadProUkupno + OtpadMat))
		> 1
	ORDER BY DatumDokumenta, ID_Skl		