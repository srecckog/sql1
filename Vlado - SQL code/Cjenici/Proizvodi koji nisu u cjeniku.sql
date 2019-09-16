USE FeroApp;

WITH MyTmpTable1 AS(
SELECT FDV.*
	FROM FaktureDetaljnoViewStat FDV 
	WHERE (FDV.VrstaFakture LIKE 'Prst%' OR FDV.VrstaFakture LIKE 'Valj%' OR FDV.VrstaFakture LIKE 'Kuc%') 
		AND FDV.VrstaTroska = 'Proizvod' 
		AND ISNULL(FDV.ID_Pro_Kup, '') <> '' 
		AND FDV.ID_Pro_Kup NOT IN(SELECT TmpCijene2017.ID_Pro_Kup FROM TmpCijene2017)
		AND LEN(ID_Pro_Kup) > 12
		AND FDV.DatumFakture >= '2016-01-01'), 
MyTmpTable2 AS(
	SELECT ID_Pro_Kup, MAX(ID_FS) AS ZadnjiIdFs FROM MyTmpTable1 GROUP BY ID_Pro_Kup),
MyTmpTable3 AS(
SELECT Par2.NazivPar AS Kupac, Par2.Plant AS Tvornica, MTT2.ID_Pro_Kup, FS.NazivPro, Mat.ID_Mat_Dob, Mat.NazivMat, ISNULL(Mat.Sastav, '') AS Sastav, (CASE WHEN FZ.VrstaFakture LIKE '%FX%' THEN 'FX' ELSE 'Lohn' END) AS Vlasnistvo, CAST(FS.CijenaProKom AS float) AS CijenaProKom, 
	CAST((FS.Obrada1 * FS.CijenaObrada1) + (FS.Obrada3 * FS.CijenaObrada3) + (FS.Obrada4 * FS.CijenaObrada4) AS float) AS Tokarenje, CAST((FS.Obrada2 * FS.CijenaObrada2) AS float) AS Kaljenje, CAST(Pro.TezinaPro AS float) AS TezinaPro, 
	CAST(Pro.PromjerV AS float) AS Promjer, CAST(Pro.Duzina AS float) AS Duzina, Par.NazivPar AS Dobavljac, (CASE WHEN FS.Obrada1 = 1 THEN 'Tok' ELSE '' END) AS Tok, (CASE WHEN FS.Obrada2 = 1 THEN 'Kalj' ELSE '' END) AS Kalj, 
	(CASE WHEN FS.Obrada3 = 1 THEN 'TT' ELSE '' END) AS TT, (CASE WHEN FS.Obrada4 = 1 THEN 'Bru' ELSE '' END) AS Bru, Mat.PromjerV, Pro.VrstaPro, CAST(Mat.OmjerPro AS float) AS Omjer, CAST(FS.TezinaMatKom AS float) AS TezinaMat 
	FROM MyTmpTable2 MTT2 
		INNER JOIN FaktureSta FS ON MTT2.ZadnjiIdFs = FS.ID_FS 
		INNER JOIN FaktureZag FZ ON FS.ID_FZ = FZ.ID_FZ 
		INNER JOIN Materijali Mat ON FS.ID_Mat = Mat.ID_Mat 
		INNER JOIN Proizvodi Pro ON FS.ID_Pro = Pro.ID_Pro 
		INNER JOIN UlazProizvoda ULP ON FS.ID_Ulp = ULP.ID_ULP 
		INNER JOIN IzlazRobe IZR ON ULP.ID_IZR = IZR.ID_IZR 
		INNER JOIN UlazRobeDetaljnoView ULR ON IZR.ID_ULR = ULR.ID_ULR 
		INNER JOIN Partneri Par ON ULR.ID_Par = Par.ID_Par
		INNER JOIN Partneri Par2 ON FZ.ID_Par = Par2.ID_Par) 

SELECT Kupac, Tvornica, '' AS X1, 248119 AS ID_Dob, ID_Pro_Kup, NazivPro, LTRIM(Tok + ' ' + Kalj + ' ' + TT + ' ' + Bru) AS Obrade, Dobavljac, '' AS X2, ID_Mat_Dob, '' AS UnisTok, Sastav, CAST(PromjerV AS float) AS PromjerSipke, Tokarenje, Kaljenje, 
	(CASE WHEN Vlasnistvo = 'FX' THEN CijenaProKom ELSE (Tokarenje + Kaljenje) END) AS CijenaProKom, TezinaPro, Promjer, Duzina, VrstaPro, Omjer, TezinaMat 
	FROM MyTmpTable3