USE FeroApp

/*SELECT YEAR(DatumFakture) AS Godina, MONTH(DatumFakture) AS Mjesec, CAST(SUM(KolicinaMat * TezinaMatKom) AS float) AS TezinaMat, CAST(SUM(KolicinaPro * TezinaProKom) AS float) AS TezinaPro 
	FROM FaktureDetaljnoView 
	WHERE VrstaFakture IN('Prsteni-FX', 'Prsteni-FX-P1', 'Prsteni-FX-Zona') 
	AND DatumFakture >= '2015-01-01' 
	AND VrstaTroska = 'Proizvod'
	AND ID_Ulp IS NOT NULL
	AND (SELECT ID_Par FROM UlazRobeDetaljnoView WHERE ID_Ulr = (SELECT ID_ULR FROM IzlazRobe WHERE ID_Izr = (SELECT ID_Izr FROM UlazProizvoda WHERE ID_Ulp = FaktureDetaljnoView.ID_Ulp))) = 121269
	GROUP BY YEAR(DatumFakture), MONTH(DatumFakture)
	ORDER BY YEAR(DatumFakture), MONTH(DatumFakture)*/

/*SELECT YEAR(DatumFakture) AS Godina, MONTH(DatumFakture) AS Mjesec, CAST(SUM(KolicinaMat * TezinaMatKom) AS float) AS TezinaMat, CAST(SUM(KolicinaPro * TezinaProKom) AS float) AS TezinaPro 
	FROM FaktureDetaljnoView 
	WHERE VrstaFakture IN('Prsteni-Loan', 'Prsteni-Loan-P1', 'Prsteni-Loan-Zona') 
	AND DatumFakture >= '2015-01-01' 
	AND VrstaTroska = 'Proizvod'
	AND ID_Ulp IS NOT NULL
	GROUP BY YEAR(DatumFakture), MONTH(DatumFakture)
	ORDER BY YEAR(DatumFakture), MONTH(DatumFakture)*/