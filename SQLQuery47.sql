USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[sp_Kompetencije_]    Script Date: 21.2.2018. 9:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_Kompetencije_] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-----------------------------
-- update from patheon
-----------------------------
--exec sp_addlinkedserver @server="192.168.0.6";
Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";

-- Polje funkcija
-- select *
-- from [192.168.0.6].feroimpex.dbo.thr_prsnjob
-- where acFieldSB is null

-- Ne rade
--select *
--from [192.168.0.6].feroimpex.dbo.thr_prsn
--where addateexit is not nul
-- KONTROLE
-- provjera dali je netko dao otkaz i vratio se ponovno , u radnici_ treba staviti neradi=0
Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
select *
from [192.168.0.6].PantheonFxAt.dbo.thr_prsnjob j
left join [192.168.0.6].PantheonFxAt.dbo.thr_prsn p on p.acworker=j.acworker
where anid=2 and j.addateend is null
and p.acregno not in
(
select id
from radnici_
where neradi=0
)

-- provjera dali je netko dao otkaz a nalazi se u radnici_
select *
from [192.168.0.6].PantheonFxAt.dbo.thr_prsn
where addateexit is not null
and acregno  in 
(
select id
from radnici_
where neradi=0
and poduzece='FX')

select *
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn
where addateexit is not null
and acregno  in 
(
select id
from radnici_
where neradi=0
and poduzece='Tokabu'
)
-------------------------------------
-- update radnici_ set neradi=1 where id in ( 13,41,42,45,74) and poduzece='Tokabu'
-------------------------------------
-------------------------------------
-- update kompetencije, datum prestanka, datum zaposlenja, radno mjesto, mjesto troska
-------------------------------------
update kompetencije set istek_ugovora=j.datumo,mjesto_troska=j.mt,RadnoMjesto=j.rm,datumzaposlenja=j.datz,godisnji_ostalo=j.GO_ostalo
from
(
select p.acregno,j.adEmployedTo  datumo,mt.naziv mt,j.acfieldsb funkcija,j.acjob rm,j.addate datz,v.anvacationf1 GO_ostalo
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob j on j.acworker=p.acworker
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnvacation v on v.acworker=p.acworker
left join MjestoTroska mt on mt.id=j.accostdrv
where j.addateend is null 
) j
inner join kompetencije k on k.id=j.acregno
where k.poduzece='FX'

-- tb
update kompetencije set istek_ugovora=j.datumo,mjesto_troska=j.mt,RadnoMjesto=j.rm,datumzaposlenja=j.datz,godisnji_ostalo=j.GO_ostalo
from
(
select p.acregno,j.adEmployedTo datumo,mt.naziv mt,j.acfieldsb funkcija,j.acjob rm,j.addate datz,v.anvacationf1 GO_ostalo
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j on j.acworker=p.acworker
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnvacation v on v.acworker=p.acworker
left join MjestoTroska mt on mt.id=j.accostdrv
where j.addateend is null 
) j
inner join kompetencije k on k.id=j.acregno
where k.poduzece='Tokabu'

