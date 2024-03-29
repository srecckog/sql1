USE FeroApp

SELECT ID_SKL, BrojRN, ID_Mat, (SELECT NazivMat FROM Materijali WHERE ID_Mat = IzlazRobeDetaljnoView.ID_Mat) AS NazivMat, CAST(SUM(Kolicina) AS Float) AS Kolicina 
	FROM IzlazRobeDetaljnoView 
	WHERE DatumIzlaza BETWEEN '2014-07-01' AND '2014-09-30' 
	AND ID_Mat IN(920112,920171,920185,920007,920095,920102,920120,920121,920122,920148,920161,920195,920196,920207,920282,920302,920357)
	GROUP BY ID_SKL, BrojRN, ID_Mat
	ORDER BY ID_SKL, BrojRN, ID_Mat