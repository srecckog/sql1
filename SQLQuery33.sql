/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[Naziv]
      ,[Grupa]
      ,[Oznaka]
      ,[Napomena]
  FROM [RFIND].[dbo].[Vjestine2]
  where grupa='T'
  order by id