/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 10000 [Rbroj]
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
  FROM [RFIND].[dbo].[PregledVremena]
  where IDRadnika=373
  order by datum,idradnika

  delete from PregledVremena