------------------------------------
-- update radnici_.neradi = 1 u FX, samo za one koji su otišli
-----------------------------------
update radnici_ set neradi=j.neradi,datumprestanka=j.addateend,mt=j.mt1
from
(
select acregno,case when l.addateend is not null then 1 else 0 end  neradi,l.accostdrv mt1,l.addateend
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join ( select acworker,max(anid) anid from [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob group by acworker ) j on j.acworker=p.acworker
inner join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob  l on j.acworker=l.acworker and j.anid=l.anid
where l.addateend is null 
--where addateexit is not null
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Feroimpex' 
and k.id = j.acregno
----------------------------------------
-- update radnici_.neradi = 1 u TB
----------------------------------------
update radnici_ set neradi=j.neradi,datumprestanka=j.addateend
from
(
select acregno,case when l.addateend is not null then 1 else 0 end  neradi,l.accostdrv mt1,l.addateend
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p
left join ( select acworker,max(anid) anid from [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob group by acworker ) j on j.acworker=p.acworker
inner join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob  l on j.acworker=l.acworker and j.anid=l.anid
where l.addateend is null 
--where addateexit is not null
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Tokabu' 
and k.id = j.acregno
----------------
------------------------------------
-- FXAT update radnici_ koji nisu otišli promjena mjesta troška,lokacija
-----------------------------------
update radnici_ set mt=j.mt1, lokacija=j.lokacija1
from
(
select acregno,addateexit,case when addateexit is not null then 1 else 0 end  neradi,j.accostdrv mt1, j.acdept lokacija1
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob j on j.acworker=p.acworker
where j.addateend is null 
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Feroimpex' and j.neradi=0
and k.id = j.acregno

----------------------------------------
-- TB update radnici_ koji nisu otišli promjena mjesta troška, lokacija
----------------------------------------
update radnici_ set mt=j.mt1,lokacija=j.lokacija1
from
(
select acregno,addateexit,case when addateexit is not null then 1 else 0 end  neradi,j.accostdrv mt1, j.acdept lokacija1
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j on j.acworker=p.acworker
where j.addateend is null 
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Tokabu' and j.neradi=0
and k.id = j.acregno
----------------
-----------------------------------------

-- dodavanje novih djelatnika FX
-----------------------------------------
insert  into fxserver.rfind.dbo.kompetencije ( id, prezimeime, mjesto_troska,radnomjesto,datumzaposlenja,poduzece)

select distinct r.id,r.prezime+' '+r.ime+'('+cast(r.id as varchar(4)) +')' prezimeime,mt.naziv mjestotroska,r.radnomjesto,r.datumzaposlenja ,'FX' poduzece
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.mjestotroska mt on mt.id=r.mt
where r.neradi=0
and r.id not in 
(
select ID
from fxserver.rfind.dbo.kompetencije
where poduzece='FX'
--order by id
)
and r.id not in
(
select radnikid
from fxserver.fxsap.dbo.plansatirada
where danodlaska IS NOT  NULL and firma!=2
--order by radnikid
)
and ( year(r.datumprestanka)=1900 or r.datumprestanka is null)
and r.poduzece='Feroimpex'
ORDER BY R.ID
-----------------------------
-- dodavanje novih djelatnika TB
-----------------------------
insert  into fxserver.rfind.dbo.kompetencije ( id, prezimeime, mjesto_troska,radnomjesto,datumzaposlenja,poduzece)

select distinct r.id,r.prezime+' '+r.ime+'('+cast(r.id as varchar(4)) +')' prezimeime,mt.naziv mjestotroska,r.radnomjesto,r.datumzaposlenja ,'Tokabu' poduzece
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.mjestotroska mt on mt.id=r.mt
where r.neradi=0
and r.id not in 
(
select ID
from fxserver.rfind.dbo.kompetencije
where poduzece='Tokabu' 
--order by id
)
and r.id not in
(
select radnikid
from fxserver.fxsap.dbo.plansatirada
where danodlaska IS NOT  NULL and firma!=2
--order by radnikid
)
and ( year(r.datumprestanka)=1900 or r.datumprestanka is null)
and r.poduzece='Tokabu'
ORDER BY R.ID
----------------------------------------------------
--- dolasci nedjeljom
---------------------------------------------
-- update Kompetencije set [DolasciNedjeljom]=0
--- 12 mjeseci
-------------------------------------------------------
update Kompetencije set [DolasciNedjeljom12]=0

   UPDATE   
    kompetencije

SET	
   [DolasciNedjeljom12] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where ( datepart(dw, datum)=7 or datepart(dw,otisao)=7 )
 --  pod nedjeljom se računa i subota 3 smjena) ----
 and year(dosao)!=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,12 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
 group  by datum,idradnika
  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 
--------------------------------------------------------
---- update Kompetencije set [DolasciNedjeljom]=0
--- 6 mjeseci
--------------------------------------------------------
update Kompetencije set [DolasciNedjeljom6]=0

   UPDATE   
    kompetencije

SET	
   [DolasciNedjeljom6] =j.broj
   
FROM
    (

 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where ( datepart(dw, datum)=7 or datepart(dw,otisao)=7 )
 --  pod nedjeljom se računa i subota 3 smjena) ----
 and year(dosao)!=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,6 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
 group  by datum,idradnika
  ) x1
  group  by idradnika

  
  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

--------------------------------------------
-- update Kompetencije set [DolasciNedjeljom]=0
--- 3 mjeseci
-------------------------------------------------------
update Kompetencije set [DolasciNedjeljom3]=0

   UPDATE   
    kompetencije

SET	
   [DolasciNedjeljom3] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where ( datepart(dw, datum)=7 or datepart(dw,otisao)=7 )
 --  pod nedjeljom se računa i subota 3 smjena) ----
 and year(dosao)!=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,3 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by datum,idradnika
  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

------------------------------------------------------
-- update Kompetencije set [DolasciNedjeljom]=0
--- 1 mjesec
-------------------------------------------------------
update Kompetencije set [DolasciNedjeljom1]=0

   UPDATE   
    kompetencije

SET	
   [DolasciNedjeljom1] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where ( datepart(dw, datum)=7 or datepart(dw,otisao)=7 )
 --  pod nedjeljom se računa i subota 3 smjena) ----
 and year(dosao)!=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,1 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by datum,idradnika
  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

------------------------------------------------------
-- update Kompetencije set [DolasciPraznikom]=0
--- 1 mjesec
-------------------------------------------------------
update Kompetencije set [DolasciPraznikom1]=0

   UPDATE   
    kompetencije

SET	
   [DolasciPraznikom1] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 
 select distinct p.datum,idradnika
 from pregledvremena p
 left join praznici pr on pr.datum=p.datum
 where dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,1 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') 
 and pr.datum is not null
 group  by p.datum,idradnika

  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

------------------------------------------------------
-- update Kompetencije set [DolasciPraznikom]=0
--- 3 mjesec
-------------------------------------------------------
update Kompetencije set [DolasciPraznikom3]=0

   UPDATE   
    kompetencije

SET	
   [DolasciPraznikom3] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 
 select distinct p.datum,idradnika
 from pregledvremena p
 left join praznici pr on pr.datum=p.datum
 where dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,3 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') 
 and pr.datum is not null
 group  by p.datum,idradnika

  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 
-----------------------------------------------------
-- update Kompetencije set [DolasciPraznikom]=0
--- 6 mjesec
-------------------------------------------------------
update Kompetencije set [DolasciPraznikom6]=0

   UPDATE   
    kompetencije

SET	
   [DolasciPraznikom6] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 
 select distinct p.datum,idradnika
 from pregledvremena p
 left join praznici pr on pr.datum=p.datum
 where dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,6 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') 
 and pr.datum is not null
 group  by p.datum,idradnika

  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

------------------------------------------------------
-- update Kompetencije set [DolasciPraznikom]=0
--- 12 mjeseci
-------------------------------------------------------
update Kompetencije set [DolasciPraznikom12]=0

   UPDATE   
    kompetencije

SET	
   [DolasciPraznikom12] =j.broj
   
FROM
    (
	
 select count(*) broj,x1.idradnika
 from 
 (
 
 select distinct p.datum,idradnika
 from pregledvremena p
 left join praznici pr on pr.datum=p.datum
 where dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,12 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') 
 and pr.datum is not null
 group  by p.datum,idradnika

  ) x1
  group  by idradnika


  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 


-----------------------------------------
-- update Kompetencije set [NedolasciNedjeljom]=0
--- 12 mjeseci
----------------------------------------------
update Kompetencije set [NedolasciNedjeljom12]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom12] =j.broj
   
FROM
    (

 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where datepart(dw, datum)=7
 and year(dosao)=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,12 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
 group  by datum,idradnika
  ) x1
  group  by idradnika
  
  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

------------------
--- NN 6 mjeseci
-----------------
update Kompetencije set [NedolasciNedjeljom6]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom6] =j.broj
   
FROM
    (
	 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where datepart(dw, datum)=7
 and year(dosao)=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,6 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija' 
  group  by datum,idradnika
  ) x1
  group  by idradnika

  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 
---------------
--- NN 3 mjeseci
---------------
update Kompetencije set [NedolasciNedjeljom3]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom3] =j.broj
   
