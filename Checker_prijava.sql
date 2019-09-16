-- registrirali se samo na porti, NIJE SE PRIJAVIO 2 PUTA U POGONU
select COUNT(*),X1.LastName,X1.FirstName
from(

select count(*) brojprijava, convert(date,e.dt) datum,e.[user] as userid,u.lastname,u.firstname
from event e
left join [user] u on u.oid=e.[user]
where e.[user] is not null 
and dt>'01/10/2017' AND  dt<'01/11/2017'
and e.EventType != 'SP23'
group by convert(date,e.dt),e.[user],u.lastname,u.firstname

)x1
left join event e on x1.userid=e.[User] and convert(date,e.dt)=x1.datum
left join reader r on r.id=e.Device_ID
WHERE e.EventType!='SP23' AND R.Door NOT IN ( 7,8,9,10)
GROUP BY X1.lastname,X1.FirstName
having count(*) <>2
order by LASTNAME,X1.FirstName


-- koliko je prošlo od zadnjeg dogaðaja
use rfind
select datediff( mi ,max(dt),getdate() )
from event

