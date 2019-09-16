/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 100000 [acPost]
      ,[acName]
      ,[anKm]
      ,[acRegion]
      ,[adTimeIns]
      ,[anUserIns]
      ,[adTimeChg]
      ,[anUserChg]
      ,[acAdmUnit]
      ,[anLatitude]
      ,[anLongitude]
      ,[acTaxOfficeCro]
      ,[anQId]
      ,[acMunicipCode]
  FROM [PantheonFxAt].[dbo].[tHE_SetPostCode]

  USE RFIND
  select *
  from radnici_
  where prezime like '%MICK%'