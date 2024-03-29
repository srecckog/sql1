/****** Script for SelectTopNRows command from SSMS  ******/

select x2.*,r.prezime,r.ime
from (
select x1.idradnika , count(*) brojnp
from(
SELECT TOP 10000 [Rbroj]
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
  FROM [RFIND].[dbo].[PregledVremena]
  where radnOmjesto not in ( 'BO','B.O.','GO','G.O.','4. SMJENA')
  AND DATUM>'01/15/2017' AND dosao='01/01/1900'
  ) x1
  group by idradnika
  having count(*)>3
  ) x2
  left join radnici_ r on r.id=x2.idradnika
  order  by x2.brojnp desc

  
  
  


  