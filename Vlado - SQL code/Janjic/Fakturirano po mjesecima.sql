USE FeroApp;

/*WITH MyTmpTable1 AS(
SELECT FDV.ID_Par, MONTH(FDV.DatumFakture) AS Mjesec, FDV.VrstaFakture, CAST(SUM(FDV.KolicinaPro) AS float) AS Kolicina 
	FROM FaktureDetaljnoView FDV 
	WHERE FDV.DatumFakture BETWEEN '2016-01-01' AND '2016-12-31' 
		AND FDV.VrstaTroska = 'Proizvod' 
		AND FDV.VrstaFakture IN(SELECT VF.VrstaFakture FROM VrsteFaktura VF WHERE VF.CreateASN = 1)
	GROUP BY FDV.ID_Par, MONTH(FDV.DatumFakture), FDV.VrstaFakture)

SELECT ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = MyTmpTable1.ID_Par) AS Kupac, Mjesec, VrstaFakture, Kolicina 
	FROM MyTmpTable1 
	WHERE Kolicina <> 0
	ORDER BY ID_Par, VrstaFakture, Mjesec */

WITH MyTmpTable1 AS(
SELECT FDV.ID_Par, MONTH(FDV.DatumFakture) AS Mjesec, FDV.VrstaFakture, CAST(SUM(FDV.KolicinaPro) AS float) AS Kolicina 
	FROM FaktureDetaljnoView FDV 
	WHERE FDV.DatumFakture BETWEEN '2016-01-01' AND '2016-12-31' 
		AND FDV.VrstaTroska = 'Proizvod' 
		AND FDV.ID_Par = 8752
	GROUP BY FDV.ID_Par, MONTH(FDV.DatumFakture), FDV.VrstaFakture)

SELECT ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = MyTmpTable1.ID_Par) AS Kupac, Mjesec, VrstaFakture, Kolicina 
	FROM MyTmpTable1 
	WHERE Kolicina <> 0
	ORDER BY ID_Par, VrstaFakture, Mjesec 