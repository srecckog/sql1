-- pregled djelatnika  koji rade vise od 12 sati
select pv.datum,r.id,r.prezime,r.ime,pv.radnomjesto,pv.hala,pv.smjena,round(ukupno_minuta/60,1) sati,pv.rbroj,pv.dosao,pv.otisao
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2018-06-20'
and ukupno_minuta>720
order by datum
---------------
---------------
DECLARE @datum1 date= '2018-05-11';  
use rfind
select *
from evidencijaodsustva
where datum=@datum1
--where DATEDIFF(day,datum,getdate())=1
-----------------------------------------------------------
----------------------------------------------------------
---------------------------------------------------------- izostaNCI
use rfind
select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' as 'Zaplanirani (  nije dosao)',''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as 'Nedostaje (minuta)','' as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where (pv.radnomjesto ='BO'  or pv.radnomjesto='GO' or pv.radnomjesto='G.O.' )
AND datum=@datum1

UNION ALL

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,case when (pv.otisao=pv.dosao) then 'Nije dosao' end Napomena2,''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  year(pv.otisao)=1900
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null

union all

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena, '' as Napomena2 ,''as 'Dosao, nije zaplanirani', pv.kasni as 'Kasni (minuta)','' as nedostaje,pv.PreranoOtisao as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  ( pv.kasni>0 or pv.PreranoOtisao>0)
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null and r.id !=695

union all

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,pv.Napomena,'' as napomena2,'Dosao, a vodi se na bolovanju'as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where pv.RadnoMjesto in ( 'BO','GO')
and pv.IDRadnika in
(
select u.ExtId
from [User] u
left join event e on u.OID=e.[User]
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
and r.Door not in ( 7,8,9,10)
)
and datum=@datum1

union all

