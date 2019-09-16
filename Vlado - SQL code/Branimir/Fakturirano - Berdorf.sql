USE FeroApp;

WITH MyTmpTable AS(
SELECT FZ.BrojFakture, FZ.VrstaFakture, FZ.DatumFakture, FS.ID_Mat, CAST(Mat.OmjerPro AS float) AS OmjerProMat, FS.ID_NarZ, FS.BrojVeze, FS.JmMat, CAST(FS.CijenaMatKom AS float) AS CijenaMatKom, FS.ID_Pro, NazivPro, CAST(KolicinaPro AS float) AS KolicinaPro, FS.JmPro, CAST(FS.CijenaProKom AS float) AS CijenaProKom, 
		FS.TezinaProKom, FS.Obrada1, FS.Obrada2, FS.Obrada3, FS.Obrada4, FS.Obrada5, FS.CijenaObrada1, FS.CijenaObrada2, FS.CijenaObrada3, FS.CijenaObrada4, FS.CijenaObrada5, FS.VlasnistvoFX, FS.BrojRN1, FS.BrojRN2, FS.BrojRN3, FS.BrojRN4, FS.BrojRN5, FS.BrojNar1, FS.BrojNar2, FS.BrojNar3, FS.BrojNar4, FS.BrojNar5, 
		ID_Pro_Kup 
	FROM FaktureSta FS 
		INNER JOIN FaktureZag FZ ON FS.ID_FZ = FZ.ID_FZ 
		INNER JOIN Materijali Mat ON FS.ID_Mat = Mat.ID_Mat 
	WHERE FZ.DatumFakture >= '2016-01-01' AND FZ.ID_Par = 274 AND FZ.VrstaFakture = 'Prsteni-FX-P1' AND FS.VrstaTroska = 'Proizvod') 

SELECT BrojFakture, VrstaFakture, DatumFakture, ID_Mat, OmjerProMat, ID_NarZ, JmMat, CijenaMatKom, ID_Pro, ID_Pro_Kup, NazivPro, SUM(KolicinaPro) AS KolicinaPro, JmPro, CijenaProKom, 
		(CASE WHEN Obrada1 = 1 THEN CAST(CijenaObrada1 AS float) ELSE NULL END) AS Tokarenje, (CASE WHEN Obrada2 = 1 THEN CAST(CijenaObrada2 AS float) ELSE NULL END) AS Kaljenje, (CASE WHEN Obrada3 = 1 THEN CAST(CijenaObrada3 AS float) ELSE NULL END) AS TvrdoTok, 
		(CASE WHEN Obrada4 = 1 THEN CAST(CijenaObrada4 AS float) ELSE NULL END) AS Brusenje, (CASE WHEN Obrada5 = 1 THEN CAST(CijenaObrada5 AS float) ELSE NULL END) AS Obrada5 
	FROM MyTmpTable 		
	GROUP BY BrojFakture, VrstaFakture, DatumFakture, ID_Mat, ID_NarZ, BrojVeze, JmMat, CijenaMatKom, ID_Pro, NazivPro, JmPro, CijenaProKom, TezinaProKom, Obrada1, Obrada2, Obrada3, Obrada4, Obrada5, CijenaObrada1, CijenaObrada2, CijenaObrada3, CijenaObrada4, CijenaObrada5, 
		BrojRN1, BrojRN2, BrojRN3, BrojRN4, BrojRN5, BrojNar1, BrojNar2, BrojNar3, BrojNar4, BrojNar5, OmjerProMat, ID_Pro_Kup 
	ORDER BY DatumFakture, BrojFakture

-- Prsteni-Loan-P1
-- Prsteni-FX-P1