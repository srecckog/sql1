USE FeroAppTmp ; DECLARE @TmpSklMat smallint, @TmpMt varchar(1) ; SET @TmpSklMat = 118 ; SET @TmpMt = '1'

DELETE FROM TmpStatistika
DBCC CHECKIDENT(TmpStatistika, RESEED, 1)

INSERT INTO TmpStatistika (ID_Mat, Kolicina_primka, Kolicina_izdatnica, Kolicina_povrat, Vrijednost_izdatnica, Saldo_primka)
SELECT ID_Mat, 0, (CASE WHEN VrstaDokumenta = 'Povrat' THEN 0 ELSE Tezina END), (CASE WHEN VrstaDokumenta = 'Povrat' THEN Tezina ELSE 0 END), dbo.CalcVrijednostIZR(ID_IZR), 0
	FROM IzlazRobeDetaljnoView
	WHERE ID_Skl = @TmpSklMat
	AND DatumIzlaza BETWEEN '2012-01-01' AND '2012-12-31'
	AND MT = @TmpMt
	AND Kolicina <> 0

INSERT INTO TmpStatistika (ID_Mat, Kolicina_primka, Kolicina_izdatnica, Kolicina_povrat, Vrijednost_izdatnica, Saldo_primka)
SELECT ID_MAT, TezinaFaktura, 0, 0, 0, 0
	FROM UlazRobeDetaljnoView 
	WHERE ID_SKL = @TmpSklMat 
	AND DatumDokumenta BETWEEN '2012-01-01' AND '2012-12-31' 
	AND VrstaUR = 'UlazULR' 
	AND MT = @TmpMt
	AND KolicinaInventura <> 0

INSERT INTO TmpStatistika (ID_Mat, Kolicina_primka, Kolicina_izdatnica, Kolicina_povrat, Vrijednost_izdatnica, Saldo_primka)
SELECT ID_MAT, 0, 0, 0, 0, SUM(SaldoTezina)
	FROM StanjeULR('2012-12-31') 
	WHERE ID_SKL = @TmpSklMat
	AND MT = @TmpMt
	AND DatumDokumenta <= '2012-12-31' 
	AND SaldoKolicina <> 0
	GROUP BY ID_Mat
	
SELECT ID_Mat, (SELECT NazivMat FROM Materijali WHERE ID_Mat = TmpStatistika.ID_Mat) AS Naziv_Mat, (SELECT JM FROM Materijali WHERE ID_Mat = TmpStatistika.ID_Mat) AS JM, 
	SUM(Kolicina_primka) AS Nabavljeno_jm, SUM(Kolicina_izdatnica) AS Utrošeno_jm, SUM(Kolicina_povrat) AS Povrat_jm, SUM(Vrijednost_izdatnica) AS Utrošeno_kn, SUM(Saldo_primka) AS Zaliha
	FROM TmpStatistika
	GROUP BY ID_Mat
	ORDER BY ID_Mat