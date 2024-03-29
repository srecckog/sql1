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
      ,[DatumUnosa]
  FROM [RFIND].[dbo].[pregledvremena2]
  order by datum desc



  --delete from pregledvremena2


  select p.rbr,
   from plandjelatnika22 p
   left join pregledvremena2  pv2 on pv2.hala=p.hala 


    select hala,p2.radnomjesto,case when p2.smjena='1' then (r.prezime+' '+r.ime+' ( '+ltrim(str(r.id))+' )') end smjena1,case when p2.smjena='2' then (r.prezime+' '+r.ime+' ( '+ltrim(str(r.id))+' )') end smjena2,case when p2.smjena='3' then (r.prezime+' '+r.ime+' ( '+ltrim(str(r.id))+' )') end smjena3
    from pregledvremena2 p2
	left join radnici_ r on r.id=p2.idradnika


