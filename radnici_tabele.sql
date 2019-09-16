
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




use rfind
select * into RADNICIAT0
from (
select id , ime ,prezime,rfid , rfidhex , lokacija , mt , radnomjesto , (ltrim(str(r11))+'-'+ltrim(str(r12))    ) as rfid2,poduzece
from (
select x11.*, convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from (
select cast([Radnikid] as int)  as id,[imex] as ime,[prezimex] as prezime,rfid, CONVERT(VARBINARY(8), cast(rfid as bigint)) as rfidhex,  convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34  , lokacija,mt,oib,[neradi],[RadnoMjesto] as radnomjesto,'FeroImpex' as poduzece
from [finkat].dbo.[Radnici] 
) x11
)x1
where x1.neradi=0 and x1.rfid is not null
) x2



use rfind
select * into RADNICITB0
from (
select id , ime ,prezime,rfid , rfidhex , lokacija , mt , radnomjesto , (ltrim(str(r11))+'-'+ltrim(str(r12))    ) as rfid2,poduzece
from (
select x11.*, convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from (
select cast([Radnikid] as int)  as id,[imex] as ime,[prezimex] as prezime,rfid, CONVERT(VARBINARY(8), cast(rfid as bigint)) as rfidhex,  convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34  , lokacija,mt,oib,[neradi],[RadnoMjesto] as radnomjesto,'FeroImpex' as poduzece
from [finktkb].dbo.[Radnici] 
) x11
)x1
where x1.neradi=0 and x1.rfid is not null
) x2


