USE FeroApp

SELECT Grupacija FROM Skladista GROUP BY Grupacija
/*SELECT MONTH(DatumFakture) AS Mjesec, CAST(SUM(TezinaMatKom * KolicinaMat) AS Float) AS TezinaMat, CAST(SUM(TezinaProKom * KolicinaPro) AS Float) AS TezinaPro 
	FROM FaktureDetaljnoViewStat 
	WHERE ID_Skl IN(SELECT ID_Skl FROM Skladista WHERE Grupacija = 'SCHAEFFLER SCHWEINFURT') 
	AND DatumFakture >= '2015-01-01' 
	AND VrstaTroska = 'Proizvod'
	GROUP BY MONTH(DatumFakture)
	ORDER BY MONTH(DatumFakture)*/

/*SELECT MONTH(DatumFakture) AS Mjesec, CAST(SUM(TezinaMatKom * KolicinaPro) AS Float) AS TezinaMat, CAST(SUM(TezinaProKom * KolicinaPro) AS Float) AS TezinaPro 
	FROM FaktureDetaljnoViewStat 
	WHERE ID_Skl IN(113,119) 
	AND ID_Par = 221453
	AND DatumFakture >= '2015-01-01' 
	AND VrstaTroska = 'Proizvod'
	GROUP BY MONTH(DatumFakture)
	ORDER BY MONTH(DatumFakture)*/

/*SELECT ID_Par, (SELECT NazivPar FROM Partneri WHERE ID_Par = FaktureDetaljnoViewStat.ID_Par) AS Kupac, ID_Mat, ID_Pro, CAST(SUM(TezinaMatKom * KolicinaPro) AS Float) AS TezinaMat, CAST(SUM(TezinaProKom * KolicinaPro) AS Float) AS TezinaPro, CAST(SUM(KolicinaPro) AS float) AS KolicinaPro
	FROM FaktureDetaljnoViewStat 
	WHERE ID_Skl IN(113,119) 
	AND DatumFakture >= '2015-01-01' 
	AND VrstaTroska = 'Proizvod'
	GROUP BY ID_Par, ID_Mat, ID_Pro
	ORDER BY ID_Par*/

/*SELECT 'FAG MAGYARORSZÁG' AS Kupac, ID_Mat, (SELECT NazivMat FROM Materijali WHERE ID_Mat = FaktureDetaljnoViewStat.ID_Mat) AS Materijal, ID_Pro, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = FaktureDetaljnoViewStat.ID_Pro) AS Proizvod, (SELECT CAST(OmjerPro AS float) FROM Materijali WHERE ID_Mat = FaktureDetaljnoViewStat.ID_Mat) AS Omjer, CAST(TezinaMatKom AS float) AS TezinMatKom, CAST(TezinaProKom AS float) AS TezinProKom, CAST(SUM(KolicinaPro) AS float) AS KolicinaPro
	FROM FaktureDetaljnoViewStat 
	WHERE DatumFakture >= '2015-01-01' 
	AND ID_Skl IN(SELECT ID_Skl FROM Skladista WHERE Grupacija = 'FAG MAGYARORSZÁG') 
	AND VrstaTroska = 'Proizvod'
	GROUP BY ID_Mat, ID_Pro, TezinaMatKom, TezinaProKom*/