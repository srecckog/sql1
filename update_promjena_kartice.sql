/****** Script for SelectTopNRows command from SSMS  ******/
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
      ,[rv]
  FROM [RFIND].[dbo].[radnici_]
  order by prezime

  --kovač stjepan
  use rfind
  update radnici_ set rfid=541167962938, rfidhex='0000007E001FCB3A', custid='126' ,rfid2='126-2083642' where id=1149
  update badge set badgeno='001FCB3A', CUSTOMCARDID='126' WHERE EXTID=1149


  select *
  from [User]
  where extid=1173

  select *
  from badge
  where extid in ( 1173,1149)


  select *
  from badge
  where badgeno='001FCB3A'

  SELECT *
  FROM RADNICI_
  where id in (1173,1149)


select *
from 
[dbo].[AxsGroupUser]
where users in (1173,1149)



