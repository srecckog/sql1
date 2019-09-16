USE FeroTmp ; DECLARE @TmpDatumStanja date ;

SET @TmpDatumStanja = '2016-03-31' ;

WITH MyTmpTable AS(
SELECT NarZ.VrstaNar, NarZ.ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = NarZ.ID_Par) AS Kupac, NarS.ID_NarS, (CASE WHEN NarS.LoanPosao = 1 THEN 0 ELSE 1 END) AS VlasnistvoFX, NarS.BrojRN, 
		ISNULL((SELECT SUM(EPS1.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS1 WHERE EPS1.ID_EPZ = (SELECT EPZ1.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ1 WHERE EPZ1.BrojRN = (CASE WHEN NarS.Obrada5 = 1 THEN NarS.BrojRN5 WHEN NarS.Obrada4 = 1 THEN NarS.BrojRN4 WHEN NarS.Obrada3 = 1 THEN NarS.BrojRN3 WHEN NarS.Obrada2 = 1 THEN NarS.BrojRN2 ELSE NarS.BrojRN END)) AND EPS1.Datum <= @TmpDatumStanja), 0) AS NapravljenoDoDana, 
		CAST(ISNULL((SELECT SUM(FDV1.KolicinaPro) FROM FaktureDetaljnoView FDV1 WHERE FDV1.BrojRN = NarS.BrojRN AND FDV1.DatumFakture <= @TmpDatumStanja), 0) AS float) AS IsporucenoDoDana, 
		CAST(((NarS.Obrada1 * CijenaObrada1) + (NarS.Obrada2 * CijenaObrada2) + (NarS.Obrada3 * CijenaObrada3) + (NarS.Obrada4 * CijenaObrada4) + (NarS.Obrada5 * CijenaObrada5)) AS float) AS CijenaObradeKom, 
		CAST((SELECT Materijali.OmjerPro FROM Materijali WHERE Materijali.ID_Mat = NarS.ID_Mat) AS float) AS OmjerPro, 
		CAST((SELECT TOP 1 ULRV1.CijenaKom FROM UlazRobeDetaljnoView ULRV1 WHERE ULRV1.DatumUlaza <= @TmpDatumStanja AND ULRV1.ID_MAT = NarS.ID_Mat AND ULRV1.VrstaUR = 'UlazULR' AND ULRV1.VlasnistvoFX = (CASE WHEN NarS.LoanPosao = 1 THEN 0 ELSE 1 END) ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom 
	FROM NarudzbeSta NarS
		INNER JOIN NarudzbeZag NarZ ON NarS.ID_NarZ = NarZ.ID_NarZ 
	WHERE NarZ.VrstaNar = 'Prsteni' 
		AND NarS.ID_NarS >= 18700 
		AND NarS.BazniRN = 1 
		AND NarS.BrojRN IN(SELECT EPZx.BrojRN FROM EvidencijaProizvodnjeZag EPZx WHERE EPZx.ID_EPZ IN(SELECT EPSx.ID_EPZ FROM EvidencijaProizvodnjeSta EPSx WHERE EPSx.Datum <= @TmpDatumStanja)))

SELECT * FROM MyTmpTable WHERE NapravljenoDoDana > IsporucenoDoDana