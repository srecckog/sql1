USE FeroApp ; DECLARE @TmpIdSkl smallint, @TmpIdMat int ; SET @TmpIdSkl = 118 ; SET @TmpIdMat = 980270

SELECT ID_ULR, 'ULR' AS Tip, VrstaDokumenta, BrojDokumenta, DatumDokumenta, 
	(CASE WHEN ID_SKL = @TmpIdSkl THEN KolicinaInventura ELSE 0 END) AS Ulaz,
	(CASE WHEN Parent_SKL_ID = @TmpIdSkl THEN KolicinaInventura ELSE 0 END) AS Izlaz,
	ID_SKL, Parent_SKL_ID
	FROM UlazRobeDetaljnoView 
	WHERE ID_MAT = @TmpIdMat
	AND (ID_SKL = @TmpIdSkl OR Parent_SKL_ID = @TmpIdSkl)
	AND ID_SKL <> Parent_SKL_ID
	AND VrstaUR <> 'Povrat'
UNION
SELECT ID_URK, 'URK', 'Korekcija', BrojDokumenta, DatumKorekcije, Kolicina, 0,
	ID_SKL, 0 
	FROM UrkDetaljnoView 
	WHERE ID_Mat = @TmpIdMat
	AND ID_SKL = @TmpIdSkl 
UNION
SELECT ID_IZR, 'IZR', VrstaDokumenta, BrojDokumenta, DatumIzlaza, 0, (CASE WHEN VrstaDokumenta = 'Povrat' THEN Kolicina * -1 ELSE Kolicina END),
	ID_SKL, 0 
	FROM IzlazRobeDetaljnoView 
	WHERE ID_Mat = @TmpIdMat
	AND ID_SKL = @TmpIdSkl 
	AND VrstaDokumenta <> 'Otpad'
UNION	
SELECT ID_IRK, 'IRK', 'Korekcija', BrojDokumenta, DatumKorekcije, Kolicina, 0,
	ID_SKL, 0 
	FROM IrkDetaljnoView 
	WHERE ID_Mat = @TmpIdMat
	AND ID_SKL = @TmpIdSkl 
	AND Calc2StanjeULR = 1
ORDER BY DatumDokumenta