/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Idradnika]
      ,[idvjestine]
      ,[Vrijednost]
      ,[Firma]
  FROM [RFIND].[dbo].[RadniciVjestine2]


  use rfind
  insert into radnicivjestine2( [Idradnika]
      ,[idvjestine]
      ,[Firma])

	  select  [Idradnika]
      ,[idvjestine]
      ,[Firma]
	  from radnicivjestine


	  update [RFIND].[dbo].[RadniciVjestine2] set vrijednost=1 