use rfind
select e.oid,e.dt,e.device_id,e.[user],b.badgeNo,b.ExtId
from event e
left join badge b on b.BadgeNo=e.No
where dt>='12/21/2016' and extid=1173



select *
from badge


select *
from event
where no2=3605707


