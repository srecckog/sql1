/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Idradnika]
      ,[idvjestine]
      ,[Vrijednost]
      ,[Firma]
  FROM [RFIND].[dbo].[RadniciVjestine]


  select *
  from rfind.dbo.vjestine
  order by grupa
