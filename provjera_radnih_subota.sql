select distinct cast(e.dt as date ) ,DATENAME(dw, e.dt)
from [user] u
left join event e on e.[User]=u.OID
where extid=474
and DATEpart(dw, e.dt)=6
order by cast(e.dt as date ) desc
--order by dt desc


--SELECT DATEPART(dw,GETDATE()) -- 
--SELECT DATENAME(dw,GETDATE()) -- Friday