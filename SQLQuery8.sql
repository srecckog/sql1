/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[Naziv]
      ,[Grupa]
      ,[Oznaka]
      ,[Napomena]
  FROM [RFIND].[dbo].[Vjestine2]

  use rfind
  update vjestine2 set oznaka=left(naziv,25)