------------------------
update radnici_ set neradi=j.neradi,datumprestanka=j.addateend,mt=j.mt1

select j.*
from
(
select acregno,case when l.addateend is not null then 1 else 0 end  neradi,l.accostdrv mt1,l.addateend
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join ( select acworker,max(anid) anid from [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob group by acworker ) j on j.acworker=p.acworker
inner join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob  l on j.acworker=l.acworker and j.anid=l.anid
where l.addateend is null 
--where addateexit is not null
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Feroimpex' 
and k.id = j.acregno
and k.id=430