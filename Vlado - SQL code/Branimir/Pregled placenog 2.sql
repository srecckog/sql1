USE FinkAT15

/*DELETE FROM TmpFakture
INSERT INTO TmpFakture (BrojFakture, DatumDokumenta, DatumDospjeca, SifraPartnera, IznosKn, IznosEUR)
SELECT BrojFakture, DatumDokumenta, DatumDospjeca, SifraPartnera, Iznos, IznosValuta
	FROM PrometSK 
	WHERE BrojFakture LIKE '%-%-%'
	AND SifraPartnera IN(221452, 121273, 221453, 121274, 274)
	AND SifraVD = '51'
	AND Storno = 0*/

-- SELECT SifraPartnera, (SELECT FeroApp.dbo.Partneri.NazivPar FROM FeroApp.dbo.Partneri WHERE FeroApp.dbo.Partneri.ID_Par = SifraPartnera) AS Naziv FROM TmpFakture GROUP BY SifraPartnera

SELECT ID, BrojFakture, SifraPartnera, DatumDokumenta, DatumDospjeca, CAST(IznosKn AS float) AS IznosKn, CAST(IznosEUR AS float) AS IznosEUR, 
	CAST((SELECT SUM(IznosValuta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND SifraVD = '9') AS float) AS PlacenoEUR, 
	(SELECT MIN(DatumDokumenta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND SifraVD = '9') AS DatumPlacanja
	FROM TmpFakture
	ORDER BY SifraPartnera, DatumDokumenta 