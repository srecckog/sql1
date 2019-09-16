  
  
  
  SELECT x2.lastname,x2.dan,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt,DATEDIFF(minute,x2.dosao,'12/13/2016 6:00') as minuta2
  from ( select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.dan,x1.extid1 FxId,x1.mt from (     
  select e.no RFID_Hex,m.naziv mt,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,convert(varchar,datepart(day,dt))+'.'+convert(varchar,datepart(month,dt) ) +'.'+convert(varchar,datepart(year,dt) )dan 
  from event e
  left join badge b on e.No= b.BadgeNo
  left join [dbo].[User] u on u.extid=b.extid
  left join eventtype t on e.EventType=t.Code
  left join reader r on e.device_id=r.id
  left join radnici_ ri on ri.id=u.extid
  left join mjestotroska m on ri.mt=m.id
  WHERE E.[USER] IS NOT NULL  and ( dt >='12/13/2016 00:00:00'  and dt<='12/13/2016 23:59:59'  )  AND EventType!='SP23'  and u.ExtId=1173   ) x1
  group by x1.dan,x1.lastname,x1.extid1,x1.mt ) x2
  

  select cast(datepart(hour,dt) as varchar) +':'+cast( datepart(MINUTE,dt) as varchar) as time,dt,cast(dt as time) time2
  from event e
  WHERE E.[USER] IS NOT NULL  and ( dt >='12/13/2016 00:00:00'  and dt<='12/13/2016 23:59:59'  )  AND EventType!='SP23'  



  select ri.*,mt.naziv mt,l.naziv  lokacija
  from radnici_ ri 
  left join mjestotroska mt on cast(ri.mt as int)=mt.id
  left join lokacije l on cast(ri.lokacija as int)=l.id
  WHERE ri.mt=mt.id
  --and l.naziv='P3'
  order by ri.lokacija
  