USE FxSAP ; DECLARE @TmpPsrId int 

SET @TmpPsrId = 21265
--UPDATE PlanSatiRada SET Stimulacija2 += 8 WHERE PsrID = @TmpPsrId

SELECT PsrID, (SELECT Ime FROM PlanSatiRada WHERE PsrID = PlanSatiRadaNapomene.PsrID) AS Radnik, SUM(CAST(SUBSTRING(Napomena, 12, 2) AS INT)) AS Napomene, 
	CAST((select SUM(Stimulacija2 + Stimulacija3 + Stimulacija4 + Stimulacija5) from PlanSatiRada where PsrID = PlanSatiRadaNapomene.PsrID) AS integer) AS PlanSati
	FROM PlanSatiRadaNapomene 
	WHERE PsrID IN(SELECT PsrID FROM PlanSatiRada WHERE Godina = 2016 AND Mjesec = 5) 
	AND Napomena LIKE 'Broj sati:%'
	AND Vrsta = 'Stimulac.'
	GROUP BY PsrID
	HAVING CAST((select SUM(Stimulacija2 + Stimulacija3 + Stimulacija4 + Stimulacija5) from PlanSatiRada where PsrID = PlanSatiRadaNapomene.PsrID) AS integer) <> SUM(CAST(SUBSTRING(Napomena, 12, 2) AS INT))
	ORDER BY PsrID
	
-- CAST(YourVarcharCol AS INT)	
SELECT PsrID, Ime, MT, Godina, Mjesec, Stimulacija1, Stimulacija2, Stimulacija3, Stimulacija4, Stimulacija5 FROM PlanSatiRada WHERE PsrID = @TmpPsrId
SELECT * FROM PlanSatiRadaNapomene WHERE PsrID = @TmpPsrId