FROM
    (
	 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where datepart(dw, datum)=7
 and year(dosao)=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,3 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija' 
  group  by datum,idradnika
  ) x1
  group  by idradnika

  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 

--------------
-- NN 1 mjeseci
----------------
update Kompetencije set [NedolasciNedjeljom1]=0

   UPDATE   
    kompetencije

SET	
   [NedolasciNedjeljom1] =j.broj
   
FROM
    (
	 select count(*) broj,x1.idradnika
 from 
 (
 select distinct datum,idradnika
 from pregledvremena p
 where datepart(dw, datum)=7
 and year(dosao)=1900
 and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,1 )=1
 and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija' 
  group  by datum,idradnika
  ) x1
  group  by idradnika

  ) j

INNER JOIn kompetencije k
ON 
    j.idradnika = k.id 
------------------------------------
--	G O D I Š NJ I 
--------------------------------------------------------------
-- update kompetencije, GODIŠNJI
-----------------------------------------
-- PRETHODNI MJESEC
----------------------
   UPDATE  kompetencije set [Godisnji_dana1]=0

   Update kompetencije
SET	
   	[Godisnji_dana1]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,1 )=1
	and razlog='G'  
	--and r.id=125
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 
---------------------------------------
-- zadnja 3 mjeseca
----------------------
   UPDATE  kompetencije set [Godisnji_dana3]=0

   Update kompetencije
