--- valjcici   ( Romaina+wupertal+eltman)
select sum(kolicina) kolièina,mjesec
from (
SELECT FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture, CAST(SUM(FDV.KolicinaPro) AS float) AS Kolicina,vf.VrstaFakture,MONTH(fdv.datumfakture) mjesec,year(fdv.datumfakture) godina
       FROM FaktureDetaljnoView FDv
             LEFT JOIN Partneri PAR ON FDV.ID_Par = PAR.ID_Par 
             LEFT JOIN VrsteFaktura VF ON FDV.VrstaFakture = VF.VrstaFakture 
       WHERE FDV.DatumFakture >= '2018-01-01' 
             AND VF.Export2Pantheon = 1 
             AND FDV.KolicinaPro > 0 
             AND FDV.ID_Ulp IS NOT NULL 
			 and vf.VrstaFakture!='Valjcici-FX-P1'
			 and  FDV.ID_Par=121453
       GROUP BY FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture ,vf.VrstaFakture,MONTH(fdv.datumfakture),year(fdv.datumfakture)
	   ) x1
	   group by mjesec
       ORDER BY mjesec
-- Romania
select sum(kolicina) kolièina,mjesec
from (
SELECT FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture, CAST(SUM(FDV.KolicinaPro) AS float) AS Kolicina,vf.VrstaFakture,MONTH(fdv.datumfakture) mjesec,year(fdv.datumfakture) godina
       FROM FaktureDetaljnoView FDv
             LEFT JOIN Partneri PAR ON FDV.ID_Par = PAR.ID_Par 
             LEFT JOIN VrsteFaktura VF ON FDV.VrstaFakture = VF.VrstaFakture 
       WHERE FDV.DatumFakture >= '2018-01-01' 
             AND VF.Export2Pantheon = 1 
             AND FDV.KolicinaPro > 0 
             AND FDV.ID_Ulp IS NOT NULL 
			 AND FDV.ID_Par=121274
       GROUP BY FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture ,vf.VrstaFakture,MONTH(fdv.datumfakture),year(fdv.datumfakture)
	   ) x1
	   group by mjesec
       ORDER BY mjesec
-- BMW
select sum(kolicina) kolièina,mjesec
from (
SELECT FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture, CAST(SUM(FDV.KolicinaPro) AS float) AS Kolicina,vf.VrstaFakture,MONTH(fdv.datumfakture) mjesec,year(fdv.datumfakture) godina
       FROM FaktureDetaljnoView FDv
             LEFT JOIN Partneri PAR ON FDV.ID_Par = PAR.ID_Par 
             LEFT JOIN VrsteFaktura VF ON FDV.VrstaFakture = VF.VrstaFakture 
       WHERE FDV.DatumFakture >= '2018-01-01' 
             AND VF.Export2Pantheon = 1 
             AND FDV.KolicinaPro > 0 
             AND FDV.ID_Ulp IS NOT NULL 
			 AND FDV.ID_Par=121274
       GROUP BY FDV.ID_Par, PAR.NazivPar, FDV.DatumFakture ,vf.VrstaFakture,MONTH(fdv.datumfakture),year(fdv.datumfakture)
	   ) x1
	   group by mjesec
       ORDER BY mjesec


	   select *
	   from evidnormi('2018-02-01','2018-02-28',0)
	   where id_par=121279