/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 100000 [OID]
      ,[No]
      ,[No2]
      ,[Dt]
      ,[IsPaired]
      ,[User]
      ,[Device_ID]
      ,[EventType]
      ,[TnaEvent]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[Event]
  order by dt desc



  select *
  from badge



  update event set [user] =
  (
  select oid
  from [user] u
  left join badge b on u.oid=b.[user]
    )