SET	
   	[Godisnji_dana3]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,3 )=1
	and razlog='G'  
	--and r.id=125
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 
---------------------
-- zadnjaih 6 mjeseci
----------------------
   UPDATE  kompetencije set [Godisnji_dana6]=0

   Update kompetencije
SET	
   	[Godisnji_dana6]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,6 )=1
	and razlog='G'  
	--and r.id=125
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 
---------------------------
-- PRETHODNI 12 MJESECi
----------------------
   UPDATE  kompetencije set [Godisnji_dana12]=0

   Update kompetencije
SET	
   	[Godisnji_dana12]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,12 )=1
	and razlog='G'  
	--and r.id=125
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

------------------------------------
--	B O L O V A NJ A
--------------------------------------------------------------
-- update kompetencije, bolovanja
-----------------------------------------
-- PRETHODNI MJESEC
----------------------
   UPDATE  kompetencije set [Bolovanje_broj1]=0,[Bolovanja_dana1]=0

   Update kompetencije
SET	
   [Bolovanje_broj1] = j.puta,
	[Bolovanja_dana1]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,1 )=1
	and razlog='B'  
	--and r.id=125
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------	
-- BOLOVANJE 3 MJESECA
----------------------
   UPDATE  kompetencije set [Bolovanje_broj3]=0,[Bolovanja_dana3]=0

   Update kompetencije
SET	
   [Bolovanje_broj3] = j.puta,
	[Bolovanja_dana3]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,3 )=1	
	--and r.id=125
	and razlog='B'  
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------	
-- BOLOVANJE 6 MJESECA
----------------------
   UPDATE  kompetencije set [Bolovanje_broj6]=0,[Bolovanja_dana6]=0

   Update kompetencije
SET	
   [Bolovanje_broj6] = j.puta,
	[Bolovanja_dana6]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where

	dbo.razlikamjeseci2( b.mjesec, b.godina ,6 )=1
	--and r.id=125
	and razlog='B'  
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------	
-- BOLOVANJE 12 MJESECA
----------------------
   UPDATE  kompetencije set [Bolovanje_broj12]=0,[Bolovanja_dana12]=0

   Update kompetencije
SET	
   [Bolovanje_broj12] = j.puta,
	[Bolovanja_dana12]=j.brojdana
FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where
	dbo.razlikamjeseci2( b.mjesec, b.godina ,12 )=1
	--and r.id=125
	and razlog='B'  
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------------------------
-- update kompetenCije neopravdanidani,puta,subote
-----------------------------------------
-- 1 MJESEC
--------------------------------------------
update Kompetencije set [Neopravdano_puta1]=0,[NeopravdaniDani1]=0,[NedolasciSubotom1]=0 
   UPDATE  kompetencije

SET	
   [NeopravdaniDani1]    = j.brojdana,
   [Neopravdano_puta1]   = j.puta,
   [NedolasciSubotom1]   = j.sn

FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,1 )=1
	and razlog='N'  
--	and r.id=125
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j

INNER JOIn kompetencije k
ON 
    j.id = k.id 
-----------------------------------------
-- 3 MJESECA    neopravdanidani,puta,subote
--------------------------------------------
update Kompetencije set [Neopravdano_puta3]=0,[NeopravdaniDani3]=0,[NedolasciSubotom3]=0 
   UPDATE  kompetencije

SET	
   [NeopravdaniDani3]    = j.brojdana,
   [Neopravdano_puta3]   = j.puta,
   [NedolasciSubotom3]   = j.sn

FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 

	dbo.razlikamjeseci2( b.mjesec, b.godina ,3 )=1
	
	and razlog='N'  
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
 

INNER JOIn kompetencije k
ON 
    j.id = k.id 

--------------------------------------------
-- 6 MJESECA  neopravdanidani,puta,subote
--------------------------------------------
update Kompetencije set [Neopravdano_puta6]=0,[NeopravdaniDani6]=0,[NedolasciSubotom6]=0 
   UPDATE  kompetencije

SET	
   [NeopravdaniDani6]    = j.brojdana,
   [Neopravdano_puta6]   = j.puta,
   [NedolasciSubotom6]   = j.sn

FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,6 )=1
	
	and razlog='N'  
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
 

INNER JOIn kompetencije k
ON 
    j.id = k.id 

----------------------------------------
-- 12 MJESECA , neopravdani dani,puta,subote
--------------------------------------------
update Kompetencije set [Neopravdano_puta12]=0,[NeopravdaniDani12]=0,[NedolasciSubotom12]=0 
   UPDATE  kompetencije

SET	
   [NeopravdaniDani12]    = j.brojdana,
   [Neopravdano_puta12]   = j.puta,
   [NedolasciSubotom12]   = j.sn

FROM
    (

	SELECT r.mt,mt.naziv mjestotroska,r.id,b.ime,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog
	from stat_bo2 b
	left join radnici_ r on r.id=b.id
	left join MjestoTroska mt on mt.id=r.mt  
    where 
	dbo.razlikamjeseci2( b.mjesec, b.godina ,12 )=1
	and razlog='N'  
    group by r.mt,mt.naziv,r.id,b.ime,firma,razlog
  
  ) j
 

INNER JOIn kompetencije k
ON 
    j.id = k.id 
----------------------------------------------------------------------
----------------------------------------
-- update kompetecnije, kasne, fali do 8, po
-----------------------------------------
-- 1 mjesec
-----------------------------------------
update Kompetencije set [PreranoOtisao1]= 0,	[Kasni1]= 0,	[NedostajeDo8sati1]=0

   UPDATE kompetencije
SET
	[PreranoOtisao1]= j.preranootisao,
	[Kasni1]= j.kasni,
	[NedostajeDo8sati1]=j.nedostaje_do8   

FROM

(

  select x1.idradnika,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8 
  from (
  
  select p.idradnika,datum, r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao else 0 end  po,case when (480-ukupno_minuta)>0 then  (480-ukupno_minuta) else 0 end nedostaje_do8
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  --and r.FixnaIsplata=0
  and r.neradi=0
  and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,1 )=1  
  --and p.datum='2017-04-03'
  -- and (480-Ukupno_minuta)>0
 --and idradnika=125
  --order by datum
 
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece


 ) j
   
