DECLARE @datum1 date= '2017-08-09';  
use rfind
-----------------------------------------------------------
-- nezaplanirani
select x1.id,x1.ime,x1.prezime,e.dt vrijeme,r.Name
from (
select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where datum=@datum1
)
--and r.id not in 
--(
--select idradnika
--from PregledVremena
--where DATEDIFF(day,datum,@datum1)=1
--and smjena=3
--)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
and r.Door in (1,8,2,6,7 )
and DATEPART(hour, e.dt)>5
)	
) x1
left join [user] u on u.extid=x1.id
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
order by x1.id,e.dt

-- kontrola dali je zaplaniran i na GO ili BO
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
and pv.radnomjesto in ( 'G.O.','B.O.','BO','GO')
order by r.id
-------------------
-------------------
--------------------
-- kontrola za 1 radika za mjesec dana
select  x1.*,v.datum,v.rbroj
from (
select u.extid,e.dt
from [user] u
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where month(e.dt)=3 AND E.EVENTTYPE='SP39'
and r.Door in (1,8,2,6,7 )
and DATEPART(hour, e.dt)>=5
and u.ExtId=52    // id radnika
) x1
left join pregledvremena v on v.IDRadnika=x1.ExtId and  DATEDIFF(day,x1.dt,v.datum)=0
---------------------




delete from PregledVremena where idradnika=243 and datum='2017-05-08' and radnomjesto='L8'


select *
from pregledvremena
where idradnika=243
and datum='2017-05-08'


delete from PregledVremena where datum='2017-05-03' and idradnika=1175 and rbroj=70

-- Kontrola broja prolaza
select x2.broj,x2.dan1,mt.naziv,r.*
from radnici_ r
left join mjestotroska mt on mt.id=r.mt
left join ( 
select x1.id,dan1, count(*) broj
from
(select u.extid id,e.dt,day(e.dt) dan1
from [user] u
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where month(e.dt)=7 AND E.EVENTTYPE='SP39'
and r.Door in (1,3,4,5,8,2,6,7,9,10 )
--and u.extid=474 order by dt
) x1
group by x1.id,x1.dan1
having count(*) in ( 1,3,5,6,7,8,9)
) x2 on x2.id=r.id
where x2.id=r.id
and x2.dan1=13
order by mt.naziv,r.prezime
--and DATEPART(hour, e.dt)>=5


select *
from reader


select count(*)
from (
select distinct idradnika
from pregledvremena
where datum='2017-07-26'
--and hala<>'Režija'
--and radnomjesto  in ('BO','B.O.')
)x1



select *
from radnici_
where id in ( 14,462)

update radnici_ set rv=704 where id=14

