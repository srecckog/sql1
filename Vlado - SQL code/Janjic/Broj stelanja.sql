USE FeroApp;

WITH MyTmpTable AS(
SELECT NDV.ID_Par, NDV.VrstaNar, NDV.BrojRN, ENZ.Hala, ENS.Linija 
	FROM EvidencijaNormiSta ENS 
	INNER JOIN EvidencijaNormiZag ENZ ON ENS.ID_ENZ = ENZ.ID_ENZ 
	INNER JOIN NarudzbeDetaljnoView NDV ON ENS.BrojRN = NDV.BrojRN 
	WHERE ENZ.Datum BETWEEN '2017-02-01' AND '2017-02-20' 
	AND ENS.TekstCheck01 = 1
	GROUP BY NDV.ID_Par, NDV.VrstaNar, NDV.BrojRN, ENZ.Hala, ENS.Linija)

SELECT ID_Par, (SELECT Par.NazivPar FROM Partneri Par WHERE Par.ID_Par = MTT.ID_Par) AS Kupac, VrstaNar, COUNT(*) AS BrojStelanja FROM MyTmpTable MTT GROUP BY ID_Par, VrstaNar 