INNER JOIn kompetencije k  ON  j.idradnika = k.id 
----------------------------------------
-- update kompetecnije, kasne, fali do 8, po
-----------------------------------------
-- 3 mjeseca
-----------------------------------------
update Kompetencije set [PreranoOtisao3]= 0,	[Kasni3]= 0,	[NedostajeDo8sati3]=0

   UPDATE kompetencije
SET
	[PreranoOtisao3]= j.preranootisao,
	[Kasni3]= j.kasni,
	[NedostajeDo8sati3]=j.nedostaje_do8   
FROM
(
  select x1.idradnika,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8 
  from (
  
  select p.idradnika,datum, r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao else 0 end  po,case when (480-ukupno_minuta)>0 then  (480-ukupno_minuta) else 0 end nedostaje_do8
    
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  --and r.FixnaIsplata=0
  and r.neradi=0
  and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,3 )=1  
  --and p.datum='2017-04-03'
  -- and (480-Ukupno_minuta)>0
 --and idradnika=125
  --order by datum
 
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece


 ) j
   
INNER JOIn kompetencije k  ON  j.idradnika = k.id 
---------------------------------------------------------------------
----------------------------------------
-- update kompetecnije, kasne, fali do 8, po
-----------------------------------------
-- 6 mjeseca
-----------------------------------------
update Kompetencije set [PreranoOtisao6]= 0,	[Kasni6]= 0,	[NedostajeDo8sati6]=0

   UPDATE kompetencije
SET
	[PreranoOtisao6]= j.preranootisao,
	[Kasni6]= j.kasni,
	[NedostajeDo8sati6]=j.nedostaje_do8   
FROM
(
  select x1.idradnika,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8 
  from (
  
  select p.idradnika,datum, r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao else 0 end  po,case when (480-ukupno_minuta)>0 then  (480-ukupno_minuta) else 0 end nedostaje_do8
    
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  --and r.FixnaIsplata=0
  and r.neradi=0
  and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,6 )=1  
  --and p.datum='2017-04-03'
  -- and (480-Ukupno_minuta)>0
--  and idradnika=5
  --order by datum
 
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece


 ) j
   
INNER JOIn kompetencije k  ON  j.idradnika = k.id 
---------------------------------------------------------------------
----------------------------------------
-- update kompetecnije, kasne, fali do 8, po
-----------------------------------------
-- 12 mjeseca
-----------------------------------------
update Kompetencije set [PreranoOtisao12]= 0,	[Kasni12]= 0,	[NedostajeDo8sati12]=0

   UPDATE kompetencije
SET
	[PreranoOtisao12]= j.preranootisao,
	[Kasni12]= j.kasni,
	[NedostajeDo8sati12]=j.nedostaje_do8   
FROM
(
  select x1.idradnika,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8 
  from (
  
  select p.idradnika,datum, r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao else 0 end  po,case when (480-ukupno_minuta)>0 then  (480-ukupno_minuta) else 0 end nedostaje_do8
    
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  --and r.FixnaIsplata=0
  and r.neradi=0
  and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,12 )=1  
  --and p.datum='2017-04-03'
  -- and (480-Ukupno_minuta)>0
--  and idradnika=5
  --order by datum
 
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece
 ) j
   
INNER JOIn kompetencije k  ON  j.idradnika = k.id 
---------------------------------------------------------------------
---------------------------------------------	
-- Stimulacija,satnica 1 mjesec
---------------------------------------------
   UPDATE  kompetencije set Stimulacija1=0 , Satnicabruto=0

   Update kompetencije
SET	
   Stimulacija1 = j.stimulacija,
   SatnicaBruto = j.satnicakn
