USE FeroApp;

WITH MyTmpTable AS(
	SELECT ID_Par, NazivMat, NazivPro, (SELECT Proizvodi.VrstaPro FROM Proizvodi WHERE Proizvodi.ID_Pro = FaktureDetaljnoView.ID_Pro) AS Vrsta, KolicinaPro, 
		(CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo 
		FROM FaktureDetaljnoView 
		WHERE DatumFakture BETWEEN '2016-01-01' AND '2016-04-30' 
		AND VrstaTroska = 'Proizvod' 
		AND KolicinaPro <> 0)

SELECT ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = MyTmpTable.ID_Par) AS Kupac, Vrsta, Vlasnistvo, NazivMat, NazivPro, CAST(SUM(KolicinaPro) AS float) AS Kolicina 
	FROM MyTmpTable 
	WHERE Vrsta <> 'Alat'
	GROUP BY ID_Par, Vrsta, Vlasnistvo, NazivMat, NazivPro