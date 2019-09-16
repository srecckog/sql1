declare @datum1 date='2018-07-24'
use rfind
select r.id,r.prezime,r.ime,r.mt,r.lokacija,mt.Naziv,r.poduzece
from radnici_ r
left join mjestotroska mt on mt.id=r.mt
where r.mt in (700,701,702,710,712,713,716)
and r.id not in 
(
select idradnika
from pregledvremena
where datum=@datum1
)
and r.id not in
(
select id
from kompetencije
where projekt='Neradi' or projekt='Na odlasku'
)
and r.neradi=0
and r.mt = 700
and r.id not in ( 22)   -- pero šestan-tkb
order by r.mt

-- duplo zaplanirnai
use rfind
select r.id,r.prezime,r.ime,pv.rbroj,pv.datum,pv.hala,pv.smjena,pv.radnomjesto
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
where pv.idradnika in (
select x1.idradnika
from (
select idradnika,count(*) broj
from pregledvremena
where @datum1=datum
group by idradnika
having count(*)>1 
) x1

)
and pv.datum=@datum1
--and pv.radnomjesto in ( 'G.O.','B.O.','BO','GO')
order by r.id


--select *
--from pregledvremena
--where idradnika =91
--order by datum desc


--select *
--from pregledvremena
--where datum='2018-03-06'
--and idradnika=430


--select *
--from kompetencije
--where id>900000