FROM
    (
	
	select p.radnikid id,sum(p.stimulacija1) stimulacija,satnicakn, case when firma=1 then 'FX' else 'Tokabu' end poduzece
	from [fxsap].dbo.plansatirada p
    where 
	dbo.razlikamjeseci2( p.mjesec, p.godina ,1 )=1  
	group by p.radnikid,satnicakn,firma

  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id and j.poduzece=k.Poduzece

---------------------------------------------	
-- Stimulacija,satnica 3 mjesec
---------------------------------------------
   UPDATE  kompetencije set Stimulacija3=0 

   Update kompetencije
SET	
   Stimulacija3 = j.stimulacija   
FROM
    (
	
	select p.radnikid id,sum(p.stimulacija1) stimulacija
	from [fxsap].dbo.plansatirada p
    where 
	dbo.razlikamjeseci2( p.mjesec, p.godina ,3 )=1  
	group by p.radnikid
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------------------------
---------------------------------------------	
-- Stimulacija,satnica 6 mjeseci
---------------------------------------------
   UPDATE  kompetencije set Stimulacija6=0 

   Update kompetencije
SET	
   Stimulacija6 = j.stimulacija   
FROM
    (
	
	select p.radnikid id,sum(p.stimulacija1) stimulacija
	from [fxsap].dbo.plansatirada p
    where 
	dbo.razlikamjeseci2( p.mjesec, p.godina ,6 )=1  
	group by p.radnikid
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------	
-- Stimulacija,satnica 12 mjesec
---------------------------------------------
   UPDATE  kompetencije set Stimulacija12=0 

   Update kompetencije
SET	
   Stimulacija12 = j.stimulacija   
FROM
    (
	
	select p.radnikid id,sum(p.stimulacija1) stimulacija
	from [fxsap].dbo.plansatirada p
    where
	dbo.razlikamjeseci2( p.mjesec, p.godina ,12 )=1  
	group by p.radnikid
  
  ) j
   
INNER JOIn kompetencije k
ON 
    j.id = k.id 

---------------------------------------------------------------
-- ako nedjeljom otiđe ranije ( manje od 30 minuta , to se brise )
---------------------------------------------------------------
-- update pregledvremena 
-- set preranootisao=0 
-- where datepart(dw, datum)=7  
-- and PreranoOtisao < 30
--------------------------------------------------------------

--------------------------------------------------------------
-- Update radnog staza
--------------------------------------------------------------
update kompetencije set staz=dbo.Izracunajstaz(datumzaposlenja)



insert into kompetencije_log
(
[Id]
      ,[PrezimeIme]
      ,[Funkcija]
      ,[Projekt]
      ,[Hala]
      ,[Linija]
      ,[Vještine]
      ,[Školovanje_Posto]
      ,[Mjesto_troska]
      ,[RadnoMjesto]
      ,[Vjestina]
      ,[DatumZaposlenja]
      ,[Istek_Ugovora]
      ,[Staz]
      ,[SatnicaStara]
      ,[SatnicaNovaOd]
      ,[SatnicaBruto]
      ,[SatnicaNeto]
      ,[Godisnji_ostalo]
      ,[Godisnji_dana1]
      ,[Godisnji_dana3]
      ,[Godisnji_dana6]
      ,[Godisnji_dana12]
      ,[DolasciNedjeljom1]
      ,[DolasciNedjeljom3]
      ,[DolasciNedjeljom6]
      ,[DolasciNedjeljom12]
      ,[NedolasciNedjeljom1]
      ,[DolasciPraznikom1]
      ,[DolasciPraznikom3]
      ,[DolasciPraznikom6]
      ,[DolasciPraznikom12]
      ,[NedolasciNedjeljom3]
      ,[NedolasciNedjeljom6]
      ,[NedolasciNedjeljom12]
      ,[NedolasciSubotom1]
      ,[NedolasciSubotom3]
      ,[NedolasciSubotom6]
      ,[NedolasciSubotom12]
      ,[Bolovanje_broj1]
      ,[Bolovanje_broj3]
      ,[Bolovanje_broj6]
      ,[Bolovanje_broj12]
      ,[Bolovanja_dana1]
      ,[Bolovanja_dana3]
      ,[Bolovanja_dana6]
      ,[Bolovanja_dana12]
      ,[Stimulacija1]
      ,[Stimulacija3]
      ,[Stimulacija6]
      ,[Stimulacija12]
      ,[NedostajeDo8sati1]
      ,[NedostajeDo8sati3]
      ,[NedostajeDo8sati6]
      ,[NedostajeDo8sati12]
      ,[Kasni1]
      ,[Kasni3]
      ,[Kasni6]
      ,[Kasni12]
      ,[PreranoOtisao1]
      ,[PreranoOtisao3]
      ,[PreranoOtisao6]
      ,[PreranoOtisao12]
      ,[Neopravdano_puta1]
      ,[Neopravdano_puta3]
      ,[Neopravdano_puta6]
      ,[Neopravdano_puta12]
      ,[NeopravdaniDani1]
      ,[NeopravdaniDani3]
      ,[NeopravdaniDani6]
      ,[NeopravdaniDani12]
      ,[NormaPosto1]
      ,[NormaPosto3]
      ,[NormaPosto6]
      ,[NormaPosto12]
      ,[Napomena]
      ,[Poduzece]
	  ,korisnik
	  ,datumpromjene
)
select 
[Id]
      ,[PrezimeIme]
      ,[Funkcija]
      ,[Projekt]
      ,[Hala]
      ,[Linija]
      ,[Vještine]
      ,[Školovanje_Posto]
      ,[Mjesto_troska]
      ,[RadnoMjesto]
      ,[Vjestina]
      ,[DatumZaposlenja]
      ,[Istek_Ugovora]
      ,[Staz]
      ,[SatnicaStara]
      ,[SatnicaNovaOd]
      ,[SatnicaBruto]
      ,[SatnicaNeto]
      ,[Godisnji_ostalo]
      ,[Godisnji_dana1]
      ,[Godisnji_dana3]
      ,[Godisnji_dana6]
      ,[Godisnji_dana12]
      ,[DolasciNedjeljom1]
      ,[DolasciNedjeljom3]
      ,[DolasciNedjeljom6]
      ,[DolasciNedjeljom12]
      ,[NedolasciNedjeljom1]
      ,[DolasciPraznikom1]
      ,[DolasciPraznikom3]
      ,[DolasciPraznikom6]
      ,[DolasciPraznikom12]
      ,[NedolasciNedjeljom3]
      ,[NedolasciNedjeljom6]
      ,[NedolasciNedjeljom12]
      ,[NedolasciSubotom1]
      ,[NedolasciSubotom3]
      ,[NedolasciSubotom6]
      ,[NedolasciSubotom12]
      ,[Bolovanje_broj1]
      ,[Bolovanje_broj3]
      ,[Bolovanje_broj6]
      ,[Bolovanje_broj12]
      ,[Bolovanja_dana1]
      ,[Bolovanja_dana3]
      ,[Bolovanja_dana6]
      ,[Bolovanja_dana12]
      ,[Stimulacija1]
      ,[Stimulacija3]
      ,[Stimulacija6]
      ,[Stimulacija12]
      ,[NedostajeDo8sati1]
      ,[NedostajeDo8sati3]
      ,[NedostajeDo8sati6]
      ,[NedostajeDo8sati12]
      ,[Kasni1]
      ,[Kasni3]
      ,[Kasni6]
      ,[Kasni12]
      ,[PreranoOtisao1]
      ,[PreranoOtisao3]
      ,[PreranoOtisao6]
      ,[PreranoOtisao12]
      ,[Neopravdano_puta1]
      ,[Neopravdano_puta3]
      ,[Neopravdano_puta6]
      ,[Neopravdano_puta12]
      ,[NeopravdaniDani1]
      ,[NeopravdaniDani3]
      ,[NeopravdaniDani6]
      ,[NeopravdaniDani12]
      ,[NormaPosto1]
      ,[NormaPosto3]
      ,[NormaPosto6]
      ,[NormaPosto12]
      ,[Napomena]
      ,[Poduzece]
	  ,'Admin_stora'
	  ,getdate()

from kompetencije
where id in (

select id
from kompetencije
where id not in 
( select id from kompetencije_log)


)

	

END
