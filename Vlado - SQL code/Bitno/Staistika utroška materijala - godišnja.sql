USE FeroAppTmp

SELECT ID_MAT, ID_SKL, MT, SUM(CASE WHEN ID_SKL IN(112,118) THEN SaldoTezina ELSE SaldoKolicina * TezinaKomDok END) AS TezinaPS, 0 AS TezinaUlaz, 0 AS TezinaIzlaz, 0 AS VrijednostIzlaz
	INTO Statistika_2014 
	FROM StanjeULR('2013-12-31') 
	WHERE VrstaUR <> 'Povrat' 
	AND SaldoKolicina > 0 
	AND DatumUlaza <= '2013-12-31'
	GROUP BY ID_MAT, ID_SKL, MT

INSERT INTO Statistika_2014 (ID_MAT, ID_SKL, MT, TezinaPS, TezinaUlaz, TezinaIzlaz, VrijednostIzlaz)
SELECT ID_MAT, ID_SKL, MT, 0, CASE WHEN ID_SKL IN(112,118) THEN TezinaFaktura ELSE KolicinaInventura * TezinaKomInv END, 0, 0
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31' 
	AND VrstaUR = 'UlazULR' 

INSERT INTO Statistika_2014 (ID_MAT, ID_SKL, MT, TezinaPS, TezinaUlaz, TezinaIzlaz, VrijednostIzlaz)
SELECT ID_MAT, ID_SKL, MT, 0, CASE WHEN ID_SKL IN(112,118) THEN TezinaFaktura ELSE KolicinaInventura * TezinaKomInv END, 0, 0
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31' 
	AND VrstaUR = 'UlazMS' 
	AND (ID_SKL <> Parent_SKL_ID OR MT <> (SELECT MT FROM UlazRobe WHERE ID_ULR = UlazRobeDetaljnoView.Parent_ULR_ID))

INSERT INTO Statistika_2014 (ID_MAT, ID_SKL, MT, TezinaPS, TezinaUlaz, TezinaIzlaz, VrijednostIzlaz)
SELECT ID_MAT, Parent_SKL_ID, (SELECT MT FROM UlazRobe WHERE ID_ULR = UlazRobeDetaljnoView.Parent_ULR_ID), 0, CASE WHEN ID_SKL IN(112,118) THEN TezinaFaktura * -1 ELSE KolicinaInventura * TezinaKomInv * -1 END, 0, 0
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31' 
	AND VrstaUR = 'UlazMS' 
	AND (ID_SKL <> Parent_SKL_ID OR MT <> (SELECT MT FROM UlazRobe WHERE ID_ULR = UlazRobeDetaljnoView.Parent_ULR_ID))

INSERT INTO Statistika_2014 (ID_MAT, ID_SKL, MT, TezinaPS, TezinaUlaz, TezinaIzlaz, VrijednostIzlaz)
SELECT ID_MAT, ID_SKL, MT, 0, KolicinaInventura * TezinaKomInv * -1, 0, 0 FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID IN(SELECT ID_ULR
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31' 
	AND VrstaUR = 'UlazMS' 
	AND (ID_SKL <> Parent_SKL_ID OR MT <> (SELECT MT FROM UlazRobe WHERE ID_ULR = UlazRobeDetaljnoView.Parent_ULR_ID)))
	AND DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31'

INSERT INTO Statistika_2014 (ID_MAT, ID_SKL, MT, TezinaPS, TezinaUlaz, TezinaIzlaz, VrijednostIzlaz)	
SELECT ID_MAT, (SELECT ID_SKL FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR( UlazRobeDetaljnoView.Parent_ULR_ID, 'ULR')), (SELECT MT FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR( UlazRobeDetaljnoView.Parent_ULR_ID, 'ULR')), 0, KolicinaInventura * TezinaKomInv, 0, 0 FROM UlazRobeDetaljnoView WHERE Parent_ULR_ID IN(SELECT ID_ULR
	FROM UlazRobeDetaljnoView 
	WHERE DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31' 
	AND VrstaUR = 'UlazMS' 
	AND (ID_SKL <> Parent_SKL_ID OR MT <> (SELECT MT FROM UlazRobe WHERE ID_ULR = UlazRobeDetaljnoView.Parent_ULR_ID)))
	AND DatumDokumenta BETWEEN '2014-01-01' AND '2014-12-31'	

INSERT INTO Statistika_2014 (ID_MAT, ID_SKL, MT, TezinaPS, TezinaUlaz, TezinaIzlaz, VrijednostIzlaz)
SELECT ID_Mat, ID_SKL, (SELECT MT FROM UlazRobe WHERE ID_ULR = IzlazRobeDetaljnoView.ID_ULR) AS MT, 0, CASE WHEN VrstaDokumenta = 'Povrat' THEN (CASE WHEN ID_SKL IN(112,118) THEN Tezina ELSE Kolicina * (SELECT TezinaKomInv FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(IzlazRobeDetaljnoView.ID_ULR, 'ULR')) END) ELSE 0 END, 
	CASE WHEN VrstaDokumenta = 'Povrat' THEN 0 ELSE (CASE WHEN ID_SKL IN(112,118) THEN Tezina ELSE Kolicina * (SELECT TezinaKomInv FROM UlazRobe WHERE ID_ULR = dbo.PronadjiULR(IzlazRobeDetaljnoView.ID_ULR, 'ULR')) END) END, 
	CASE WHEN VrstaDokumenta = 'Povrat' THEN dbo.CalcVrijednostIZR(ID_IZR) * -1 ELSE dbo.CalcVrijednostIZR(ID_IZR) END
	FROM IzlazRobeDetaljnoView 
	WHERE DatumIzlaza BETWEEN '2014-01-01' AND '2014-12-31'
