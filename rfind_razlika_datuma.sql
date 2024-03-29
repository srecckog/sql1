/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Rbroj]
      ,[IDRadnika]
      ,[Datum]
      ,[Dosao]
      ,[Otisao]
      ,[Checker]
      ,[Napomena]
      ,[Kasni]
      ,[Prekovremeni]
      ,[OdobreniPrekovremeni]
      ,[RazlogIzostanka]
      ,[Poduzece]
      ,[Smjena]
      ,[RadnoMjesto]
      ,[Hala]
      ,[Ukupno_sati]
      ,[Ukupno_minuta]
  FROM [RFIND].[dbo].[PregledVremena]


  select convert(varchar,otisao,121)   --,121,'yyyy-mm-dd hh:mi:ss.mmm(24h)')
  from pregledvremena

  select DATEDIFF(minute,convert(varchar,dosao,121),convert(varchar,otisao,121))
  from pregledvremena

  --
  delete from pregledvremena