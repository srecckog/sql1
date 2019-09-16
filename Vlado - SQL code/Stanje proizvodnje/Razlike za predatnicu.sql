USE FeroApp;

WITH MyTmpTable AS(
SELECT NS.ID_NarS, NS.BrojRN, NS.ID_Mat, NS.ID_Pro, NZ.ID_Par, CAST(KolicinaNar AS float) AS KolicinaNar, NS.DatumIsporuke, (CASE WHEN NS.LoanPosao = 1 THEN 0 ELSE 1 END) AS VlasnistvoFX, 
	CAST((SELECT MAT.OmjerPro FROM Materijali MAT WHERE MAT.ID_Mat = NS.ID_Mat) AS float) AS OmjerPro, 
	(SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ = (SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = (CASE WHEN NS.Obrada5 = 1 THEN NS.BrojRN5 WHEN NS.Obrada4 = 1 THEN NS.BrojRN4 WHEN NS.Obrada3 = 1 THEN NS.BrojRN3 WHEN NS.Obrada2 = 1 THEN NS.BrojRN2 ELSE NS.BrojRN END))) AS Napravljeno, 
	(SELECT SUM(EPS.OtpadMaterijal) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN IN(NS.BrojRN, NS.BrojRN2, NS.BrojRN3, NS.BrojRN4, NS.BrojRN5))) AS OtpadMat, 
	ISNULL((SELECT SUM(EPS.OtpadObrada) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NS.BrojRN)), 0) AS OtpadTok, 
	ISNULL((SELECT SUM(EPS.OtpadObrada) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NS.BrojRN2)), 0) AS OtpadKalj, 
	ISNULL((SELECT SUM(EPS.OtpadObrada) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NS.BrojRN3)), 0) AS OtpadTvrdoTok, 
	ISNULL((SELECT SUM(EPS.OtpadObrada) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NS.BrojRN4)), 0) AS OtpadBru, 
	CAST((SELECT SUM(UP.KolicinaPro) FROM UlazProizvoda UP WHERE UP.BrojRN = NS.BrojRN) AS float) AS Predatnica, 
	CAST((SELECT SUM(UP.OtpadMat) FROM UlazProizvoda UP WHERE UP.BrojRN = NS.BrojRN) AS float) AS PredaOtpMat, 
	CAST((SELECT SUM(UP.OtpadObrada1) FROM UlazProizvoda UP WHERE UP.BrojRN = NS.BrojRN) AS float) AS PredaOtpTok, 
	CAST((SELECT SUM(UP.OtpadObrada2) FROM UlazProizvoda UP WHERE UP.BrojRN = NS.BrojRN) AS float) AS PredaOtpKalj, 
	CAST((SELECT SUM(UP.OtpadObrada3) FROM UlazProizvoda UP WHERE UP.BrojRN = NS.BrojRN) AS float) AS PredaOtpTvrdoTok, 
	CAST((SELECT SUM(UP.OtpadObrada4) FROM UlazProizvoda UP WHERE UP.BrojRN = NS.BrojRN) AS float) AS PredaOtpBru 
	FROM NarudzbeSta NS 
		INNER JOIN NarudzbeZag NZ ON NS.ID_NarZ = NZ.ID_NarZ 
	WHERE (NS.Aktivno = 1 OR NS.Isporuceno = 0) 
		AND NS.BazniRN = 1 
		AND NZ.VrstaNar = 'Prsteni') 

SELECT * FROM MyTmpTable WHERE Napravljeno > Predatnica ORDER BY DatumIsporuke