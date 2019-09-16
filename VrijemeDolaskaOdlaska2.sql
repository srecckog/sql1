  use rfind
  
  sql1 = "SELECT x2.lastname,x2.dan,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta " _
  from (  select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.dan,x1.extid1 FxId from ( " _
  select e.no RFID_Hex,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,convert(varchar,datepart(day,dt))+'.'+convert(varchar,datepart(month,dt) ) +'.'+convert(varchar,datepart(year,dt) )dan " _
  from event e " _
  left join badge b on e.No= b.BadgeNo " _
  left join [dbo].[User] u on u.extid=b.extid " _
  left join eventtype t on e.EventType=t.Code " _
  left join reader r on e.device_id=r.id " _
  WHERE E.[USER] IS NOT NULL  and ( dt >='" & datum1 & "' and dt<='" & datum2 & "'  )  AND EventType!='SP23'  and u.ExtId=" & id1 & " ) x1 " _
  group by x1.dan,x1.lastname,x1.extid1 ) x2 "
  


  use rfind
  SELECT x2.lastname,x2.firstname,x2.dan,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt  
  from ( select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.firstname,x1.dan,x1.extid1 FxId,x1.mt from (  
  
  select e.no RFID_Hex,m.naziv mt,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,convert(varchar,datepart(day,dt))+'.'+convert(varchar,datepart(month,dt) ) +'.'+convert(varchar,datepart(year,dt) )dan 
  from event e  
  left join badge b on e.No= b.BadgeNo  
  left join [dbo].[User] u on u.extid=b.extid  
  left join eventtype t on e.EventType=t.Code  
  left join reader r on e.device_id=r.id  
  left join radnici_ ri on ri.id=u.extid  
  left join mjestotroska m on ri.mt=m.id  
  WHERE E.[USER] IS NOT NULL  and ( dt >='12/20/2016 00:00:00'  and dt<='12/22/2016 23:59:59'  )  AND EventType!='SP23'  and u.ExtId= 1173
  and r.door not in ( 7,8,9,10)   


   ) x1
  group by x1.dan,x1.lastname,x1.firstname,x1.extid1,x1.mt ) x2



  select *
  from event
  where eventtype!='SP23'
  order by dt desc


  select *
  from reader


  select dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,e.No2 serial_number,convert(varchar,datepart(day,dt))+'.'+convert(varchar,datepart(month,dt) ) +'.'+convert(varchar,datepart(year,dt) )dan ,m.id mt
  from event e  
  left join badge b on e.No= b.BadgeNo  
  left join [dbo].[User] u on u.extid=b.extid  
  left join eventtype t on e.EventType=t.Code  
  left join reader r on e.device_id=r.id  
  left join radnici_ ri on ri.id=u.extid  
  left join mjestotroska m on ri.mt=m.id  
  WHERE E.[USER] IS NOT NULL  and ( dt >='01/01/2019 00:00:00'  and dt<='07/22/2029 23:59:59'  )  AND EventType!='SP23'  and u.ExtId= 917
  --and r.door not in ( 7,8,9,10)   
  order by e.oid



  select *
  from [dbo].[User]
  where extid IN (917,1173)
  order by lastname


  ,


  ORDER BY BADGENO


  where extid=917

  select * into badgetombstone240719
  from badgetombstone


  --delete from badge where GCRECORD=1962975749





