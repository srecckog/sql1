/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_KKSZ]
      ,[Datum]
      ,[Smjena]
      ,[ID_Radnika]
      ,[Radnik]
      ,[NapomenaCodere]
      ,[NapomenaSolo]
  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag]


  select convert( decimal(10,2),sum(ks.kolicina*ks.tezinaprokom)) ukupnatezina
  from kalionicaknjigasmjenezag kz 
  left join kalionicaknjigasmjenesta ks on ks.id_kksz =kz.ID_KKSZ
  where kz.datum>='12/20/2016'