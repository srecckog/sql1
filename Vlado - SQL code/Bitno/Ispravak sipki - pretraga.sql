USE FeroApp

--UPDATE UlazRobe SET BrojPolja = 48 WHERE ID_ULR in(18484)

SELECT ID_ULR, VrstaDokumenta + ' ' + BrojDokumenta, DatumDokumenta as Datum, ID_MAT, NazivMat, BrojSarze, 
	ID_SKL, BrojPolja, MT, SaldoKolicina, SaldoTezina 
	FROM StanjeULR('2199-12-31') 
	WHERE ID_MAT = 980289
	AND ID_SKL = 118
	AND (SaldoKolicina <> 0 OR SaldoTezina <> 0)