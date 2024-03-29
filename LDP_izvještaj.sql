/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[datum]
      ,[hala]
      ,[linija]
      ,[smjena]
      ,[proizvod]
      ,[norma]
      ,[max]
      ,[cijena]
      ,[kolicina]
      ,[iznos]
      ,[radnik]
      ,[ID_Partner]
      ,[kvarovi]
      ,[bolovanja]
      ,[materijal]
      ,[alati]
      ,[izostanci]
      ,[stelanja]
      ,[stelanja_minuta]
      ,[kvarovi_minuta]
      ,[idealno]
      ,[skart_obrada]
      ,[skart_materijal]
      ,[turm]
      ,[UkupnoIspravno]

  FROM [FxApp].[dbo].[ldp_aktivnost]
  where datum='12/30/2016'
  and hala=100


  select sum(idealno) Planirano, sum(kolicina) Ostvareno,hala
  FROM [FxApp].[dbo].[ldp_aktivnost]
  where datum='12/30/2016' and  proizvod!=''
  and hala in ( 1,3,100)
  group by hala



  
SELECT  h1.hala Hala,h1.kolicina Realizirano, h1_.kolID Idealno
FROM [FxApp].[dbo].[ldp_aktivnost] h1 
left join 
(
select SUM(h11.kolicina) KOLID,h11.hala
from [FxApp].[dbo].[ldp_aktivnost] h11
 WHERE h11.proizvod=''
  and h11.datum='12/30/2016'
  and linija='IDEALNO'
  GROUP BY H11.HALA
  ) h1_ on h1.hala=h1_.hala
  where h1.linija='REALIZIRANO'
  and h1.hala=h1_.hala 
  and h1.datum='12/30/2016'

  

select SUM(h11.kolicina) Količina , kk.max1 , h11.hala
from [FxApp].[dbo].[ldp_aktivnost] h11
left join (

  select sum(hk.[max]) as max1,hk.hala
  FROM [FxApp].[dbo].[ldp_aktivnost] hk
  where hk.datum='12/30/2016' and hk.hala=100
  group by hk.hala

)kk on h11.hala=kk.hala
where h11.hala=100 and h11.datum='12/30/2016'
GROUP BY H11.HALA



select sum(max)
  FROM [FxApp].[dbo].[ldp_aktivnost]
  where datum='12/30/2016'
  and hala=100
