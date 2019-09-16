USE FeroApp;

DECLARE @TmpDatum date, @TmpHala varchar(2), @TmpIdPpz int, @TmpSmjena tinyint; 
SET @TmpHala = '1'; 
SET @TmpIdPpz = 2; 
SELECT @TmpDatum = PPZ.Datum, @TmpSmjena = PPZ.Smjena FROM PlanProZag PPZ WHERE PPZ.ID_PPZ = @TmpIdPpz; 
SET @TmpSmjena = 1;

WITH MyTmpTable1 AS(
SELECT PPSS.Hala, PPSS.Linija, (SELECT PL1.Broj FROM ProizvodneLinije PL1 WHERE PL1.ID_PLI = (SELECT TOP 1 PL2.Parent_PLI FROM ProizvodneLinije PL2 WHERE PL2.Hala = PPSS.Hala AND PL2.Broj = PPSS.Linija)) AS ParentLinija, PPSS.BrojRN, PPSA.Smjena 
	FROM PlanProStaAnalitika PPSA 
		LEFT JOIN PlanProStaSintetika PPSS ON PPSA.ID_PPSS = PPSS.ID_PPSS 
	WHERE PPSS.ID_PPZ = @TmpIdPpz 
		AND Hala = @TmpHala 
		AND PPSA.Kolicina <> 0 
		AND PPSA.Datum = @TmpDatum
		AND PPSA.Smjena >= @TmpSmjena 
	GROUP BY PPSS.Hala, PPSS.Linija, PPSS.BrojRN, PPSA.Smjena 
UNION 
SELECT ENV.Hala, ENV.Linija, NULL, ENV.BrojRN, ENV.Smjena 
	FROM EvidencijaNormiView ENV 
	WHERE ENV.Datum = @TmpDatum 
		AND ENV.Hala = @TmpHala 
		AND ENV.Datum = @TmpDatum 
		AND ENV.KolicinaOK <> 0 
		AND ENV.Smjena >= @TmpSmjena 
	GROUP BY ENV.Hala, ENV.Linija, ENV.BrojRN, ENV.Smjena),
MyTmpTable2 AS(
SELECT MTT1.Hala, MTT1.Smjena, (CASE WHEN MTT1.ParentLinija IS NULL THEN MTT1.Linija ELSE MTT1.ParentLinija END) AS Linija, MTT1.BrojRN, 
	ISNULL((SELECT SUM(ISNULL(PPSA.Kolicina, 0)) FROM PlanProStaAnalitika PPSA WHERE PPSA.ID_PPSS IN(SELECT PPSS.ID_PPSS FROM PlanProStaSintetika PPSS WHERE PPSS.ID_PPZ = @TmpIdPpz AND PPSS.Hala = MTT1.Hala AND PPSS.Linija = MTT1.Linija AND PPSS.BrojRN = MTT1.BrojRN) AND PPSA.Smjena = MTT1.Smjena AND PPSA.Datum = @TmpDatum), 0) AS Planirano, 
	ISNULL((SELECT SUM(ISNULL(ENV.KolicinaOK, 0)) FROM EvidencijaNormiView ENV WHERE ENV.Datum = @TmpDatum AND ENV.Hala = MTT1.Hala AND ENV.Linija = (CASE WHEN MTT1.ParentLinija IS NULL THEN MTT1.Linija ELSE MTT1.Linija END) AND ENV.BrojRN = MTT1.BrojRN AND ENV.Smjena = MTT1.Smjena), 0) AS Napravljeno 
	FROM MyTmpTable1 MTT1) 
SELECT MTT2.Hala, MTT2.Smjena, MTT2.Linija, MTT2.BrojRN, SUM(MTT2.Planirano) AS Planirano, SUM(MTT2.Napravljeno) AS Realizacija FROM MyTmpTable2 MTT2 	
	WHERE Planirano <> 0 OR Napravljeno <> 0
	GROUP BY MTT2.Hala, MTT2.Smjena, MTT2.Linija, MTT2.BrojRN
	ORDER BY MTT2.Hala, MTT2.Linija, MTT2.Smjena, MTT2.BrojRN 