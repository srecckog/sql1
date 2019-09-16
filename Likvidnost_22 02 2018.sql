USE FinkAT15
--select count(*)
--from (
select x1.BROJFAKTURE,X1.SifraPartnera,X1.DatumDokumenta,dateadd(month,1, X1.DatumDokumenta) as datumzaplatiti , (DATEPART(wk,DatumDokumenta),'') KWd, IznosKn,IznosEUR,PlacenoEUR,DatumPlacanja,isnull(datepart(wk,DatumPlacanja),'') KWp
from (

SELECT ID, BrojFakture, SifraPartnera, DatumDokumenta, DatumDospjeca,  CAST(IznosKn AS float) AS IznosKn, CAST(IznosEUR AS float) AS IznosEUR, 
       CAST((SELECT SUM(IznosValuta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND SifraVD = '9' and IznosValuta=TmpFakture.IznosEUR  ) AS float) AS PlacenoEUR,
       (SELECT MIN(DatumDokumenta) FROM PrometSK WHERE BrojFakture = TmpFakture.BrojFakture AND SifraPartnera = TmpFakture.SifraPartnera AND Storno = 0 AND SifraVD = '9' and IznosValuta=TmpFakture.IznosEUR) AS DatumPlacanja
       FROM TmpFakture
	--  where brojfakture='1-1-701'
)x1	
--where isnull(datepart(wk,DatumPlacanja),'')=0
--)x2
--where brojfakture='1-1-701'
where sifrapartnera=121269
      ORDER BY SifraPartnera, DatumDokumenta 