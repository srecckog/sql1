DECLARE @datum1 date= '2017-04-17';  
use rfind
select *
from evidencijaodsustva
where datum=@datum1
--where DATEDIFF(day,datum,getdate())=1
-----------------------------------------------------------
-- nezaplanirani
select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where DATEDIFF(day,datum,getdate())=1
)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
where DATEDIFF(day,e.dt,getdate())=1
)

-----------------------------------------------------------
use rfind
select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' as 'Zaplanirani (  nije dosao)',''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as 'Nedostaje (minuta)','' as 'Prerano oti�ao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where (pv.radnomjesto ='BO'  or pv.radnomjesto='GO' or pv.radnomjesto='G.O.' )
AND DATEDIFF(day,pv.datum,getdate())=1

UNION ALL

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,case when (pv.otisao=pv.dosao) then 'Nije dosao' end Napomena2,''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano oti�ao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  year(pv.otisao)=1900
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND DATEDIFF(day,pv.datum,getdate())=1
and r.id is not null

union all

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena, '' as Napomena2 ,''as 'Dosao, nije zaplanirani', pv.kasni as 'Kasni (minuta)','' as nedostaje,pv.PreranoOtisao as 'Prerano oti�ao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  ( pv.kasni>0 or pv.PreranoOtisao>0)
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND DATEDIFF(day,pv.datum,getdate())=1
and r.id is not null and r.id !=695

union all

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,pv.Napomena,'' as napomena2,'Dosao, a vodi se na bolovanju'as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano oti�ao'
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

union all

