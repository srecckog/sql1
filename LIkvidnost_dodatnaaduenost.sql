USE FinkAT15

SELECT ID, BrojFakture, SifraPartnera, DatumDokumenta, DatumDospjeca, CAST(IznosKn AS float) AS IznosKn, CAST(IznosEUR AS float) AS IznosEUR, 
       CAST((SELECT SUM(IznosValuta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND SifraVD = '9') AS float) AS PlacenoEUR, 
       (SELECT MIN(DatumDokumenta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND SifraVD = '9') AS DatumPlacanja
       FROM TmpFakture
       ORDER BY SifraPartnera, DatumDokumenta 
