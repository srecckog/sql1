use FeroApp

select ID_Pro, sum(KolicinaPro) AS Kolièina_pro, SUM(KolicinaPro * TezinaProKom) AS Težina, 
	SUM((CijenaProKom - (Obrada2 * CijenaObrada2) - (Obrada3 * CijenaObrada3) - (Obrada4 * CijenaObrada4) - (Obrada5 * CijenaObrada5)) * KolicinaPro * dbo.PronadjiTecaj(DatumFakture ,'EUR')) as Vrijednost
	from FaktureDetaljnoView 
	where DatumFakture between '2012-01-01' and '2012-12-31'
	and ID_Ulp is not null
	and (select id_skl from UlazProizvoda where ID_ULP = FaktureDetaljnoView.ID_Ulp) = 109
	and (select mt from IzlazRobeDetaljnoView where ID_IZR = (select ID_IZR from UlazProizvoda where ID_ULP = FaktureDetaljnoView.ID_Ulp)) = '2'
	and Obrada1 = 1
	and VrstaFakture = 'Prsteni-FX'
	GROUP BY ID_Pro
	order by ID_Pro