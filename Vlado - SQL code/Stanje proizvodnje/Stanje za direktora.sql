USE FeroApp

-- tokareno --
SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, DatumIsporuke, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro, DatumIsporuke 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	AND ZavrsnaObrada = 'Tokarenje'
	ORDER BY Narucitelj

-- kaljeno --
SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	CAST(ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaKalj, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, DatumIsporuke, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro, 
	RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, (SELECT NarudzbeSta.DatumIsporuke FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.RN_Kaljenje) AS DatumIsporuke 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	AND ZavrsnaObrada = 'Kaljenje'
	ORDER BY Narucitelj

-- tvrdo tokareno --
SELECT CAST((SELECT TOP 1 UlazRobe.CijenaKom FROM UlazRobe WHERE UlazRobe.ID_Mat = StanjeProizvodnjeList.ID_Mat AND UlazRobe.VlasnistvoFX = StanjeProizvodnjeList.VlasnistvoFX ORDER BY ID_ULR DESC) AS float) AS CijenaMatKom, 
	CAST(ISNULL((SELECT CijenaObrada1 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTok, 
	CAST(ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaKalj, 
	CAST(ISNULL((SELECT CijenaObrada3 FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.Bazni_RN), 0) AS float) AS CijenaTT, 
	ID_NarS, VrstaNar, RnZaCalcKolicine, Bazni_RN, ID_Mat, OmjerPro, Zavrsni_RN, ID_Par, Narucitelj, VlasnistvoFX, DatumIsporuke, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, ID_Pro_T, SpremnoT_Pro, 
	RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, RN_TvrdoTokarenje, ID_Pro_TT, SpremnoTT_Pro, (SELECT NarudzbeSta.DatumIsporuke FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = StanjeProizvodnjeList.RN_TvrdoTokarenje) AS DatumIsporuke 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno')
	WHERE (SpremnoT_Pro <> 0 OR SpremnoK_Pro <> 0 OR SpremnoTT_Pro <> 0)
	AND ZavrsnaObrada = 'Tvrdo tokarenje'
	ORDER BY Narucitelj

-- valjèiæi --
SELECT cast((select NarudzbeSta.FakturnaCijena from NarudzbeSta WHERE BrojRN = StanjeProizvodnjeList.Bazni_RN) as float) as CijenaProKom, ID_NarS, VrstaNar, OrderNo, Bazni_RN, BaznaObrada, ZavrsnaObrada, ID_Pro_T, NapravljenoT_Pro, SpremnoT_Pro FROM StanjeProizvodnjeList('Valjcici', '') WHERE SpremnoT_Pro <> 0