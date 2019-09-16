USE FeroAppTmp

DECLARE @DatumNeaktivnosti date, @DatumDokumenta date
SET @DatumNeaktivnosti = '2013-12-31' 
SET @DatumDokumenta    = '2013-11-31'

UPDATE UlazRobe SET DatumNeaktivnosti = @DatumNeaktivnosti WHERE ID_ULR IN(SELECT ID_ULR
	FROM StanjeULR(@DatumNeaktivnosti) 
	WHERE DatumNeaktivnosti = '2199-12-31' 
	AND DatumUlaza <= @DatumDokumenta 
	AND (CASE WHEN VrstaOtpisa = 'Komadno' THEN SaldoKolicina ELSE SaldoTezina END) = 0 
	AND (SELECT COUNT(*) FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID = StanjeULR.ID_ULR AND DatumDokumenta > @DatumNeaktivnosti) = 0 
	AND (SELECT COUNT(*) FROM UlazRobeDetaljnoView AS Ulr1 WHERE Ulr1.Parent_ULR_ID IN(SELECT Ulr2.Parent_ULR_ID FROM UlazRobeDetaljnoView AS Ulr2 WHERE Ulr2.Parent_ULR_ID = StanjeULR.ID_ULR) AND DatumDokumenta > @DatumNeaktivnosti) = 0 
	AND (SELECT COUNT(*) FROM UrkDetaljnoView WHERE ID_ULR = StanjeULR.ID_ULR AND DatumKorekcije > @DatumNeaktivnosti) = 0 
	AND (SELECT COUNT(*) FROM IzlazRobeDetaljnoView WHERE ID_ULR = StanjeULR.ID_ULR AND DatumIzlaza > @DatumNeaktivnosti) = 0 
	AND (SELECT COUNT(*) FROM IrkDetaljnoView WHERE ID_ULR = StanjeULR.ID_ULR AND DatumKorekcije > @DatumNeaktivnosti AND Calc2StanjeULR = 1) = 0 
	AND VrstaUR IN('UlazULR', 'UlazMS'))