--select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena, ( rtrim(pv.Napomena)+' nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u '+cast(pv.dosao as nvarchar) +' oti�ao u '+convert(pv.otisao as nvarchar) ) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)'
-- nedostaje1 , �ista�ice
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (420-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' oti�ao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani',pv.kasni as 'Kasni (minuta)', (420-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano oti�ao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv=8
and pv.Ukupno_minuta<420
and ((420 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and DATEDIFF(day,pv.datum,getdate())=1

union all
-- nedostaje11, ostali 8 sati
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' oti�ao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (pv.PreranoOtisao + pv.kasni) as Nedostaje,'' as 'Prerano oti�ao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and pv.Ukupno_minuta<480
and ((480 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and DATEDIFF(day,pv.datum,getdate())=1

union all

-- nedostaje111, 16 sati

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 16 sati, nedostaje  '+cast( (960-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' oti�ao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (960-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano oti�ao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and ( pv.Ukupno_minuta<960 and pv.Ukupno_minuta>800)
and ((960 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and DATEDIFF(day,pv.datum,getdate())=1

order by r.mt,r.prezime,pv.datum,pv.RadnoMjesto,PV.Smjena

-----------------------------------------------------	
-- NEW nije zaplaniran a dosao
use rfind
select distinct x1.id,x1.ime,x1.prezime,x1.radnomjesto,x1.pvid
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and DATEDIFF(day,pv.datum,getdate())=1
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where sifrarm not in ('Re�ija1','Rez1')
and pv.idradnika is null
and DATEDIFF(day,pv.datum,getdate())=1
--and pv.datum='2017-03-26'
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
and sifrarm not in ('Re�ija','Rez')
--and DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2017-01-29'
--and DATEDIFF(day,e.dt,getdate())=1
and day(e.dt)=26 and month(e.dt)=3
and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto
order by r.prezime
------------------------------
--  izvje�taj kumulativni ------------
-- nisu do�li
declare @datum1 as date
set @datum1= '2017-03-29'

SELECT X1.NAZIV,X1.DATUM,X1.SMJENA,COUNT(*) Broj_odsutnih
FROM (

declare @datum1 as date
set @datum1= '2017-03-29'


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

-- ka�njenje
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
where datum='2017-03-29'
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
and sifrarm not in ('Re�ija','Rez')
) x1
left join [user] u on u.ExtId=x1.id
left join event e on e.[user]=u.oid
left join reader r on r.id=e.Device_ID
--and DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2017-01-29'
where DATEDIFF(day,e.dt,getdate()) = 1
and r.Door not in ( 7,8,9,10)
and year(e.dt)=2017 and month(e.dt)=2
group by day(e.dt),x1.id,ime,prezime,lokacija,mt,radnomjesto,poduzece,sifrarm,rv,fixnaisplata,name
order by prezime


---------------------------------------------------
where x1.id in (
select *
from [user] u
left join event e on e.oid=u.oid
where 
DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2017-01-29'

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

---- Bri�i katu�i�a
--delete from radnici_ where id=454








select *
from PregledVremena
where IDRadnika=1321


select *
from radnici_
where id=1321

select *
from radnici_ where id in (

3,
48,
86,
196,
209,
219,
255,
298,
334,
336,
349,
351,
359,
365,
367,
377,
382,
386,
403,
405,
414,
415,
416,
417,
419,
420,
422,
424,
426,
427,
428,
429,
431,
432,
433,
435,
437,
438,
440,
441,
445,
446,
448,
450,
451,
452,
453,
456,
457,
464,
465,
467,
469,
471,
473,
475,
476,
479,
480,
481,
483,
484,
485,
487,
488,
489,
490,
491,
492,
493,
494,
496,
497,
498,
499,
500,
501,
502,
503,
504,
505,
506,
507,
508,
509,
512,
514,
515,
518,
519,
520,
522,
525,
527,
528,
529,
530,
532,
534,
536,
537,
539,
540,
542,
543,
548,
549,
550,
551,
552,
555,
556,
558,
560,
561,
563,
565,
567,
568,
570,
571,
572,
574,
575,
576,
577,
578,
579,
580,
581,
583,
584,
585,
586,
587,
588,
589,
590,
593,
594,
595,
596,
598,
599,
600,
601,
603,
604,
605,
606,
607,
608,
610,
612,
613,
616,
617,
618,
620,
623,
624,
625,
626,
627,
628,
630,
632,
633,
634,
635,
637,
638,
643,
644,
646,
648,
650,
652,
653,
655,
656,
657,
658,
661,
663,
664,
665,
667,
668,
669,
672,
676,
677,
678,
679,
680,
682,
683,
685,
689,
693,
697,
698,
696,
700,
701,
703,
706,
709,
710,
712,
714,
716,
717,
722,
723,
727,
728,
729,
730,
733,
734,
735,
736,
738,
739,
740,
741,
742,
744,
745,
746,
747,
748,
749,
751,
752,
755,
757,
758,
760,
761,
762,
764,
765,
766,
767,
770,
771,
773,
776,
777,
779,
782,
783,
784,
786,
789,
791,
792,
798,
803,
805,
809,
811,
815,
816,
819,
821,
822,
825,
830,
831,
832,
836,
839,
840,
841,
844,
845,
847,
848,
851,
858,
860,
863,
869,
871,
873,
874,
877,
887,
893,
894,
899,
900,
902,
903,
904,
906,
913,
914,
918,
920,
924,
927,
930,
931,
941,
942,
943,
946,
947,
948,
949,
950,
951,
953,
955,
957,
959,
961,
962,
963,
966,
967,
968,
970,
972,
973,
974,
977,
979,
982,
986,
992,
995,
997,
999,
1000,
1001,
1004,
1005,
1006,
1008,
1011,
1012,
1018,
1027,
1029,
1036,
1041,
1042,
1045,
1048,
1051,
1053,
1056,
1059,
1064,
1065,
1068,
1073,
1079,
1084,
1086,
1090,
1093,
1094,
1098,
1099,
1105,
1106,
1114,
1119,
1128,
1129,
1130,
1132,
1136,
1140,
1142,
1146,
1147,
1148,
1150,
1153,
1154,
1158,
1159,
1162,
1167,
1171,
1172,
1179,
1183,
1187,
1196,
1215,
1219,
1221,
1222,
1226,
1231,
1232,
1245,
1255
)



select *
from pregledvremena
where idradnika=1206

delete from pregledvremena where datum='2017-3-15'


select count(*) Broj_odsutnih,smjena
from pregledvremena
where ukupno_minuta=0
and radnomjesto<>'4. SMJENA'
and datum='2017-03-15'
group by smjena
ORDER BY smjena


select sum(480-Ukupno_minuta) Prerano_otisao,smjena
from pregledvremena
where radnomjesto<>'4. SMJENA'
and datum='2017-03-15'
and ukupno_minuta<480
group by smjena
ORDER BY smjena


select *
from pregledvremena
where radnomjesto<>'4. SMJENA'
and datum='2017-03-15'
and ukupno_minuta>480
ORDER BY smjena,Ukupno_minuta


select *
from pregledvremena
where radnomjesto<>'4. SMJENA'
and datum='2017-03-15'
and idradnika=1124
ORDER BY smjena,Ukupno_minuta


select r.id,r.prezime,r.ime,pv.hala,pv.Smjena ,pv.RadnoMjesto,r.mt,pv.napomena
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
where pv.Ukupno_minuta=0
and pv.RadnoMjesto<>'4. SMJENA'
and pv.datum='2017-03-15'
and year(dosao)=1900
order by hala,mt,smjena,prezime,ime


-- Nisu se uredno prijavili
select r.id,r.prezime,r.ime,pv.dosao,pv.otisao,pv.napomena,pv.hala,pv.smjena,pv.radnomjesto
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
where datum='2017-03-20'
and Ukupno_minuta=0 and dosao=otisao
and year(dosao)!=1900
order by datum desc



select smjena,sum(480-ukupno_minuta) 'Fali Minuta'
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on r.mt=mt.id
where (480-pv.Ukupno_minuta)>0
and pv.RadnoMjesto<>'4. SMJENA'
and pv.datum='2017-03-15'
group by smjena
order by smjena



select r.prezime,r.ime,480-ukupno_minuta 'Fali Minuta'
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on r.mt=mt.id
where (480-pv.Ukupno_minuta)>0
and pv.RadnoMjesto<>'4. SMJENA'
and ukupno_minuta>0
and pv.datum='2017-03-15'
order by smjena


select smjena,sum(480-ukupno_minuta) 'Fali Minuta'
from pregledvremena pv
left join radnici_ r on r.id=pv.idradnika
left join MjestoTroska mt on r.mt=mt.id
where (480-pv.Ukupno_minuta)>0
and pv.RadnoMjesto<>'4. SMJENA'
and ukupno_minuta>0
and pv.datum='2017-03-15'
group by smjena
order by smjena



select r.id,r.prezime,r.ime,pv.dosao,pv.otisao,pv.napomena,pv.hala,pv.smjena,pv.radnomjesto
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
where datum='2017-03-15'
and Ukupno_minuta=0 and dosao=otisao
and year(dosao)!=1900
order by datum desc




@datum1 = "

-- re�ija
select *,datediff(mi,x1.dosao,x1.otisao) Ukupno_minuta,datediff(mi,'2017-03-16 07:00:00' ,x1.dosao) kasni_minuta,datediff(mi,x1.otisao,'2017-03-16 15:00:00') ranije_minuta
from (

select r.id,r.prezime,r.ime, mt.naziv MT_naziv,min(e.dt) dosao,max(e.dt) otisao
from event e
left join [User] u on u.oid=e.[user]
left join radnici_ r on r.id=u.ExtId
left join mjestotroska mt on mt.id=r.mt
where dt>='2017-03-16 0:0:0' and dt<='2017-03-16 23:59:59'
and r.FixnaIsplata=1 and r.mt not in ( 700)
group by  r.id,r.prezime,r.ime,mt.naziv
) x1
order by x1.id



select radnomjesto,id,(prezime+' '+ime) imer
from radnici_
where fixnaisplata=1 and mt not in (700)

use rfind
select * into pv1703 from pregledvremena

--delete from pregledvremena where datum='2017-03-20'


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
where datum='2017-04-12'
and idradnika=1173
order by idradnika

use rfind
delete from pregledvremena where datum='2017-04-12'
delete from evidencijaodsustva where datum='2017-04-12'

select *
from evidencijaodsustva
where datum='2017-04-04'

select *
from pregledvremena
where datum='2017-04-01' and preranootisao!=0
order by idradnika





use rfind
select distinct x1.id,x1.ime,x1.prezime,x1.radnomjesto,x1.pvid
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and pv.datum='2017-03-26'
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where sifrarm not in ('Re�ija','Rez')
and pv.idradnika is null
and day(e.dt)=26 and month(e.dt)=3
--and pv.datum='2017-03-26'
--and id=373
--and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika

) x1
order by x1.prezime

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and pv.datum='2017-03-26'
order by r.id


select rbroj,idradnika,dosao,otisao,tdoci,totici,preranootisao
from pregledvremena
where datum='2017-03-30'
and smjena=1
and preranootisao>0
order by rbroj


select pv.datum,pv.smjena,pv.hala,pv.radnomjesto,r.id,r.ime,r.prezime,r.radnomjesto,pv.ukupno_minuta,dosao,otisao
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and pv.datum>='2017-04-03'
where pv.ukupno_minuta>720
order by r.id


select *
from pregledvremena
where idradnika=447
order by datum



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





select *
from pregledvremena where datum='2017-04-12'
and smjena=1

update pregledvremena set idradnika=11730 where idradnika=1173 and datum='2017-04-12'



