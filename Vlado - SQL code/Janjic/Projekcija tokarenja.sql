USE FeroApp;

DECLARE @TmpDatum date, @TmpSmjena tinyint ; SET @TmpDatum = '2016-02-23'; SET @TmpSmjena = 1 ;

WITH ProjekcijaTokarenja1 AS(
SELECT BrojRN, MAX(Norma) AS Norma, dbo.CalcStanjeENS(EvidencijaNormiView.BrojRN, @TmpDatum) AS Napravljeno
	FROM EvidencijaNormiView 
	WHERE Datum = @TmpDatum AND Smjena = @TmpSmjena
	AND BrojRN IN(SELECT BrojRN FROM NarudzbeDetaljnoView WHERE ID_Par = 274)
	GROUP BY BrojRN, Hala, Linija),
ProjekcijaTokarenja2 AS(
SELECT BrojRN, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = (SELECT ID_Pro FROM NarudzbeSta WHERE BrojRN = ProjekcijaTokarenja1.BrojRN)) AS Proizvod, SUM(Norma) AS Norma, COUNT(*) AS BrojLinija, 
	MAX(Napravljeno) AS PocetnoStanje, (SELECT KolicinaNar FROM NarudzbeSta WHERE BrojRN = ProjekcijaTokarenja1.BrojRN) AS Naruceno 
	FROM ProjekcijaTokarenja1 
	GROUP BY BrojRN),
ProjekcijaTokarenja3 AS(
SELECT *, (CASE WHEN PocetnoStanje >= Naruceno THEN 0 WHEN (PocetnoStanje + Norma) > Naruceno THEN Naruceno - PocetnoStanje ELSE Norma END) AS Nakon8h 
	FROM ProjekcijaTokarenja2),
ProjekcijaTokarenja4 AS(
SELECT *, (CASE WHEN (PocetnoStanje + Nakon8h) >= Naruceno THEN 0 WHEN (PocetnoStanje + Norma + Nakon8h) > Naruceno THEN (Naruceno - PocetnoStanje - Nakon8h) ELSE Norma END) AS Nakon16h 
	FROM ProjekcijaTokarenja3), 
ProjekcijaTokarenja5 AS(
SELECT *, CAST((450 * (Nakon8h / Norma)) AS smallint) AS MinutaRada1, CAST((450 * (Nakon16h / Norma)) AS smallint) AS MinutaRada2, 
	CAST((CASE WHEN (PocetnoStanje + Nakon8h + Nakon16h) >= Naruceno THEN 0 WHEN (PocetnoStanje + Norma + Nakon8h + Nakon16h) > Naruceno THEN (Naruceno - PocetnoStanje - Nakon8h - Nakon16h) ELSE Norma END) AS float) AS Nakon24h 
	FROM ProjekcijaTokarenja4)

SELECT BrojRN, Proizvod, Norma, BrojLinija, CAST(PocetnoStanje AS float) AS PocetnoStanje, CAST(Naruceno AS float) AS NarucenaKol, 
	CAST(Nakon8h AS float) AS Nakon8h, MinutaRada1, CAST(Nakon16h AS float) AS Nakon16h, MinutaRada2,
	CAST(Nakon24h AS float) AS Nakon24h, CAST((450 * (Nakon24h / Norma)) AS smallint) AS MinutaRada3,
	CAST((PocetnoStanje + Nakon8h + Nakon16h + Nakon24h) AS float) AS UkupnoNakon24h 
	FROM ProjekcijaTokarenja5