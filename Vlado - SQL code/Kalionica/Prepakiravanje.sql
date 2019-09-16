USE FeroApp

SELECT EPZ.BrojRN, Pro.NazivPro, EPS.Datum, (CASE EPS.Status WHEN 0 THEN 'Spremno' WHEN 1 THEN 'Isporuèeno' WHEN 2 THEN 'Daljnja obrada' WHEN 3 THEN 'Prepakiravanje' ELSE '???' END) AS Status, EPS.KolicinaOK 
	FROM EvidencijaProizvodnjeSta EPS 
		LEFT JOIN EvidencijaProizvodnjeZag EPZ ON EPS.ID_EPZ = EPZ.ID_EPZ 
		LEFT JOIN NarudzbeSta NS ON EPZ.BrojRN = NS.BrojRN 
		LEFT JOIN Proizvodi Pro ON NS.ID_Pro = Pro.ID_Pro 
	WHERE EPS.PrepakiranaStavka = 1 
		AND EPS.Status = 1 
		AND EPS.DatumStatusa BETWEEN '2016-12-01' AND '2016-12-31'