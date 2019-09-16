USE FinkAT15

/*DELETE FROM TmpFakture
INSERT INTO TmpFakture (BrojFakture, DatumDokumenta, DatumDospjeca, SifraPartnera, IznosKn, IznosEUR)
SELECT BrojFakture, DatumDokumenta, DatumDospjeca, SifraPartnera, Iznos, IznosValuta
	FROM PrometSK 
	WHERE BrojFakture LIKE '%-%-%'
	AND SifraPartnera IN(221452, 121273, 221453, 121274, 274)
	AND SifraVD = '51'
	AND Storno = 0*/
	
SELECT BrojFakture, SifraPartnera, (SELECT FeroApp.dbo.Partneri.NazivPar FROM FeroApp.dbo.Partneri WHERE FeroApp.dbo.Partneri.ID_Par = SifraPartnera) NazivKupca, DatumDokumenta, DatumDospjeca, 
	CAST(IznosEUR AS Float) AS IznosEUR, CAST(IznosKn AS float) AS IznosKn, 
	CAST(ISNULL((SELECT SUM(ISNULL(IznosValuta, 0)) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND Strana = 'P' AND DatumDokumenta <= TmpFakture.DatumDospjeca), 0) AS Float) AS PlacenoKnNaVrijemeEUR, 
	CAST(ISNULL((SELECT SUM(Iznos) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND Strana = 'P' AND DatumDokumenta <= TmpFakture.DatumDospjeca), 0) AS Float) AS PlacenoKnNaVrijemeKn, 
	CAST(ISNULL((SELECT SUM(ISNULL(IznosValuta, 0)) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND Strana = 'P' AND DatumDokumenta > TmpFakture.DatumDospjeca), 0) AS Float) AS PlacenoVanRokaEUR, 
	CAST(ISNULL((SELECT SUM(Iznos) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND Strana = 'P' AND DatumDokumenta > TmpFakture.DatumDospjeca), 0) AS Float) AS PlacenoVanRokaKn, 
	(SELECT MIN(DatumDokumenta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND Strana = 'P' AND SifraVD <> 'TE') AS DatumPlacanja 
	FROM TmpFakture
	WHERE DatumDokumenta >= '2016-01-01' 
	ORDER BY SifraPartnera, DatumDokumenta