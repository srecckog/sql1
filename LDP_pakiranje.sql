
select x3.pec,x3.kratkinaziv,x3.radnik,x3.TezinaProKom,x3.Smjena,sum(x3.Kolicina-x3.KrivuljaRezanje) as kolicina 
from (select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* from ( 
sELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM='2017-1-23' ) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ ) x3 
group by x3.pec,x3.kratkinaziv,x3.smjena,x3.TezinaProKom,x3.radnik 
order by x3.pec,x3.kratkinaziv,x3.smjena


SELECT *
FROM kalionicaKnjigaSmjeneZag

FROM KalionicaKnjigaSmjenesta


SELECT *
FROM EvidencijaProizvodnjeSta
WHERE id_eps=131567


SELECT *
FROM EvidencijaProizvodnjezag
WHERE id_epz=23472

select *
from [dbo].[KalionicaKnjigaSmjeneSta]


SELECT es.*,ez.*, ks.KratkiNaziv,ks.Kolicina,kz.*
FROM EvidencijaProizvodnjeSta es
left join EvidencijaProizvodnjezag ez on ez.ID_EPZ=es.ID_EPZ
left join KalionicaKnjigaSmjeneSta ks on ks.brojrn=ez.BrojRN
left join KalionicaKnjigaSmjenezag kz on kz.ID_KKSZ=ks.id_kksz
where es.datum='2017-01-24' and PrepakiranaStavka=1
order by brojrn


WHERE id_eps=131567


select kz.datum,ks.*,ez.*,es.*
from KalionicaKnjigaSmjenezag kz 
left join KalionicaKnjigaSmjeneSta ks on ks.id_kksz=kz.id_kksz
left join EvidencijaProizvodnjezag ez on ez.brojrn=ks.brojrn
left join EvidencijaProizvodnjeSta es on ez.ID_EPZ=es.ID_EPS
where kz.datum='2017-01-22' and es.id_eps='130843'
order by ks.brojrn
--and ez.brojrn='155/2016'



USE FeroApp
SELECT EPZ.BrojRN, NS.ID_Pro, Pro.NazivPro, EPS.* 
       FROM EvidencijaProizvodnjeSta EPS 
             INNER JOIN EvidencijaProizvodnjeZag EPZ ON EPS.ID_EPZ = EPZ.ID_EPZ 
             INNER JOIN NarudzbeSta NS ON EPZ.BrojRN = NS.BrojRN 
             INNER JOIN Proizvodi Pro ON NS.ID_Pro = Pro.ID_Pro 
       WHERE EPS.PrepakiranaStavka = 1 and ns.brojrn='155/2017'



USE FeroApp
SELECT EPZ.BrojRN , NS.ID_Pro , pro.TezinaPro , pro.NazivPro , EPS.*
FROM EvidencijaProizvodnjeSta EPS 
INNER JOIN EvidencijaProizvodnjeZag EPZ ON EPS.ID_EPZ = EPZ.ID_EPZ 
INNER JOIN NarudzbeSta NS ON EPZ.BrojRN = NS.BrojRN 
INNER JOIN Proizvodi Pro ON NS.ID_Pro = Pro.ID_Pro 
wHERE EPS.PrepakiranaStavka = 1 
and eps.datum='2017-01-24'


and ns.brojrn='155/2017'



	   and eps.datumunosa='2017-01-24'
