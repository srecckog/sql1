USE FeroApp

--SELECT * FROM UlazRobeDetaljnoView WHERE ID_SKL = 127 AND VrstaUR = 'UlazULR' AND DatumUlaza < '2013-06-27' ORDER BY DatumDokumenta

UPDATE UlazniDokumenti SET JCD2 = JCD, DatumJCD2 = DatumJCD, JCD = '1500', DatumJCD = '2013-06-27' WHERE ID_ULD IN(SELECT DISTINCT ID_ULD FROM UlazRobeDetaljnoView WHERE DatumUlaza < '2013-06-26' AND ID_SKL = 127 AND VrstaUR = 'UlazULR' AND DatumUlaza < '2013-06-27')