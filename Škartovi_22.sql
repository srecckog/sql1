/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_ENR]
      ,[ID_ENZ]
      ,[ID_Radnika]
      ,[Radnik]
      ,[Napomena1]
      ,[Napomena2]
      ,[BrojSati]
      ,[UserName]
      ,[DatumUnosa]
      ,[VrijemeUnosa]
  FROM [FeroApp].[dbo].[EvidencijaNormiRadnici]
  order by datumunosa desc