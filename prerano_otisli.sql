/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Rbroj]
      ,[IDRadnika]
      ,[Datum]
      ,[Dosao]
      ,[Otisao]
      ,[tdoci]
      ,[totici]
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
      ,[PreranoOtisao]
  FROM [RFIND].[dbo].[PregledVremena]
  where datum='2017-02-26' and dosao!=otisao
 and preranootisao>15 and ukupno_minuta<4500
 and idradnika=705
  order by datum desc