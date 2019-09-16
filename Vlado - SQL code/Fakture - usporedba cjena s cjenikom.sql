USE FeroApp;

DECLARE @TmpDatumFaktura date;

SET @TmpDatumFaktura = '2017-01-12';

WITH MyTmpTable AS(
SELECT ID_FS, ID_FZ, ID_Par, BrojFakture, VrstaFakture, BrojRN, ID_Pro_Kup, NazivPro, KolicinaPro, 
	(CASE WHEN VrstaFakture LIKE '%FX%' THEN CijenaProKom ELSE (Obrada1 * CijenaObrada1) + (Obrada2 * CijenaObrada2) + (Obrada3 * CijenaObrada3) + (Obrada4 * CijenaObrada4) + ISNULL(CijenaPakiranjaKom, 0) END) AS CijenaPro, 
	(Obrada1 * CijenaObrada1) + (Obrada3 * CijenaObrada3) + (Obrada4 * CijenaObrada4) AS Tokarenje, Obrada2 * CijenaObrada2 AS Kaljenje, FDVS.CijenaPakiranjaKom, 
	(SELECT TOP 1 FCP.Tokarenje FROM FakturneCijeneProizvoda FCP WHERE FCP.ID_Pro_Kup = FDVS.ID_Pro_Kup AND FCP.Godina = YEAR(@TmpDatumFaktura)) AS PL_Tokarenje, 
	(SELECT TOP 1 FCP.Kaljenje FROM FakturneCijeneProizvoda FCP WHERE FCP.ID_Pro_Kup = FDVS.ID_Pro_Kup AND FCP.Godina = YEAR(@TmpDatumFaktura)) AS PL_Kaljenje, 
	(SELECT TOP 1 FCP.Pakiranje FROM FakturneCijeneProizvoda FCP WHERE FCP.ID_Pro_Kup = FDVS.ID_Pro_Kup AND FCP.Godina = YEAR(@TmpDatumFaktura)) AS PL_Pakiranje, 
	(SELECT TOP 1 (CASE (CASE WHEN MONTH(@TmpDatumFaktura) < 4 THEN 1 WHEN MONTH(@TmpDatumFaktura) < 7 THEN 2 WHEN MONTH(@TmpDatumFaktura) < 10 THEN 3 ELSE 4 END) WHEN 1 THEN FCP.CijenaProQ1 WHEN 2 THEN FCP.CijenaProQ2 WHEN 3 THEN FCP.CijenaProQ3 ELSE FCP.CijenaProQ4 END) FROM FakturneCijeneProizvoda FCP WHERE FCP.ID_Pro_Kup = FDVS.ID_Pro_Kup AND FCP.Godina = YEAR(@TmpDatumFaktura)) AS PL_CijenaPro 
	FROM FaktureDetaljnoViewStat FDVS 
	WHERE DatumFakture = @TmpDatumFaktura
		AND VrstaTroska = 'Proizvod')

SELECT *, (CijenaPro - PL_CijenaPro) AS RazProKom, (Tokarenje - PL_Tokarenje) AS RazTok, (Kaljenje - PL_Kaljenje) AS RazKalj FROM MyTmpTable
