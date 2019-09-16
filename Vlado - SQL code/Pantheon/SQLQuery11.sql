USE FeroApp

SELECT EvidencijaNormiView.BrojRN, (CASE WHEN NS.Obrada1 = 1 THEN 'Tokarenje' WHEN NS.Obrada2 = 1 THEN 'Kaljenje' WHEN NS.Obrada3 = 1 THEN 'Tvrdo tok.' WHEN NS.Obrada4 = 1 THEN 'Brušenje' WHEN NS.Obrada5 = 1 THEN 'Obrada #5' ELSE 'Tokarenje' END) AS Obrada, 
	EvidencijaNormiView.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, NS.KolicinaNar, SUM(EvidencijaNormiView.KolicinaOK) AS Potokareno_steleri, 
	ISNULL(SSEP.NapravljenoPro, 0) AS Potokareno_kontrola, ISNULL(SSEP.IsporucenoPro, 0) AS Isporuceno_kontrola, ISNULL(SSEP.SpremnoPro, 0) AS Spremno_kontrola, MAX(EvidencijaNormiView.Datum) AS ZadnjiDatum
	FROM EvidencijaNormiView 
	  INNER JOIN Proizvodi ON EvidencijaNormiView.ID_Pro = Proizvodi.ID_Pro 
	  INNER JOIN NarudzbeSta NS ON EvidencijaNormiView.BrojRN = NS.BrojRN 
	  INNER JOIN NarudzbeZag ON NS.ID_NarZ = NarudzbeZag.ID_NarZ 
	  FULL OUTER JOIN SumeStatusaEvidPro(9) SSEP ON EvidencijaNormiView.BrojRN = SSEP.BrojRN 
	WHERE EvidencijaNormiView.BrojRN IN(SELECT NarudzbeDetaljnoView.BrojRN FROM NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.ID_Par = 274 AND NarudzbeDetaljnoView.Isporuceno = 0) 
	  AND (CASE Proizvodi.ZavrsnaObrada WHEN 'Glodanje' THEN EvidencijaNormiView.ObradaB WHEN 'Busenje' THEN EvidencijaNormiView.ObradaC ELSE EvidencijaNormiView.ObradaA END) = 1 
	  AND NarudzbeZag.VrstaNar = 'Prsteni' 
	GROUP BY EvidencijaNormiView.BrojRN, EvidencijaNormiView.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, NS.KolicinaNar, NS.Obrada1, NS.Obrada2, NS.Obrada3, NS.Obrada4, NS.Obrada5, SSEP.NapravljenoPro, SSEP.IsporucenoPro, SSEP.SpremnoPro 