USE FeroAppArh2015;

WITH MyTmpTable AS(
SELECT *, (select UlazRobe.TezinaKomDok from UlazRobe where UlazRobe.ID_ULR = IzlazRobeDetaljnoView.ID_ULR) as TezinaKom FROM IzlazRobeDetaljnoView WHERE ID_SKL = 521 AND DatumIzlaza BETWEEN '2015-01-01' AND '2015-12-31' AND VrstaDokumenta <> 'Povrat')
SELECT sum(IznosIzr) AS Kn, sum(Kolicina * TezinaKom) AS Kg FROM MyTmpTable;


/*WITH MyTmpTable2 AS(
SELECT * FROM IzlazRobeDetaljnoView WHERE ID_SKL = 118 AND DatumIzlaza BETWEEN '2015-01-01' AND '2015-12-31' AND VrstaDokumenta <> 'Povrat')
SELECT sum(IznosIzr) AS Kn, sum(Tezina) AS Kg FROM MyTmpTable2*/