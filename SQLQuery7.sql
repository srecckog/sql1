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
  where id=1200


  where prezime like '%kantarević'