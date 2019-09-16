USE FeroApp 

SELECT TC.Item, TC.Plant, TC.VrstaPro, TC.Aktivno, TC.Kol_2017, TC.ID_Pro_Kup, TC.NazivPro, CAST(Tokarenje AS float) AS PL_Tokarenje, CAST(TC.Kaljenje AS float) AS PL_Kaljenje, 
	CAST(TC.FX_Tokarenje AS float) AS FX_Tokarenje, CAST(TC.FX_Kaljenje AS float) AS FX_Kaljenje, CAST(TC.FX_TvrdoTok AS float) AS FX_TvrdoTok, CAST(TC.FX_Brusenje AS float) AS FX_Brusenje, 
	TC.CijenaProQ4, (SELECT CAST(FS.CijenaProKom AS float) FROM FaktureSta FS WHERE FS.ID_FS = TC.ID_FS) AS FX_CijenaProKom, 
	TC.NapomenaCijenaTok, TC.NapomenaCijenaKalj, TC.NapomenaCijenaPro 
	FROM TmpCijene2017 TC 
	WHERE (ISNULL(TC.Tokarenje, 0) <> 0 
		AND ISNULL(TC.FX_Tokarenje, 0) <> 0 
		AND TC.Tokarenje <> (TC.FX_Tokarenje + TC.FX_TvrdoTok + TC.FX_Brusenje)) 
	OR (ISNULL(TC.Kaljenje, 0) <> 0 
		AND ISNULL(TC.FX_Kaljenje, 0) <> 0 
		AND TC.Kaljenje <> FX_Kaljenje) 
	ORDER BY TC.Item 