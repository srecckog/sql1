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
  order by id



  delete from radnici_ where id=78 and custid='16'