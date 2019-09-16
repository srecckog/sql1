use fxsap
select pr.radnikid,pr.firma,dan05,dan12,dan19,dan26
from plansatirada pr
where pr.mjesec=2 and pr.godina=2017
and pr.RadnikID=155
order by pr.radnikid


use fxsap
select pr.*,pv.Ukupno_minuta
from plansatirada pr
left join [rfind].dbo.pregledvremena pv on pv.idradnika=pr.radnikid
where pr.mjesec=2 and pr.godina=2017
and pr.RadnikID=155
order by pr.radnikid


use rfind
select x1.* ,pr.Dan05,pr.Dan12,pr.Dan19,pr.Dan26
from (
select idradnika,r.prezime+' '+r.ime as ime,datum,smjena,hala,pv.radnomjesto,dosao,otisao,napomena,ukupno_minuta, (480-ukupno_minuta) razlika
from pregledvremena pv
left join radnici_ r on r.id=pv.IDRadnika
where month(datum)=2 
and  DATEPART(dw,datum)=7
) x1


left join [fxsap].dbo.PlanSatiRada pr on pr.RadnikID=x1.IDRadnika 
where pr.RadnikID=x1.IDRadnika
order by x1.ime , x1.idradnika , x1.datum


use fxsap
select pr.firma,radnikid,pr.ime,dan05,dan12,dan19,dan26
from plansatirada pr
where pr.mjesec=2 and pr.godina=2017
order by pr.ime



use rfind
select x1.* 
from (
select idradnika,r.prezime+' '+r.ime as ime,datum,smjena,hala,pv.radnomjesto,dosao,otisao,napomena,ukupno_minuta, (480-ukupno_minuta) razlika
from pregledvremena pv
left join radnici_ r on r.id=pv.IDRadnika
where month(datum)=2 
and  DATEPART(dw,datum)=7
) x1
order by x1.ime, datum



select *
from pregledvremena
where idradnika=155 and datum='2017-02-05'
order by idradnika,datum asc

