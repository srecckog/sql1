/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Naziv]
      ,[Id]
      ,[Grupa]
  FROM [RFIND].[dbo].[Projekti]
  order by id