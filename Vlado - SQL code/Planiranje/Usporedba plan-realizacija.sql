USE FeroApp;

DECLARE @TmpDatum date, @TmpHala varchar(2), @TmpIdPpz int, @TmpSmjena tinyint; 
SET @TmpHala = '1'; 
SET @TmpIdPpz = 3; 
SELECT @TmpDatum = PPZ.Datum, @TmpSmjena = PPZ.Smjena FROM PlanProZag PPZ WHERE PPZ.ID_PPZ = @TmpIdPpz; 
SET @TmpSmjena = 1;

----- Smjena -----
WITH MyTmpTable1 AS(
SELECT PPSS.Hala, PPSS.Linija, PPSS.BrojRN, PPSA.Smjena FROM PlanProStaAnalitika PPSA 
	LEFT JOIN PlanProStaSintetika PPSS ON PPSA.ID_PPSS = PPSS.ID_PPSS 
	WHERE PPSS.ID_PPZ = @TmpIdPpz 
	AND Hala = @TmpHala 
	AND PPSA.Kolicina <> 0 
	AND PPSA.Smjena >= @TmpSmjena 
	GROUP BY PPSS.Hala, PPSS.Linija, PPSS.BrojRN, PPSA.Smjena 
UNION 
SELECT Hala, Linija, BrojRN, Smjena 
	FROM EvidencijaNormiView 
	WHERE Datum = @TmpDatum 
	AND Hala = @TmpHala 
	AND KolicinaOK <> 0 
	AND Smjena >= @TmpSmjena 
	GROUP BY Hala, Linija, BrojRN, Smjena)
SELECT MTT1.Hala, MTT1.Smjena, MTT1.Linija, MTT1.BrojRN, 
	ISNULL((SELECT SUM(PPSA.Kolicina) FROM PlanProStaAnalitika PPSA WHERE PPSA.ID_PPSS = (SELECT PPSS.ID_PPSS FROM PlanProStaSintetika PPSS WHERE PPSS.ID_PPZ = @TmpIdPpz AND PPSS.Hala = MTT1.Hala AND PPSS.Linija = MTT1.Linija AND PPSS.BrojRN = MTT1.BrojRN) AND PPSA.Datum = @TmpDatum AND PPSA.Smjena = MTT1.Smjena), 0) AS Planirano, 
	ISNULL((SELECT SUM(ENV.KolicinaOK) FROM EvidencijaNormiView ENV WHERE ENV.Datum = @TmpDatum AND ENV.Hala = MTT1.Hala AND ENV.Linija = MTT1.Linija AND ENV.BrojRN = MTT1.BrojRN AND ENV.Smjena = MTT1.Smjena), 0) AS Napravljeno 
	FROM MyTmpTable1 MTT1 
	ORDER BY MTT1.Hala, MTT1.Linija, MTT1.Smjena, MTT1.BrojRN; 
----- Smjena -----

----- Dan -----
WITH MyTmpTable2 AS(
SELECT PPSS.Hala, PPSS.Linija, PPSS.BrojRN FROM PlanProStaAnalitika PPSA 
	LEFT JOIN PlanProStaSintetika PPSS ON PPSA.ID_PPSS = PPSS.ID_PPSS 
	WHERE PPSS.ID_PPZ = @TmpIdPpz 
	AND Hala = @TmpHala 
	AND PPSA.Kolicina <> 0 
	GROUP BY PPSS.Hala, PPSS.Linija, PPSS.BrojRN, PPSA.Smjena 
UNION 
SELECT Hala, Linija, BrojRN 
	FROM EvidencijaNormiView 
	WHERE Datum = @TmpDatum 
	AND Hala = @TmpHala 
	AND KolicinaOK <> 0 
	AND Smjena >= @TmpSmjena 
	GROUP BY Hala, Linija, BrojRN)
SELECT MTT2.Hala, MTT2.Linija, MTT2.BrojRN, 
	ISNULL((SELECT SUM(PPSA.Kolicina) FROM PlanProStaAnalitika PPSA WHERE PPSA.ID_PPSS = (SELECT PPSS.ID_PPSS FROM PlanProStaSintetika PPSS WHERE PPSS.ID_PPZ = @TmpIdPpz AND PPSS.Hala = MTT2.Hala AND PPSS.Linija = MTT2.Linija AND PPSS.BrojRN = MTT2.BrojRN) AND PPSA.Datum = @TmpDatum), 0) AS Planirano, 
	ISNULL((SELECT SUM(ENV.KolicinaOK) FROM EvidencijaNormiView ENV WHERE ENV.Datum = @TmpDatum AND ENV.Hala = MTT2.Hala AND ENV.Linija = MTT2.Linija AND ENV.BrojRN = MTT2.BrojRN), 0) AS Napravljeno 
	FROM MyTmpTable2 MTT2 
	ORDER BY MTT2.Hala, MTT2.Linija, MTT2.BrojRN 
----- Dan -----