USE FeroApp; DECLARE @Datum1 date, @Datum2 date;

SET @Datum1 = '2016-10-01' ; SET @Datum2 = '2016-10-31' ;

WITH MyTmpTable1 AS(
SELECT NarZ.ID_Par, (CASE Proizvodi.ZavrsnaObrada WHEN 'Tokarenje' THEN ENS.ObradaA WHEN 'Glodanje' THEN ENS.ObradaB WHEN 'Bušenje' THEN ENS.ObradaC ELSE ENS.ObradaA END) AS ZavrsnaObrada, 
	Proizvodi.ID_Pro, Proizvodi.VrstaPro, ISNULL(ENS.KolicinaOK, 0) AS KolicinaOK, ENS.BrojRN 
	FROM EvidencijaNormiSta ENS 
		INNER JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
		INNER JOIN NarudzbeSta NarS ON ENS.BrojRN = NarS.BrojRN 
		INNER JOIN NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
		INNER JOIN Proizvodi ON NarS.ID_Pro = Proizvodi.ID_Pro 
	WHERE ENZ.Datum BETWEEN @Datum1 AND @Datum2
		AND NarS.BazniRN = 1 AND NarS.Obrada1 = 1),
MyTmpTable2 AS(
SELECT ID_Par, 'Norme' AS Vrsta, VrstaPro, CAST(SUM(KolicinaOK) AS float) AS Kolicina 
	FROM MyTmpTable1 
	WHERE ZavrsnaObrada = 1 
		AND ID_Pro IS NOT NULL
	GROUP BY ID_Par, VrstaPro 
UNION ALL 
SELECT FDV.ID_Par, 'Fakture', Proizvodi.VrstaPro, CAST(SUM(ISNULL(KolicinaPro, 0)) AS float) AS Kolicina
	FROM FaktureDetaljnoView FDV
		INNER JOIN Proizvodi ON FDV.ID_Pro = Proizvodi.ID_Pro 
	WHERE FDV.DatumFakture BETWEEN @Datum1 AND @Datum2
		AND FDV.VrstaTroska = 'Proizvod'
		AND FDV.ID_Pro IS NOT NULL
		AND FDV.Obrada1 = 1 
	GROUP BY FDV.ID_Par, Proizvodi.VrstaPro)

SELECT MttPar.ID_Par, Partneri.NazivPar AS Kupac, MttPar.VrstaPro, 
	ISNULL((SELECT SUM(MttChi1.Kolicina) FROM MyTmpTable2 MttChi1 WHERE MttChi1.ID_Par = MttPar.ID_Par AND MttChi1.VrstaPro = MttPar.VrstaPro AND MttChi1.Vrsta = 'Norme'), 0) AS Proizvedeno, 
	ISNULL((SELECT SUM(MttChi2.Kolicina) FROM MyTmpTable2 MttChi2 WHERE MttChi2.ID_Par = MttPar.ID_Par AND MttChi2.VrstaPro = MttPar.VrstaPro AND MttChi2.Vrsta = 'Fakture'), 0) AS Fakturirano 
	FROM MyTmpTable2 MttPar 
		INNER JOIN Partneri ON MttPar.ID_Par = Partneri.ID_Par 
	GROUP BY MttPar.ID_Par, Partneri.NazivPar, MttPar.VrstaPro
	ORDER BY MttPar.ID_Par, MttPar.VrstaPro