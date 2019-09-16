USE FeroApp ; DECLARE @TmpDatum date ; SET @TmpDatum = '2013-12-21'

SELECT ID_SKL, ID_MAT, (SELECT ID_Mat_Dob FROM Materijali WHERE ID_MAT = StanjeULR.ID_MAT) AS SAP_šifra, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR.ID_MAT) AS Naziv, 
	BrojSarze, SUM(SaldoKolicina) AS Kolièina 
	FROM StanjeULR(@TmpDatum) 
	WHERE ID_SKL = 358 
	AND DatumUlaza <= @TmpDatum
	AND SaldoKolicina <> 0 
	GROUP BY ID_SKL, ID_MAT, BrojSarze

SELECT ID_SKL, ID_MAT, (SELECT ID_Mat_Dob FROM Materijali WHERE ID_MAT = StanjeIZR.ID_MAT) AS SAP_šifra, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeIZR.ID_MAT) AS Naziv, 
	BrojSarze, SUM(SaldoKolicina) AS Kolièina 
	FROM StanjeIZR(@TmpDatum) 
	WHERE ID_SKL = 358 
	AND SaldoKolicina <> 0 
	AND VrstaDokumenta = 'Izdatnica' AND DatumIzlaza <= @TmpDatum
	GROUP BY ID_SKL, ID_MAT, BrojSarze
	
SELECT ID_Skl, ID_Pro, (SELECT ID_Pro_Kup FROM Proizvodi WHERE ID_Pro = StanjeULP.ID_Pro) AS SAP_šifra, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = StanjeULP.ID_Pro) AS Naziv,
	BrojSarze, SUM(SaldoKolPro) AS Kolièina
	FROM StanjeULP(@TmpDatum) 
	WHERE ID_Skl = 359 
	AND DatumDokumenta <= @TmpDatum
	AND SaldoKolPro <> 0
	GROUP BY ID_Skl, ID_Pro, BrojSarze