USE FeroApp ; DECLARE @TmpGrupacija varchar(50) ; SET @TmpGrupacija = 'FAG MAGYARORSZÁG'

-- Repro - primke 2013
/*SELECT @TmpGrupacija AS Grupacija, VlasnistvoFX, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR.ID_MAT) AS Materijal, 
	CAST(SUM(SaldoKolicina) AS Float) AS Saldo 
	FROM StanjeULR('2199-12-31') 
	WHERE VrstaUR <> 'Povrat' 
	AND (CASE WHEN VrstaUR = 'UlazULR' THEN DatumDokumenta ELSE (SELECT DatumDokumenta FROM UlazniDokumenti WHERE ID_ULD = StanjeULR.Parent_ULD_ID) END) <= '2013-12-31' 
	AND SaldoKolicina <> 0 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND Neaktivno = 0
	GROUP BY ID_MAT, VlasnistvoFX
	HAVING SUM(SaldoKolicina) <> 0
	ORDER BY ID_MAT */
	
/*SELECT @TmpGrupacija AS Grupacija, VlasnistvoFX, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR.ID_MAT) AS Materijal, 
	CAST(SUM(SaldoKolicina) AS Float) AS Saldo 
	FROM StanjeULR('2199-12-31') 
	WHERE VrstaUR <> 'Povrat' 
	AND (CASE WHEN VrstaUR = 'UlazULR' THEN DatumDokumenta ELSE (SELECT DatumDokumenta FROM UlazniDokumenti WHERE ID_ULD = StanjeULR.Parent_ULD_ID) END) BETWEEN '2014-01-01' AND '2014-12-31' 
	AND SaldoKolicina <> 0 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND Neaktivno = 0
	GROUP BY ID_MAT, VlasnistvoFX
	HAVING SUM(SaldoKolicina) <> 0
	ORDER BY ID_MAT	*/
	
-- Repro - gotovi proizvodi 2013
/*SELECT @TmpGrupacija AS Grupacija, VlasnistvoFX, ID_Pro, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = StanjeULP.ID_Pro) AS Proizvod, 
	CAST(SUM(SaldoKolPro) AS Float) AS Saldo
	FROM StanjeULP('2199-12-31') 
	WHERE (SELECT DatumDokumenta FROM UlazRobeDetaljnoView WHERE ID_ULR = dbo.PronadjiULR(ID_IZR, 'IZR')) <= '2013-12-31'
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND Neaktivno = 0
	GROUP BY ID_Pro, VlasnistvoFX
	HAVING SUM(SaldoKolPro) <> 0
	ORDER BY ID_Pro	*/
	
-- Repro - gotovi proizvodi 2014
/*SELECT @TmpGrupacija AS Grupacija, VlasnistvoFX, ID_Pro, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = StanjeULP.ID_Pro) AS Proizvod, 
	CAST(SUM(SaldoKolPro) AS Float) AS Saldo
	FROM StanjeULP('2199-12-31') 
	WHERE (SELECT DatumDokumenta FROM UlazRobeDetaljnoView WHERE ID_ULR = dbo.PronadjiULR(ID_IZR, 'IZR')) BETWEEN '2014-01-01' AND '2014-12-31' 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND Neaktivno = 0
	GROUP BY ID_Pro, VlasnistvoFX
	HAVING SUM(SaldoKolPro) <> 0
	ORDER BY ID_Pro */