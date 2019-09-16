USE FeroApp

SELECT SPL.ID_NarS, SPL.Bazni_RN, (SELECT Pro.NazivPro FROM Proizvodi Pro WHERE Pro.ID_Pro = SPL.ID_Pro_T) AS Pozicija, SPL.Narucitelj, (CASE WHEN SPL.VlasnistvoFX = 1 THEN 'FX' ELSE 'Lohn' END) AS Vlasnistvo, 
	SPL.DatumIsporuke, SPL.VrstaNar, SPL.ZavrsnaObrada, SPL.OtpadMat_T + SPL.OtpadPro_T AS OtpadT, SPL.OtpadMat_K + SPL.OtpadPro_K AS OtpadK, SPL.OtpadMat_TT + SPL.OtpadPro_TT AS OtpadTT, 
	SPL.SpremnoT_Pro, SPL.SpremnoK_Pro, SPL.SpremnoTT_Pro, SPL.SpremnoBR_Pro, SPL.RN_Kaljenje, (SPL.NapravljenoT_Pro - SPL.SpremnoT_Pro - SPL.NapravljenoK_Pro) AS NedovrsenoK, 
	SPL.RN_TvrdoTokarenje, (CASE WHEN SPL.ZavrsnaObrada IN('Tvrdo tokarenje', 'Brusenje') THEN SPL.NapravljenoK_Pro - SPL.SpremnoK_Pro - SPL.NapravljenoTT_Pro ELSE 0 END) AS NedovrsenoTT, 
	SPL.RN_Brusenje, (CASE WHEN SPL.ZavrsnaObrada IN('Brusenje') THEN SPL.NapravljenoTT_Pro - SPL.SpremnoTT_Pro - SPL.NapravljenoBR_Pro ELSE 0 END) AS NedovrsenoBR 
	FROM StanjeProizvodnjeList('*','Neisporuceno') SPL 
	WHERE SPL.VrstaNar IN(SELECT VN.VrstaNar FROM VrsteNarudzbi VN WHERE VN.Planiranje = 1) 
		AND (SPL.SpremnoT_Pro + SPL.SpremnoK_Pro + SPL.SpremnoTT_Pro + SPL.SpremnoBR_Pro) > 0 
		AND SPL.ZavrsnaObrada <> 'Tokarenje' 
		AND SPL.BaznaObrada = 'Tokarenje' 
		AND SPL.NapravljenoT_Pro > 0 
	ORDER BY SPL.DatumIsporuke 