/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[BrojFakture]
      ,[SifraPartnera]
      ,[DatumDokumenta]
      ,[DatumDospjeca]
      ,[IznosKn]
      ,[IznosEUR]
  FROM [FinkAT15].[dbo].[TmpFakture]
  where brojfakture='1-1-701'


  select *
  from prometsk
  where brojfakture='1-1-701'