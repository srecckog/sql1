/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [rbroj]
      ,[hala]
      ,[radnapozicija]
      ,[smjena1]
      ,[smjena2]
      ,[smjena3]
      ,[bolovanje]
      ,[godišnji]
      ,[Grupa]
  FROM [RFIND].[dbo].[PlanDjelatnika11]


  update plandjelatnika31 set grupa =1 where rbroj>=1 and rbroj <=52
  update plandjelatnika31 set grupa =2 where rbroj>=53 and rbroj <=136
  update plandjelatnika31 set grupa =3 where rbroj>=137 and rbroj <=148
  update plandjelatnika31 set grupa =6 where rbroj>=149 and rbroj <=153
  update plandjelatnika31 set grupa =4 where rbroj>=154 and rbroj <=161
  update plandjelatnika31 set grupa =5 where rbroj>=162 and rbroj <=170
  update plandjelatnika31 set grupa =7 where rbroj>=171 and rbroj <=191
  update plandjelatnika31 set grupa =3 where rbroj>=192 and rbroj <=211

    
  update plandjelatnika22 set grupa =1 where rbroj>=1 and rbroj <=52
  update plandjelatnika22 set grupa =2 where rbroj>=53 and rbroj <=136
  update plandjelatnika22 set grupa =3 where rbroj>=137 and rbroj <=148
  update plandjelatnika22 set grupa =6 where rbroj>=149 and rbroj <=153
  update plandjelatnika22 set grupa =4 where rbroj>=154 and rbroj <=161
  update plandjelatnika22 set grupa =5 where rbroj>=162 and rbroj <=170
  update plandjelatnika22 set grupa =7 where rbroj>=171 and rbroj <=191
  update plandjelatnika22 set grupa =3 where rbroj>=192 and rbroj <=211

  
  