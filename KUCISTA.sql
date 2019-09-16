USE FeroApp;

SELECT ENV.BrojRN, ENV.Hala, ENV.Linija, ENV.Norma, SUM(ENV.KolicinaOK) AS KolicinaOK, COUNT(*) AS BrojUnosa 
	FROM EvidencijaNormiView ENV 
	WHERE ENV.BrojRN IN(SELECT NS.BrojRN FROM NarudzbeSta NS WHERE NS.ID_NarZ IN(SELECT NZ.ID_NarZ FROM NarudzbeZag NZ WHERE NZ.ID_Par = 121273 AND NZ.VrstaNar = 'Kucista')) 
		AND DatumUnosa >= '2016-01-01' 
	GROUP BY ENV.BrojRN, ENV.Hala, ENV.Linija, ENV.Norma 
	ORDER BY ENV.BrojRN, ENV.Hala, ENV.Linija, ENV.Norma 