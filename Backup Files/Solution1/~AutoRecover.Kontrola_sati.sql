use rfind
select *
from pregledd
where radnomjesto<>'4. SMJENA' AND radnomjesto<>'BO'


use fxsap
select *
from plansatirada
where radnikid=10 and mjesec=2 and godina=2017


use fxsap
select firma,radnikid,ime,dan05,dan12,dan19,dan26
from plansatirada
where radnikid=10 and mjesec=2 and godina=2017


use rfind
select x1.*
 from( 
 select idradnika, r.prezime + ' ' + r.ime as ime, datum, smjena, hala, pv.radnomjesto, dosao, otisao, napomena, ukupno_minuta, (480 - ukupno_minuta) razlika 
 from pregledvremena pv 
 left join radnici_ r on r.id = pv.IDRadnika 
 where month(datum) = 2  and  DATEPART(dw, datum) =7 and year(datum) =2017 ) x1 
 order by x1.idradnika, datum


 select * into pv0903
 from pregledvremena


 select *
 from pregledvremena
 where datum='2017-02-05'
 order by idradnika


--delete from pregledvremena where datum='2017-02-05'



use fxsap
select pr.*,n.Napomena,n.Vrsta,n.DanNapomene
from plansatirada pr
left join plansatiradanapomene n on pr.PsrID=n.PsrID
where pr.RadnikID=795 and pr.mjesec=2 and pr.godina=2017