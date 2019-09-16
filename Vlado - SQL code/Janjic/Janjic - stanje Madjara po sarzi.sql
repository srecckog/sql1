USE FeroApp;	

WITH MyTmpTable1 AS(
SELECT ID_ULR, ID_MAT, BrojRN, (SELECT Materijali.ID_Mat_Dob FROM Materijali WHERE Materijali.ID_Mat = UlazRobeDetaljnoView.ID_MAT) AS SAP_ID, NazivMat, BrojSarze, KolicinaInventura AS KolicinaUlaz, 
	ISNULL((SELECT SUM(ISNULL(FaktureSta.KolicinaMat, 0)) FROM FaktureSta WHERE FaktureSta.ID_Ulp IN(SELECT UlazProizvoda.ID_ULP FROM UlazProizvoda WHERE UlazProizvoda.ID_IZR IN(SELECT IzlazRobe.ID_IZR FROM IzlazRobe WHERE IzlazRobe.ID_ULR = UlazRobeDetaljnoView.ID_ULR))), 0) AS KolicinaFakturirano FROM UlazRobeDetaljnoView WHERE ID_Skl IN(158, 358)),
MyTmpTable2 AS(
SELECT SAP_ID, BrojRN, NazivMat, BrojSarze, KolicinaUlaz, KolicinaFakturirano, (KolicinaUlaz - KolicinaFakturirano) AS Saldo FROM MyTmpTable1)

SELECT SAP_ID, BrojRN, NazivMat, BrojSarze, CAST(SUM(KolicinaUlaz) AS float) AS Ulaz, CAST(SUM(KolicinaFakturirano) AS float) AS Fakturirano, CAST(SUM(Saldo) AS float) AS Saldo, ISNULL((SELECT SUM(ISNULL(EvidencijaProizvodnjeSta.OtpadObrada, 0) + ISNULL(EvidencijaProizvodnjeSta.OtpadMaterijal, 0)) FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = MyTmpTable2.BrojRN)), 0) AS Skart_i_otpad 
	FROM MyTmpTable2 
	WHERE Saldo <> 0 
	GROUP BY SAP_ID, BrojRN, NazivMat, BrojSarze 
	ORDER BY BrojRN