--select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena, ( rtrim(pv.Napomena)+' nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u '+cast(pv.dosao as nvarchar) +' otišao u '+convert(pv.otisao as nvarchar) ) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)'
-- nedostaje1 , èistaèice
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (420-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani',pv.kasni as 'Kasni (minuta)', (420-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv=8
and pv.Ukupno_minuta<420
and ((420 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

union all
-- nedostaje11, ostali 8 sati
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (pv.PreranoOtisao + pv.kasni) as Nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and pv.Ukupno_minuta<480
and ((480 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

union all

-- nedostaje111, 16 sati

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 16 sati, nedostaje  '+cast( (960-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (960-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and ( pv.Ukupno_minuta<960 and pv.Ukupno_minuta>800)
and ((960 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

order by r.mt,r.prezime,pv.datum,pv.RadnoMjesto,PV.Smjena
-----------------------------------------------------
-----------------------------------------------------	
-----------------------------------------------------------
-- nezaplanirani
select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where datum=@datum1
)
and r.id not in 
(
select idradnika
from PregledVremena
where DATEDIFF(day,datum,@datum1)=1
and smjena=3
)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
where DATEDIFF(day,e.dt,@datum1)=0
)



------------------------
-- NEW nije zaplaniran a dosao
use rfind
select distinct x1.id,x1.ime,x1.prezime,x1.radnomjesto,x1.pvid
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and DATEDIFF(day,pv.datum,getdate())=1
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where sifrarm not in ('Režija1','Rez1')
and pv.idradnika is null
and DATEDIFF(day,pv.datum,getdate())=1
--and pv.datum='2018-03-26'
--and id=373
--and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika

) x1
order by x1.prezime

------------
-- OLD
-- prijavio se nije zaplaniran
use rfind
--select distinct r.*,min(e.Dt),e.Device_ID
select r.id,r.ime,r.prezime,r.radnomjesto
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where pv.idradnika is null
and sifrarm not in ('Režija','Rez')
--and DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2018-01-29'
--and DATEDIFF(day,e.dt,getdate())=1
and day(e.dt)=26 and month(e.dt)=3
and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto
order by r.prezime
------------------------------
--  izvještaj kumulativni ------------
-- nisu došli
declare @datum1 as date
set @datum1= '2018-03-29'

SELECT X1.NAZIV,X1.DATUM,X1.SMJENA,COUNT(*) Broj_odsutnih
FROM (

declare @datum1 as date
set @datum1= '2018-03-29'


select r.prezime,r.ime,pv.smjena,mt.Naziv,pv.datum,pv.RadnoMjesto
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on mt.Id=r.mt
where datum=@datum1
and year(dosao)=1900
and pv.RadnoMjesto<>'4. SMJENA'
) X1
GROUP BY NAZIV,DATUM,SMJENA
order by NAZIV,X1.datum desc
-----------------------------------------

-- kašnjenje
SELECT X1.NAZIV,X1.DATUM,sum(x1.kasni) Kasni
FROM (

select r.id,r.prezime,r.ime,mt.Naziv,pv.datum,pv.RadnoMjesto,pv.kasni
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on mt.Id=r.mt
where datum=@datum1
and year(dosao)!=1900 and dosao!=otisao
and pv.RadnoMjesto<>'4. SMJENA'
and pv.kasni>0
--order by naziv
) X1
GROUP BY NAZIV,DATUM
having sum(x1.kasni)>0
order by x1.NAZIV,X1.datum desc


-- nedostaje1
SELECT X1.NAZIV,X1.DATUM,sum(x1.nedostaje) Nedostaje1
FROM (
select r.prezime,r.ime,pv.smjena,mt.Naziv,pv.datum,pv.RadnoMjesto,pv.kasni,(480-pv.Ukupno_minuta)  nedostaje
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on mt.Id=r.mt
where datum=@datum1
and year(dosao)!=1900 and dosao!=otisao
and r.rv!=8
and pv.RadnoMjesto<>'4. SMJENA'
and (480-pv.ukupno_minuta)>0
union all
select r.prezime,r.ime,pv.smjena,mt.Naziv,pv.datum,pv.RadnoMjesto,pv.kasni,(420-pv.Ukupno_minuta)  nedostaje
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on mt.Id=r.mt
where datum=@datum1
and year(dosao)!=1900 and dosao!=otisao
and r.rv=8
and pv.RadnoMjesto<>'4. SMJENA'
and (420-pv.ukupno_minuta)>0
--order by naziv
) X1
GROUP BY NAZIV,DATUM
order by x1.NAZIV,X1.datum desc


-- nedostaje2
SELECT X1.NAZIV,X1.DATUM,sum(nedostaje) Nedostaje2
FROM (

select r.prezime,r.ime,pv.smjena,mt.Naziv,pv.datum,pv.RadnoMjesto,pv.kasni,case when (480-pv.Ukupno_minuta)>pv.kasni then (480-pv.Ukupno_minuta) else pv.kasni end  nedostaje
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on mt.Id=r.mt
where datum=@datum1
and r.rv!=8
and year(dosao)!=1900 and dosao!=otisao
and pv.RadnoMjesto<>'4. SMJENA'
and ((480-pv.Ukupno_minuta)>0 or pv.kasni>20)

union all

select r.prezime,r.ime,pv.smjena,mt.Naziv,pv.datum,pv.RadnoMjesto,pv.kasni,case when (420-pv.Ukupno_minuta)>pv.kasni then (420-pv.Ukupno_minuta) else pv.kasni end  nedostaje
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on mt.Id=r.mt
where datum=@datum1
and r.rv=8
and year(dosao)!=1900 and dosao!=otisao
and pv.RadnoMjesto<>'4. SMJENA'
and ((420-pv.Ukupno_minuta)>0 or pv.kasni>20)

--order by naziv

) X1
GROUP BY NAZIV,DATUM
order by x1.NAZIV,X1.datum desc

--------------------------



-----------------------------
-- vodi se da je na bolovanju a dosao raditi
--select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena, '' as Napomena2 ,''as 'Dosao, nije zaplanirani', pv.kasni as 'Kasni (minuta)'
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,pv.Napomena,'' as napomena2,'' as 'Dosao, nije zaplaniran ( bolovanje)',0 as 'Kasni (minuta)'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where pv.RadnoMjesto in ( 'BO','GO')
and pv.IDRadnika in
(
select u.ExtId
from [User] u
left join event e on u.OID=e.[User]
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,getdate())=1 AND E.EVENTTYPE='SP39'
and r.Door not in ( 7,8,9,10)
)
and DATEDIFF(day,pv.datum,getdate())=1
---------------------------------------------
-- Nisu se uredno prijavili
select r.id,r.prezime,r.ime,pv.dosao,pv.otisao,pv.napomena,pv.hala,pv.smjena,pv.radnomjesto
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
where datum='2018-03-29'
and Ukupno_minuta=0 and dosao=otisao
and year(dosao)!=1900
order by datum desc
-----------------------------------------

select u.ExtId,E.*
from [User] u
left join event e on u.OID=e.[User]
where 
DATEDIFF(day,e.dt,getdate())=1
AND U.EXTID=521



-----------------------------------------------------------------
-- nema ih u planu, a dosli su na posao

select u.*
 from radnici_ r 
left join [user] u on u.extid=r.id
where r.id=1337


select *
from event 
where [user]=2424
order by dt desc



left join event e on e.OID=u.oid
where r.id=1195



select top 1 * from (


select convert(varchar(15),dateadd(day,-1,getdate()),104 ) datum, x1.*,min(e.dt) dosao,max(e.Dt) otisao,r.Name from (
select r.id,r.ime,r.prezime,r.lokacija,r.mt,r.radnomjesto,r.poduzece,r.sifrarm,r.rv,r.FixnaIsplata
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id
where pv.idradnika is null
and sifrarm not in ('Režija','Rez')
) x1
left join [user] u on u.ExtId=x1.id
left join event e on e.[user]=u.oid
left join reader r on r.id=e.Device_ID
--and DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2018-01-29'
where DATEDIFF(day,e.dt,getdate()) = 1
and r.Door not in ( 7,8,9,10)
and year(e.dt)=2018 and month(e.dt)=2
group by day(e.dt),x1.id,ime,prezime,lokacija,mt,radnomjesto,poduzece,sifrarm,rv,fixnaisplata,name
order by prezime


---------------------------------------------------
where x1.id in (
select *
from [user] u
left join event e on e.oid=u.oid
where 
DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2018-01-29'

)
order by 


--------------------------------------------------------------------
--update radnici_ set rv=2 where id in ( 1020,754)
--update radnici_ set rv=3 where id in ( 879)
--update radnici_ set rv=4 where id in ( 774,775)
-----------------------------------------------------------------------


where id not in (

select pv.IDRadnika
from PregledVremena pv
where year(pv.dosao)<>1900
AND DATEDIFF(day,pv.datum,getdate())>=1
)


select *
from radnici_
where id=48

---- Briši katušiæa
--delete from radnici_ where id=454

select *
from pregledvremena
where idradnika=1206

--delete from pregledvremena where datum='2018-3-15'


select count(*) Broj_odsutnih,smjena
from pregledvremena
where ukupno_minuta=0
and radnomjesto<>'4. SMJENA'
and datum='2018-03-15'
group by smjena
ORDER BY smjena


select sum(480-Ukupno_minuta) Prerano_otisao,smjena
from pregledvremena
where radnomjesto<>'4. SMJENA'
and datum='2018-03-15'
and ukupno_minuta<480
group by smjena
ORDER BY smjena


select *
from pregledvremena
where radnomjesto<>'4. SMJENA'
and datum='2018-03-15'
and ukupno_minuta>480
ORDER BY smjena,Ukupno_minuta


select *
from pregledvremena
where radnomjesto<>'4. SMJENA'
and datum='2018-03-15'
and idradnika=1124
ORDER BY smjena,Ukupno_minuta


select r.id,r.prezime,r.ime,pv.hala,pv.Smjena ,pv.RadnoMjesto,r.mt,pv.napomena
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where pv.Ukupno_minuta=0
and pv.RadnoMjesto<>'4. SMJENA'
and pv.datum='2018-03-15'
and year(dosao)=1900
order by hala,mt,smjena,prezime,ime


-- Nisu se uredno prijavili
select r.id,r.prezime,r.ime,pv.dosao,pv.otisao,pv.napomena,pv.hala,pv.smjena,pv.radnomjesto
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
where datum='2018-03-20'
and Ukupno_minuta=0 and dosao=otisao
and year(dosao)!=1900
order by datum desc



select smjena,sum(480-ukupno_minuta) 'Fali Minuta'
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on r.mt=mt.id
where (480-pv.Ukupno_minuta)>0
and pv.RadnoMjesto<>'4. SMJENA'
and pv.datum='2018-03-15'
group by smjena
order by smjena



select r.prezime,r.ime,480-ukupno_minuta 'Fali Minuta'
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on r.mt=mt.id
where (480-pv.Ukupno_minuta)>0
and pv.RadnoMjesto<>'4. SMJENA'
and ukupno_minuta>0
and pv.datum='2018-03-15'
order by smjena


select smjena,sum(480-ukupno_minuta) 'Fali Minuta'
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on r.mt=mt.id
where (480-pv.Ukupno_minuta)>0
and pv.RadnoMjesto<>'4. SMJENA'
and ukupno_minuta>0
and pv.datum='2018-03-15'
group by smjena
order by smjena



select r.id,r.prezime,r.ime,pv.dosao,pv.otisao,pv.napomena,pv.hala,pv.smjena,pv.radnomjesto
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
where datum='2018-03-15'
and Ukupno_minuta=0 and dosao=otisao
and year(dosao)!=1900
order by datum desc




@datum1 = "

-- režija
select *,datediff(mi,x1.dosao,x1.otisao) Ukupno_minuta,datediff(mi,'2018-03-16 07:00:00' ,x1.dosao) kasni_minuta,datediff(mi,x1.otisao,'2018-03-16 15:00:00') ranije_minuta
from (

select r.id,r.prezime,r.ime, mt.naziv MT_naziv,min(e.dt) dosao,max(e.dt) otisao
from event e
left join [User] u on u.oid=e.[user]
left join radnici_ r on r.id=u.ExtId
left join mjestotroska mt on mt.id=r.mt
where dt>='2018-03-16 0:0:0' and dt<='2018-03-16 23:59:59'
and r.FixnaIsplata=1 and r.mt not in ( 700)
group by  r.id,r.prezime,r.ime,mt.naziv
) x1
order by x1.id



select radnomjesto,id,(prezime+' '+ime) imer
from radnici_
where fixnaisplata=1 and mt not in (700)

use rfind
select * into pv1703 from pregledvremena

--delete from pregledvremena where datum='2018-03-20'


select *
from pregledvremena
where kasni>0
order by datum desc


select *
from [user]
where extid=8008


select *
from event
where [user]=1398
order by dt desc


use rfind
select *
from pregledvremena
where datum='2018-04-12'
and idradnika=1173
order by idradnika

use rfind
delete from pregledvremena where datum>='2018-03-27'
delete from evidencijaodsustva where datum='2018-04-27'

select *
from evidencijaodsustva
where datum='2018-04-04'


use rfind
select distinct x1.id,x1.ime,x1.prezime,x1.radnomjesto,x1.pvid
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and pv.datum='2018-03-26'
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where sifrarm not in ('Režija','Rez')
and pv.idradnika is null
and day(e.dt)=26 and month(e.dt)=3
--and pv.datum='2018-03-26'
--and id=373
--and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika

) x1
order by x1.prezime




select pv.datum,pv.smjena,pv.hala,pv.radnomjesto,r.id,r.ime,r.prezime,r.radnomjesto,pv.ukupno_minuta,dosao,otisao
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and pv.datum>='2018-04-03'
where pv.ukupno_minuta>720
order by r.id


select x1.idradnika,r.prezime,r.ime,count(*)
from (

SELECT datum,idradnika,dosao,otisao,ukupno_minuta,rbroj
from pregledvremena
where DATEPART(dw,datum )=6   --SUBOTA
and ukupno_minuta=0
and year(dosao)=1900
and radnomjesto not in ('BO','GO','B.O.','G.O.','4. SMJENA')
ORDER BY datum

) x1
left join radnici_ r on r.id=x1.idradnika
group by idradnika,prezime,ime
order by count(*) desc



--delete from pregledvremena where idradnika=750 and smjena=1 and datum='2018-04-19'

select *
from pregledvremena where datum='2018-04-19'
and hala='Režija' and year(dosao)=1900


--update pregledvremena set dosao='2018-04-18 13:48:00' where idradnika=1317 and datum='2018-04-18'

--update pregledvremena set ukupno_minuta=datediff(minute, dosao, otisao) where idradnika=1317 and datum='2018-04-18'


-- kontrola 12 sati 
select pv.datum,r.id,r.prezime,r.ime,pv.radnomjesto,pv.hala,pv.smjena,round(ukupno_minuta/60,1) sati,pv.rbroj,pv.dosao,pv.otisao
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2018-04-17'
and ukupno_minuta>720
order by datum

-- kontrola druga smjena prije 11 sati ????
select pv.datum,r.id,r.prezime,r.ime,pv.radnomjesto,pv.hala,pv.smjena,round(ukupno_minuta/60,1) sati,pv.rbroj,pv.dosao,pv.otisao
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum>='2018-04-17'
and smjena=2 and datepart(hh,dosao)<11 and year(dosao)!=1900
order by datum

select pv.*,r.mt
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where datum='2018-04-27'
and r.mt=705
--and idradnika=541
order by rbroj

--
--delete from pregledvremena where datum='2018-04-27' and idradnika=462

select *
from evidencijaodsustva
where datum='2018-04-27'


and kasni>0


select count(*),sum(kasni),sum(preranootisao)

select sum(preranootisao)
from pregledvremena
where datum='2018-04-27'
and preranootisao>0
and hala in ('1','3','Zona')



--and idradnika=541
order by rbroj

use rfind
delete from pregledvremena where datum>='2018-01-21'
delete from evidencijaodsustva where datum='2018-07-27'


select *
from pregledvremena
where datum='2018-07-26'
and idradnika=100


order by rbroj


where idradnika=100


update pregledvremena set preranootisao=0 where idradnika=100 and datum>='2018-07-24'


select *
from pregledvremena
where datum>='2018-07-01'
and hala='Režija'
order by idradnika


select * into pv1407
from pregledvremena


update pregledvremena set kasni=0,preranootisao=(480-ukupno_minuta) where hala='Režija' and datum>'2018-07-05'


update pregledvremena set ukupno_minuta=1211,dosao='2018-08-20 21:15:00',otisao='2018-08-21 17:26:00' where idradnika=284 and datum='2018-08-20'

delete from pregledvremena where idRADNIKA=284 AND DATUM='2018-08-21' AND RBROJ=34

use rfind
select *
from pregledvremena
where datum='2018-09-07'

use rfind
delete from pregledvremena where DATUM>='2018-12-01'

select *
from radnici_
where sifrarm='Režija'
and rv=2
order by id



update radnici_ set rv=1 where id=1332

use rfind
select *
from pregledvremena
where idradnika=284   -- peruša
order by datum 

update pregledvremena set  ukupno_minuta=1211,DATUM='2018-08-19',smjena=3,ukupno_minuta=970,dosao='2018-08-19 21:50:00',otisao='2018-08-20 14:00:00', preranootisao=0,tdoci=22,totici=14 where idradnika=474 and datum='2018-08-20' and smjena=3 and rbroj=244
--update pregledvremena set  tdoci=6,totici=14 where idradnika=100 and datum='2018-08-02' and smjena=1

select datediff(n,dosao,otisao),dosao,otisao
from pregledvremena
where datum='2018-08-20' and idradnika=284


use rfind
select *
from pregledvremena
order by datum desc
-------------------
-- dosao = otisao ???
------------------
use rfind
select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,pv.rbroj,pv.dosao,pv.otisao,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' as 'Zaplanirani (  nije dosao)',''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as 'Nedostaje (minuta)','' as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where pv.otisao=pv.dosao and year(pv.dosao)!=1900
AND datum='2018-08-26'


update pregledvremena
set
--dosao='2018-08-26 5:56:00',
otisao='2018-08-23 15:12:00',
ukupno_minuta=492
where idradnika=984
and 
datum='2018-08-23'
and tdoci=7


select *
from pregledvremena
where idradnika=1373
and datum='2018-11-14'


use rfind
select *
from pregledvremena
where Datum>='2018-04-30'
--and radnomjesto='G.O.'
order by datum desc
 
order by rbroj,idradnika


use rfind
delete from pregledvremena where datum>='2018-05-04'  --and smjena!=1
delete from pv_test where datum='2018-10-06'

select m.id
from radnici r
left join mt m on mt.id=r.mt
where r.id=id1


select * into pregledvremena0205
from pregledvremena




use rfind
select r.prezime,m.naziv mtroska,pv.*
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join mjestotroska m on m.id=r.mt
where Datum='2018-01-02'
order by rbroj,idradnika



use rfind
select *
from pregledvremena
where Datum>='2018-10-09'
and dosao=otisao and year(dosao)=1900
and radnomjesto NOT in ('BO','G.O.','B.O.','4. SMJENA') AND hala not in ('Režija')
order by rbroj,idradnika


select *
from pregledvremena
where datum='2018-03-11' and idradnika=1292
order by idradnika


update pregledvremena set preranootisao=113 where idradnika=1292 and tdoci=6