
select p.acregno,j.adEmployedTo  datumo,mt.naziv mt,j.acfieldsb funkcija,j.acjob rm,j.addate datz,v.anvacationf1 GO_ostalo
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob j on j.acworker=p.acworker
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnvacation v on v.acworker=p.acworker
left join MjestoTroska mt on mt.id=j.accostdrv
where j.addateend is null 
AND P.ACREGNO=430
ORDER BY ACREGNO



SELECT J.*
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob j on j.acworker=p.acworker
WHERE P.ACREGNO=430
AND j.addateend is null 