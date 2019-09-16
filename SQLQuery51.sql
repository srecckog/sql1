select acregno  as Id,acname Ime,acsurname Prezime,j.acCostDrv Mjesto_troška,j.acDept Lokacija,d.acnumber RFID,j.acjob Radno_mjesto,'' Radni_staz,j.adDate DatumZaposlenja,'' sifra_rm,p.acstreet Ulica,acpost Pošta,'' vrijeme,accity Grad,j.acFieldSA Vrsta_isplate, adDateExit Datum_odlaska from thr_prsn p 
left join thr_prsnjob j on p.acworker = j.acworker 
left join thr_prsnadddoc d on d.acWorker = p.acworker and d.actype = 8 
where d.actype=8 and j.addateend is null 
order by cast(acregno as int)  desc 


select cast(acregno as int ) as Id,acname Ime,acsurname Prezime,j.acCostDrv Mjesto_troška,j.acDept Lokacija,d.acnumber RFID,j.acjob Radno_mjesto,'' Radni_staz,j.adDate DatumZaposlenja,'' sifra_rm,p.acstreet Ulica,acpost Pošta,'' vrijeme,accity Grad,j.acFieldSA Vrsta_isplate, adDateExit Datum_odlaska 
from thr_prsn p 
left join thr_prsnjob j on p.acworker = j.acworker 
left join thr_prsnadddoc d on d.acWorker = p.acworker and d.actype = 8 
where j.dateend is null and d.actype=8 and p.addateenter>=dateadd(d,-3,getdate()) 
order by cast(acregno as int) desc 