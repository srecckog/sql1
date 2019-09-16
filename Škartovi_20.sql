use FxApp
select x1.*,(x1.skart_obrada/x1.ukupna_kolicina) posto_skarta_obrade,convert( decimal, (x1.skart_materijal/x1.ukupna_kolicina)) posto_skarta_materijala
from(

select id_partner,p.NazivPar,sum(skart_obrada) skart_obrada,sum(skart_materijal) skart_materijal,sum(kolicinA) ukupna_kolicina
from ldp_aktivnost l
left join Partneri p on p.ID_Par=l.ID_Partner
where datum='2017-02-20'
and id_partner>0
group by id_partner,p.NazivPar
) x1



use FxApp
select id_partner,sum(kolicina)
from ldp_aktivnost l
where datum='2017-02-20'
and id_partner>0
group by id_partner
