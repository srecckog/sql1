/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_Radnika]
      ,[ID_Fink]
      ,[ID_Firme]
      ,[Ime]
      ,[SifraRM]
      ,[Hala]
      ,[RadNaStroju]
      ,[Steler]
      ,[Kontrola]
      ,[Bravar]
      ,[Pilar]
      ,[NeRadi]
  FROM [FeroApp].[dbo].[Radnici]
  where neradi=0


  select r1.*
  from radnici r
  left join [rfind].dbo.[radnici_] r1 on r.ID_Fink=r1.id
  where r.NeRadi=0


  select *
  from [rfind].dbo.[radnici_] 
  where id not in
  (
  select id_fink
 from radnici
   )


 select *
 from radnici
  where id_fink not in
  (
  select id
 from [rfind].dbo.[radnici_]
   )
   and neradi=0
   order by id_fink



   select *
   from [rfind].dbo.[radnici_] where id=219


