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
      ,[Neradi]
      ,[FixnaIsplata]
  FROM [RFIND].[dbo].[radnici_]
  where id=1195

  update radnici_ set mt=704 where id=1195