use rfind
select * 
from radnici_
where id in (
162,
169,
261,
353,
430,
533,
640,
684,
695,
705,
720,
754,
774,
775,
781,
879,
909,
923,
991,
1020,
1035,
1074,
1149,
1182,
1195,
1300,
1307,
1323,
1334
)

delete from radnici_ where id=923 and mt=703
delete from radnici_ where id=991 and mt=710
delete from radnici_ where id=1020 and rv=1
delete from radnici_ where id=1035 and rv=1
delete from radnici_ where id=1074 and rv=1
delete from radnici_ where id=1149 and custid=19
delete from radnici_ where id=1182 and rv=1
delete from radnici_ where id=1195 and mt=704
delete from radnici_ where id=1300 and rfid=541167962261
delete from radnici_ where id=1307 and custid='59'
delete from radnici_ where id=1323 and lokacija=500
delete from radnici_ where id=1334 and lokacija=500
