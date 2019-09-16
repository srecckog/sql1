USE FeroApp

SELECT VrstaNar, ID_NarS, Bazni_RN, VlasnistvoFX, ID_Par, ID_Mat, (CASE WHEN ZavrsnaObrada = 'Obrada #5' THEN ID_Pro_O5 WHEN ZavrsnaObrada = 'Obrada #4' THEN ID_Pro_O4 WHEN ZavrsnaObrada = 'Tvrdo tokarenje' THEN ID_Pro_TT WHEN ZavrsnaObrada = 'Kaljenje' THEN ID_Pro_K ELSE ID_Pro_T END) AS ID_Pro, 
	OmjerPro, KolicinaNar, (CASE WHEN ZavrsnaObrada = 'Obrada #5' THEN SpremnoO5_Pro WHEN ZavrsnaObrada = 'Obrada #4' THEN SpremnoO4_Pro WHEN ZavrsnaObrada = 'Tvrdo tokarenje' THEN SpremnoTT_Pro WHEN ZavrsnaObrada = 'Kaljenje' THEN SpremnoK_Pro ELSE SpremnoT_Pro END) AS Spremno, 
	OtpadPro_T AS ProizvedenoOtpadPro1, OtpadPro_K AS ProizvedenoOtpadPro2, OtpadPro_TT AS ProizvedenoOtpadPro3, OtpadPro_O4 AS ProizvedenoOtpadPro4, OtpadPro_O5 AS ProizvedenoOtpadPro5, 
	OtpadMat_T AS ProizvedenoOtpadMat1, OtpadMat_K AS ProizvedenoOtpadMat2, OtpadMat_TT AS ProizvedenoOtpadMat3, OtpadMat_O4 AS ProizvedenoOtpadMat4, OtpadMat_O5 AS ProizvedenoOtpadMat5, 
	KolicinaUzoraka_T AS BrojUzoraka1, KolicinaUzoraka_K AS BrojUzoraka2, KolicinaUzoraka_TT AS BrojUzoraka3, KolicinaUzoraka_O4 AS BrojUzoraka4, KolicinaUzoraka_O5 AS BrojUzoraka5 
	FROM StanjeProizvodnjeList('Prsteni')
	WHERE (CASE WHEN ZavrsnaObrada = 'Obrada #5' THEN SpremnoO5_Pro WHEN ZavrsnaObrada = 'Obrada #4' THEN SpremnoO4_Pro WHEN ZavrsnaObrada = 'Tvrdo tokarenje' THEN SpremnoTT_Pro WHEN ZavrsnaObrada = 'Kaljenje' THEN SpremnoK_Pro ELSE SpremnoT_Pro END) <> 0 
