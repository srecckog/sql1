/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [OID]
      ,[FirstName]
      ,[LastName]
      ,[ExtId]
      ,[IsAdmin]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[User]
  where extid=686



  select u.extid,u.lastname ulastname,u.firstname uime,r.prezime,r.ime
  from [user] u
  left join radnici_ r on r.id=u.extid
  where u.lastname!=r.prezime
  order by u.lastname



  select *
  from [radnici_]
  where id in ( 1022,1014,8,1016,1020,686)


  update [user] set lastname='PAUKOVAC' ,FIRSTNAME='IVICA' WHERE EXTID=1020


