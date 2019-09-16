USE FeroApp ; DECLARE @TmpGrupacija varchar(50), @TmpDatum date 

-- lista grupacija
SELECT Grupacija FROM Skladista WHERE Grupacija IS NOT NULL GROUP BY Grupacija

-- ovdje uneseš grupaciju i datum koji želiš, možeš copy/paste iz liste koju dobiješ sa SELECTOM iznad
SET @TmpGrupacija = 'SCHAEFFLER AUSTRIA'
SET @TmpDatum = '2017-06-19'

-- ovo je skrpita za repro
SELECT @TmpGrupacija AS Grupacija, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR_Kn.ID_MAT) AS Materijal, CAST(SUM(SaldoKolicina) AS Float) AS Kolièina, CAST(SUM(Vrijednost) AS Float) AS Vrijednost 
	FROM StanjeULR_Kn(@TmpDatum) 
	WHERE ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija) 
	AND SaldoKolicina <> 0
	AND VrstaUR <> 'Povrat'
	GROUP BY ID_MAT
	HAVING SUM(SaldoKolicina) <> 0

-- ovo je skrpita za gotove proizvode
DECLARE @TmpGrupacija varchar(50), @TmpDatum date 
SET @TmpGrupacija = 'SCHAEFFLER AUSTRIA'
SET @TmpDatum = '2017-08-04'



SELECT @TmpGrupacija AS Grupacija, ID_Pro, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = StanjeULP_Kn.ID_Pro) AS Proizvod, CAST(SUM(SaldoKolPro) AS Float) AS Kolièina, CAST(SUM(VrijednostPredatnice) AS Float) AS Vrijednost
	FROM StanjeULP_Kn(@TmpDatum, 0) 
	WHERE ID_Skl IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoKolPro <> 0
	GROUP BY ID_Pro
	HAVING SUM(SaldoKolPro) <> 0