USE FeroApp ; DECLARE @TmpGrupacija varchar(50), @TmpDatumOd date, @TmpDatumDo date ; 
SET @TmpGrupacija = 'SCHAEFFLER AUSTRIA'
SET @TmpDatumOd = '2013-01-01' 
SET @TmpDatumDo = '2013-12-31'

SELECT Grupacija, LEN(Grupacija) FROM Skladista GROUP BY Grupacija

-- Prsteni ULR --
/*SELECT ID_SKL, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS Naziv, CAST(SUM(SaldoKolicina) AS Float) AS Kolicina, 
	(SELECT JM FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS JM, CAST(SUM(CijenaKom * SaldoKolicina) AS Float) AS VrijednostEUR 
	FROM StanjeULR('2199-12-31') 
	WHERE DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoKolicina > 0 
	AND Neaktivno = 0 
	AND VrstaUR = 'UlazULR'
	GROUP BY ID_SKL, ID_MAT
-- Prsteni MS --
SELECT ID_SKL, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS Naziv, CAST(SUM(SaldoKolicina) AS Float) AS Kolicina, (SELECT JM FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS JM, CAST(SUM(CijenaKom * SaldoKolicina) AS Float) AS VrijednostEUR  
	FROM StanjeULR('2199-12-31') 
	WHERE (SELECT DatumDokumenta FROM UlazniDokumenti WHERE ID_ULD = StanjeULR.Parent_ULD_ID) BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoKolicina > 0 
	AND Neaktivno = 0 
	AND VrstaUR = 'UlazMS'
	GROUP BY ID_SKL, ID_MAT
-- Prsteni IZR --
SELECT ID_SKL, ID_MAT, NazivMat, CAST(SaldoKolicina AS Float) AS Kolicina, (SELECT JM FROM Materijali WHERE ID_Mat = StanjeIZR.ID_MAT) AS JM, CAST((SaldoKolicina * (SELECT CijenaKom FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(ID_IZR, 'IZR'))) AS Float) AS VrijednostEUR 
	FROM StanjeIZR('2199-12-31') 
	WHERE (SELECT DatumDokumenta FROM UlazniDokumenti WHERE ID_ULD = (SELECT ID_ULD FROM UlazRobeDetaljnoView WHERE ID_ULR = dbo.PronadjiULR(ID_IZR, 'IZR'))) BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoKolicina > 0 
	AND Neaktivno = 0 
	AND VrstaDokumenta = 'Izdatnica'
	ORDER BY ID_SKL, ID_Mat*/

-- Šipke ULR --
/*SELECT ID_SKL, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS Naziv, CAST(SUM(SaldoTezina) AS Float) AS Kolicina, 
	(SELECT JM FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS JM, CAST(SUM(CijenaKg * SaldoTezina) AS Float) AS VrijednostEUR 
	FROM StanjeULR('2199-12-31') 
	WHERE DatumDokumenta BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoTezina > 0 
	AND Neaktivno = 0 
	AND VrstaUR = 'UlazULR'
	GROUP BY ID_SKL, ID_MAT
-- Šipke MS --
SELECT ID_SKL, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS Naziv, CAST(SUM(SaldoTezina) AS Float) AS Kolicina, 
	(SELECT JM FROM Materijali WHERE ID_Mat = StanjeULR.ID_MAT) AS JM, CAST(SUM(CijenaKg * SaldoTezina) AS Float) AS VrijednostEUR  
	FROM StanjeULR('2199-12-31') 
	WHERE (SELECT DatumDokumenta FROM UlazniDokumenti WHERE ID_ULD = StanjeULR.Parent_ULD_ID) BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoTezina > 0 
	AND Neaktivno = 0 
	AND VrstaUR = 'UlazMS'
	GROUP BY ID_SKL, ID_MAT
-- Šipke IZR --
SELECT ID_SKL, ID_MAT, NazivMat, CAST(SaldoTezina AS Float) AS Kolicina, (SELECT JM FROM Materijali WHERE ID_Mat = StanjeIZR.ID_MAT) AS JM, 
	CAST((SaldoTezina * (SELECT CijenaKg FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(ID_IZR, 'IZR'))) AS Float) AS VrijednostEUR 
	FROM StanjeIZR('2199-12-31') 
	WHERE (SELECT DatumDokumenta FROM UlazniDokumenti WHERE ID_ULD = (SELECT ID_ULD FROM UlazRobeDetaljnoView WHERE ID_ULR = dbo.PronadjiULR(ID_IZR, 'IZR'))) BETWEEN @TmpDatumOd AND @TmpDatumDo 
	AND ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoTezina > 0 
	AND Neaktivno = 0 
	AND VrstaDokumenta = 'Izdatnica'
	ORDER BY ID_SKL, ID_Mat*/