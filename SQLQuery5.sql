/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[Naziv]
      ,[Grupa]
      ,[Oznaka]
      ,[Napomena]
  FROM [RFIND].[dbo].[Vjestine2]


  use rfind
  insert into vjestine2 ( [id]
      ,[Naziv]
      ,[Grupa]
      
      ,[Napomena] ) 
	  select 
	  [id]
      ,[Naziv]
      ,[Grupa]
      
      ,[Napomena] 
	  from vjestine