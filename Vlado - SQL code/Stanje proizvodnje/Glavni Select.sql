USE FeroApp

SELECT NarudzbeSta.ID_NarS, NarudzbeZag.VrstaNar, NarudzbeSta.BrojRN AS Bazni_RN, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = NarudzbeZag.ID_Par) AS Narucitelj, (CASE WHEN NarudzbeSta.LoanPosao = 1 THEN 'Kupac' ELSE 'FX' END) AS Vlasnistvo, NarudzbeSta.DatumIsporuke, 
  (CASE WHEN NarudzbeSta.Obrada1 = 1 THEN 'Tokarenje' WHEN NarudzbeSta.Obrada2 = 1 THEN 'Kaljenje' WHEN NarudzbeSta.Obrada3 = 1 THEN 'Tvrdo tokarenje' WHEN NarudzbeSta.Obrada4 = 1 THEN 'Obrada #4' WHEN NarudzbeSta.Obrada5 = 1 THEN 'Obrada #5' ELSE 'Tokarenje' END) AS BaznaObrada, 
  (CASE WHEN NarudzbeSta.Obrada5 = 1 THEN 'Obrada #5' WHEN NarudzbeSta.Obrada4 = 1 THEN 'Obrada #4' WHEN NarudzbeSta.Obrada3 = 1 THEN 'Tvrdo tokarenje' WHEN NarudzbeSta.Obrada2 = 1 THEN 'Kaljenje' WHEN NarudzbeSta.Obrada5 = 1 THEN 'Tokarenje' ELSE 'Tokarenje' END) AS ZavrsnaObrada, 
  ISNULL(NarudzbeSta.BrojRN1, '') AS RN_Tokarenje, 
  ISNULL(Func1.SpremnoPro, 0) AS SpremnoT_Pro, ISNULL(Func1.SpremnoPak, 0) AS SpremnoT_Pak, 
  ISNULL(Func1.IsporucenoPro, 0) AS IsporucenoT_Pro, ISNULL(Func1.IsporucenoPak, 0) AS IsporucenoT_Pak, 
  ISNULL(Func1.DaljnjaObradaPro, 0) AS DaljnjaObradaT_Pro, ISNULL(Func1.DaljnjaObradaPak, 0) AS DaljnjaObradaT_Pak, 
  ISNULL(Func1.VrstaPakiranja, '') AS PakiranjeT, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func1.VrstaPakiranja), 0) AS float) AS PakiranjeT_kg, 
  ISNULL(NarudzbeSta.BrojRN2, '') AS RN_Kaljenje, 
  ISNULL(Func2.SpremnoPro, 0) AS SpremnoK_Pro, ISNULL(Func2.SpremnoPak, 0) AS SpremnoK_Pak, 
  ISNULL(Func2.IsporucenoPro, 0) AS IsporucenoK_Pro, ISNULL(Func2.IsporucenoPak, 0) AS IsporucenoK_Pak, 
  ISNULL(Func2.DaljnjaObradaPro, 0) AS DaljnjaObradaK_Pro, ISNULL(Func2.DaljnjaObradaPak, 0) AS DaljnjaObradaK_Pak, 
  ISNULL(Func2.VrstaPakiranja, '') AS PakiranjeK_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func2.VrstaPakiranja), 0) AS float) AS PakiranjeK_kg, 
  ISNULL(NarudzbeSta.BrojRN3, '') AS RN_TvrdoTokarenje, 
  ISNULL(Func3.SpremnoPro, 0) AS SpremnoTT_Pro, ISNULL(Func3.SpremnoPak, 0) AS SpremnoTT_Pak, 
  ISNULL(Func3.IsporucenoPro, 0) AS IsporucenoTT_Pro, ISNULL(Func3.IsporucenoPak, 0) AS IsporucenoTT_Pak, 
  ISNULL(Func3.DaljnjaObradaPro, 0) AS DaljnjaObradaTT_Pro, ISNULL(Func3.DaljnjaObradaPak, 0) AS DaljnjaObradaTT_Pak, 
  ISNULL(Func3.VrstaPakiranja, '') AS PakiranjeTT_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func3.VrstaPakiranja), 0) AS float) AS PakiranjeTT_kg, 
  ISNULL(NarudzbeSta.BrojRN4, '') AS RN_Obrada4, 
  ISNULL(Func4.SpremnoPro, 0) AS SpremnoO4_Pro, ISNULL(Func4.SpremnoPak, 0) AS SpremnoO4_Pak, 
  ISNULL(Func4.IsporucenoPro, 0) AS IsporucenoO4_Pro, ISNULL(Func4.IsporucenoPak, 0) AS IsporucenoO4_Pak, 
  ISNULL(Func4.DaljnjaObradaPro, 0) AS DaljnjaObradaO4_Pro, ISNULL(Func4.DaljnjaObradaPak, 0) AS DaljnjaObradaO4_Pak, 
  ISNULL(Func4.VrstaPakiranja, '') AS PakiranjeO4_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func4.VrstaPakiranja), 0) AS float) AS PakiranjeO4_kg, 
  ISNULL(NarudzbeSta.BrojRN5, '') AS RN_Obrada5, 
  ISNULL(Func5.SpremnoPro, 0) AS SpremnoO5_Pro, ISNULL(Func5.SpremnoPak, 0) AS SpremnoO5_Pak, 
  ISNULL(Func5.IsporucenoPro, 0) AS IsporucenoO5_Pro, ISNULL(Func5.IsporucenoPak, 0) AS IsporucenoO5_Pak, 
  ISNULL(Func5.DaljnjaObradaPro, 0) AS DaljnjaO5_Pro, ISNULL(Func5.DaljnjaObradaPak, 0) AS DaljnjaObradaO5_Pak, 
  ISNULL(Func5.VrstaPakiranja, '') AS PakiranjeO5_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func5.VrstaPakiranja), 0) AS float) AS PakiranjeO5_kg 
  FROM NarudzbeSta 
  INNER JOIN NarudzbeZag ON NarudzbeSta.ID_NarZ = NarudzbeZag.ID_NarZ
  INNER JOIN VrsteNarudzbi ON NarudzbeZag.VrstaNar = VrsteNarudzbi.VrstaNar
  FULL OUTER JOIN SumeStatusaEvidencijeProizvodnje() Func1 ON (CASE WHEN VrsteNarudzbi.RnZaCalcKolicine = 'Bazni' THEN NarudzbeSta.BrojRN ELSE NarudzbeSta.BrojRN1 END) = Func1.BrojRN
  FULL OUTER JOIN SumeStatusaEvidencijeProizvodnje() Func2 ON NarudzbeSta.BrojRN2 = Func2.BrojRN
  FULL OUTER JOIN SumeStatusaEvidencijeProizvodnje() Func3 ON NarudzbeSta.BrojRN3 = Func3.BrojRN
  FULL OUTER JOIN SumeStatusaEvidencijeProizvodnje() Func4 ON NarudzbeSta.BrojRN4 = Func4.BrojRN
  FULL OUTER JOIN SumeStatusaEvidencijeProizvodnje() Func5 ON NarudzbeSta.BrojRN5 = Func5.BrojRN  
  WHERE NarudzbeSta.Aktivno = 1 
  AND NarudzbeSta.BazniRN = 1 
  AND NarudzbeSta.DatumIsporuke IS NOT NULL
  ORDER BY NarudzbeSta.DatumIsporuke