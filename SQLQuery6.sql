/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[Naziv]
      ,[Grupa]
      ,[Napomena]
  FROM [rfind22].[dbo].[Vjestine]

  use rfind22
  select * into rfind.dbo.vjestine
  from vjestine
