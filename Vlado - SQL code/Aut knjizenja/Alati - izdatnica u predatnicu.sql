USE FeroApp

--INSERT INTO UlazProizvoda (ID_PRE, ID_Pro, ID_IZR, BrojRN, KolicinaMat, DuzinaKom, KolicinaPro, VisakPro, IznosUsluge, Tezina, ID_Skl, BrojPolja, MT, OtpadMat, OtpadObrada1, OtpadObrada2, OtpadObrada3, OtpadObrada4, OtpadObrada5, ID_NarZ, Neaktivno, FinkOK)
SELECT 5174 AS ID_PRE, (SELECT ID_Pro FROM NarudzbeSta WHERE BrojRN = StanjeIZR.BrojRN) AS ID_Pro, ID_IZR, BrojRN, SaldoKolicina, 0, 1, 0, (SELECT FakturnaCijena FROM NarudzbeSta WHERE BrojRN = StanjeIZR.BrojRN) * dbo.PronadjiTecaj('2015-12-01', 'EUR') AS Iznos, 
	SaldoTezina, 106 AS ID_SKL, 0 AS BrojPolja, '1' AS MT, 0 AS OtpadMat, 0 AS OtpadObrada1, 0 AS OtpadObrada2, 0 AS OtpadObrada3, 0 AS OtpadObrada4, 0 AS OtpadObrada5, (SELECT ID_NarZ FROM NarudzbeSta WHERE BrojRN = StanjeIZR.BrojRN) AS ID_NarZ, 
	0 AS Neaktivno, 0 AS FinkOK
	FROM StanjeIZR('2199-12-31') 
	WHERE BrojRN IN(SELECT BrojRN FROM NarudzbeDetaljnoView WHERE VrstaNar = 'Alati' AND OrderNo IN(16688833))
	AND (SaldoKolicina <> 0 OR SaldoTezina <> 0)
