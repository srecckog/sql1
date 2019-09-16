USE FinkAT15;

WITH SaldoFaktura AS
(SELECT A.BrojFakture, A.SifraPartnera, A.DatumDokumenta, A.DatumDospjeca, (A.Iznos - A.IznosPoreza) AS DugujeOsnovica, A.IznosPoreza AS DugujePorez, 
	ISNULL((SELECT SUM(B.Iznos - B.IznosPoreza) FROM PrometSK B WHERE B.BrojFakture = A.BrojFakture AND B.SifraPartnera = A.SifraPartnera AND B.DatumDokumenta <= '2016-01-31' AND B.Strana = 'P'), 0) AS PotrazujeOsnovica, 
	ISNULL((SELECT SUM(B.IznosPoreza) FROM PrometSK B WHERE B.BrojFakture = A.BrojFakture AND B.SifraPartnera = A.SifraPartnera AND B.DatumDokumenta <= '2016-01-31' AND B.Strana = 'P'), 0) AS PotrazujePorez 
	FROM PrometSK A
	WHERE A.Konto = '120000' 
	AND A.Strana = 'D' 
	AND A.DatumDospjeca <= '2015-12-31')

SELECT BrojFakture, SifraPartnera, DatumDokumenta, DatumDospjeca, DATEDIFF(day, DatumDospjeca, '2016-01-31') AS BrojDana, CAST(DugujeOsnovica AS float) AS DugujeOsnovica, CAST(DugujePorez AS float) AS DugujePorez, CAST(PotrazujeOsnovica AS float) AS PotrazujeOsnovica, 
	CAST(PotrazujePorez AS float) AS PotrazujePorez, CAST((DugujeOsnovica - PotrazujeOsnovica) AS float) AS SaldoOsnovica, CAST((DugujePorez - PotrazujePorez) AS float) AS SaldoPorez, 
	CAST(DugujeOsnovica + DugujePorez - PotrazujeOsnovica - PotrazujePorez AS float) AS RazlikaBrutto
	FROM SaldoFaktura 
	WHERE (DugujeOsnovica <> PotrazujeOsnovica OR DugujePorez <> PotrazujePorez)
	AND (DugujeOsnovica + DugujePorez - PotrazujeOsnovica - PotrazujePorez) <> 0
	ORDER BY DatumDokumenta