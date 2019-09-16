SELECT
    [user], COUNT(*)
FROM
    badge
GROUP BY
    [user]
HAVING 
    COUNT(*) > 1


SELECT
    BADGENO, COUNT(*)
FROM
    badge
GROUP BY
    BADGENO
HAVING 
    COUNT(*) > 1


SELECT u.*,b.BadgeNo,b.[user]
FROM [USER] u
left join badge b on u.oid=b.[user]
WHERE OID IN
(

SELECT
    [user] AS USER1
FROM
    badge
GROUP BY
    [user]
HAVING 
    COUNT(*) > 1
)
order by u.lastname





-----------------------------------------------
-------  provjera novog radnika ili nove kartice
------------------------------------------------
select id,prezime,ime,(ltrim(str(r11))+'-'+ltrim(str(r12))    ) as rfid2
from(
select  id,prezime,ime,convert(int,convert(varbinary,substring( r34,7,2),2))  as r11,  convert(int,convert(varbinary,substring( r34,9,15),2)) as r12 
from 
(
select id,prezime,ime, convert( varchar(16),CONVERT(VARBINARY(16), cast(rfid as bigint)),2) as r34,substring( right(convert(varchar(25),rfidhex,1),10) , 3 , 50  ) drugidio
from radnici_
where substring( right(convert(varchar(25),rfidhex,1),10) , 3 , 50  )
not in 
(
select badgeno
from badge
)
) x1
) x2

----------------------------

select id,prezime,ime,substring( right(convert(varchar(25),rfidhex,1),10) , 3 , 50  ) drugidio
from radnici_
where substring( right(convert(varchar(25),rfidhex,1),10) , 3 , 50  ) LIKE '%45D85C%'

SELECT * FROM RADNICI_


SELECT *
FROM BADGE 
WHERE [USER] =1170

--UPDATE BADGE SET [USER]=1386 WHERE [USER]=1154 AND OptimisticLockField=0
--UPDATE BADGE SET OptimisticLockField=NULL,GCRecord=NULL  WHERE [USER]=1386


select *
from badge
where badgeno like '%45D85C%'
order by badgeno

select *
from badge
where EXTID=1170
order by badgeno

delete
from badge
where badgeno like '%45D85C%'

select *
from radnici_
where convert(integer, id)  in (1054)


----------------------------------------
-- PROVJERA ULAZA
----------------------------------------
SELECT U.EXTID,U.*,E.Dt
FROM EVENT E
LEFT JOIN [USER] U ON U.OID=E.OID
WHERE U.EXTID IN (
1212,
1295,
690,
1180,
472,
1217,
531,
1070,
721,
808,
934,
1110,
36,
27,
838,  
768,
1149,
1228
)
ORDER BY U.EXTID