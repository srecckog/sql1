USE FeroApp

--INSERT INTO TmpJcdTable (ID_Mat, ID_Skl, Saldo, JCD, DatumJCD, Vrsta)
--	SELECT ID_MAT, ID_SKL, SaldoKolicina, JCD, DatumJCD, 'Primka' FROM StanjeULR('2199-12-31') WHERE ID_SKL IN(108,125,127,150) AND SaldoKolicina <> 0 AND VrstaUR <> 'Povrat'

--INSERT INTO TmpJcdTable (ID_Mat, ID_Skl, Saldo, JCD, DatumJCD, Vrsta)
--	SELECT ID_MAT, ID_SKL, SaldoKolicina, JCD, DatumJCD, 'Izdatnica' FROM StanjeIZR('2199-12-31') WHERE ID_SKL IN(108,125,127,150) AND SaldoKolicina <> 0 AND VrstaDokumenta IN('Izdatnica','Otpremnica')

--INSERT INTO TmpJcdTable (ID_Mat, ID_Skl, Saldo, JCD, DatumJCD, Vrsta)
--	SELECT (SELECT ID_MAT FROM IzlazRobe WHERE ID_IZR = StanjeULP.ID_IZR) AS ID_MAT, ID_SKL, SaldoKolMat, (SELECT JCD FROM IzlazRobeDetaljnoView WHERE ID_IZR = StanjeULP.ID_IZR) AS JCD, 
--		(SELECT DatumJCD FROM IzlazRobeDetaljnoView WHERE ID_IZR = StanjeULP.ID_IZR) AS DatumJCD, 'Predatnica' 
--		FROM StanjeULP('2199-12-31') WHERE ID_SKL IN(109,126,128,151) AND SaldoKolMat > 0 AND SaldoKolPro > 0