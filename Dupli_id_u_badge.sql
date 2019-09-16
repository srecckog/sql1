/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [OID]
      ,[FirstName]
      ,[LastName]
      ,[ExtId]
      ,[IsAdmin]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[User]
  where extid in (8,46,1208,1193,1075,1022,1020,1016,1014)