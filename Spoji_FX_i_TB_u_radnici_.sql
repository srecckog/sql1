

select x1.* into radnici_ from (
select cast( [Radnik id] as int)  as id,[ime x] as ime,[prezime x] as prezime,rfid,rfid2,rfidhex,cast(custid as varchar) custid,lokacija,mt,oib,[ne radi],[Radno Mjesto] as radnomjesto,'FeroImpex' as poduzece
from RadniciAT0
union all
select cast([Radnik id] as int)  as id,[ime x] as ime,[prezime x] as prezime,rfid,rfid2,rfidhex,cast(custid as varchar) custid,lokacija,mt,oib,[ne radi],[Radno Mjesto] as radnomjesto,'Tokabu' as poduzece
from RadniciTB0)  x1



use rfind
SELECT CONVERT(INT, CONVERT(VARBINARY, '1FFFFF', 2))





select id , ime ,prezime,rfid , rfidhex , lokacija , mt , radnomjesto , (ltrim(str(r11))+'-'+ltrim(str(r12))    ) as rfid2,poduzece
from (
select x11.*, convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from (
select cast([Radnikid] as int)  as id,[imex] as ime,[prezimex] as prezime,rfid, CONVERT(VARBINARY(8), cast(rfid as bigint)) as rfidhex,  convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34  , lokacija,mt,oib,[neradi],[RadnoMjesto] as radnomjesto,'FeroImpex' as poduzece
from [finkat].dbo.[Radnici] 
) x11
union all
select x11.*, convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from (
select cast([Radnikid] as int)  as id,[imex] as ime,[prezimex] as prezime,rfid, CONVERT(VARBINARY(8), cast(rfid as bigint)) as rfidhex,  convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34  , lokacija,mt,oib,[neradi],[RadnoMjesto] as radnomjesto,'FeroImpex' as poduzece
from [finkTKB].dbo.[Radnici] 
) x11
)x1
where x1.neradi=0 and x1.rfid is not null

-------------------------------->>>>>>>>>>
-- prvo sredi id
-- import radniciat0.csv, radnicitb$
-- sredi id = 8 
-------------------------------->>>>>>>>>>

update radniciat01 set [Radnik id] =[Radnik id]*1000 where [Radnik id]>1 and [Radnik id]<2
-- spoji radniciat0 i radnicitb0

select xx.*  into radnici_22 from(

select id , ime ,prezime,ltrim(str(r11)) as custid,rfid , r34 as rfidhex,lokacija , mt , radnomjesto , (ltrim(str(r11))+'-'+ltrim(str(r12))    ) as rfid2,poduzece,sifrarm
from (

select x11.*, convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from (


select  convert(int, [Radnik id])  as id,[ime x] as ime,[prezime x] as prezime,rfid, CONVERT(VARBINARY(15), cast(rfid as bigint),2) as rfidhex,  convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34  ,[sifra rm] sifrarm, lokacija,mt,oib,[ne radi],[Radno Mjesto] as radnomjesto,'FeroImpex' as poduzece
from radniciat0$
where [ne radi]='0' and rfid is not null

) x11

union all

select x11.*, convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from (
select convert(int, [Radnik id])  as id,[ime x] as ime,[prezime x] as prezime,rfid, CONVERT(VARBINARY(16), cast(rfid as bigint),2) as rfidhex,  convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34  ,[sifra rm] sifrarm, lokacija,mt,oib,[ne radi],[Radno Mjesto] as radnomjesto,'Tokabu' as poduzece
from Radnicitb$
) x11

)x1
where x1.[ne radi]=0 and x1.rfid is not null
) xx



select *
from radnici_22
where id in ( 1016,1017)


update radnici_  set id=8002 where id=8 and poduzece='FeroImpex'    -- id 8-> 8002

SELECT TOP 1000 [id]
      ,[ime]
      ,[prezime]
      ,[custid]
      ,[rfid]
      ,[rfidhex]
      ,[lokacija]
      ,[mt]
      ,[radnomjesto]
      ,[rfid2]
      ,[poduzece]
      ,[sifrarm]
  FROM [RFIND].[dbo].[radnici_]
  order by id