USE FeroTmp;

WITH MyTmpTable AS(
SELECT TJ.Item, TJ.ID_FS, FZ.DatumFakture, MT.ID_Mat_Dob, MT.NazivMat, (CASE WHEN MT.OmjerPro = 2 THEN 'Da' ELSE '-' END) AS TURM, TJ.ID_Pro_Kup, CAST(FS.Obrada1 * CijenaObrada1 AS float) AS Tokarenje, 
	CAST(FS.Obrada2 * CijenaObrada2 AS float) AS Kaljenje, CAST(FS.Obrada3 * CijenaObrada3 AS float) AS TvrdoTok, 
	(CASE WHEN FZ.VrstaFakture LIKE '%FX%' THEN 'FX' ELSE 'Lohn' END) AS Vlasnistvo, FS.CijenaProKom, CAST(MC.BaznaCijenaMat AS float) AS BaznaCijenaMat, CAST(FS.CijenaMatKom AS float) AS CijenaMatKom 
	FROM TmpJanjic TJ 
		LEFT JOIN FaktureSta FS ON TJ.ID_FS = FS.ID_FS 
		LEFT JOIN FaktureZag FZ ON FS.ID_FZ = FZ.ID_FZ
		LEFT JOIN Materijali MT ON FS.ID_Mat = MT.ID_Mat
		LEFT JOIN MaterijaliCijene MC ON FS.ID_Mat = MC.ID_Mat AND MC.Godina = 2016 AND MC.Kvartal = 4)
		
SELECT Item, DatumFakture, ID_Mat_Dob, NazivMat, TURM, ID_Pro_Kup,Tokarenje, Kaljenje, TvrdoTok, Vlasnistvo, 
	(CASE WHEN Vlasnistvo = 'FX' THEN CijenaProKom ELSE (Tokarenje + Kaljenje + TvrdoTok) END) AS FakturnaCijena, 
	(CASE WHEN Vlasnistvo = 'FX' THEN (CASE WHEN BaznaCijenaMat IS NULL THEN CijenaMatKom ELSE BaznaCijenaMat END) ELSE NULL END) AS CijenaMat 
	FROM MyTmpTable 
	ORDER BY Item 
