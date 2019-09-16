/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[ime]
      ,[prezime]
      ,[rfid]
      ,[rfid2]
      ,[rfidhex]
      ,[custid]
      ,[lokacija]
      ,[mt]
      ,[oib]
      ,[ne radi]
      ,[radnomjesto]
      ,[poduzece]
      ,[RadnoVrijeme],
	  len(cast(cast( oib as bigint) as varchar) )
  FROM [RFIND].[dbo].[radnici_]
  where len(cast(cast( oib as bigint) as varchar) ) != 11