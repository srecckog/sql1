USE FeroApp

-- DELETE FROM TmpInventura ; DBCC CHECKIDENT(TmpInventura, RESEED, 1)

/*INSERT INTO TmpInventura (ID_Par, Kupac, Vlasnistvo, Obrada, BrojRN, ID_Pro, Spremno_Pro, Spremno_Pak, VrstaPak, BazniRN)
  SELECT ID_Par, Narucitelj, (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, 'Tokareno', 
	RN_Tokarenje, ID_Pro_T, SpremnoT_Pro, SpremnoT_Pak, PakiranjeT_Pro, Bazni_RN 
	FROM StanjeProizvodnjeList('Prsteni')
	WHERE SpremnoT_Pro <> 0
INSERT INTO TmpInventura (ID_Par, Kupac, Vlasnistvo, Obrada, BrojRN, ID_Pro, Spremno_Pro, Spremno_Pak, VrstaPak, BazniRN)
  SELECT ID_Par, Narucitelj, (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, 'Kaljeno', 
	RN_Kaljenje, ID_Pro_K, SpremnoK_Pro, SpremnoK_Pak, PakiranjeK_Pro, Bazni_RN 
	FROM StanjeProizvodnjeList('Prsteni')
	WHERE SpremnoK_Pro <> 0
INSERT INTO TmpInventura (ID_Par, Kupac, Vlasnistvo, Obrada, BrojRN, ID_Pro, Spremno_Pro, Spremno_Pak, VrstaPak, BazniRN)
  SELECT ID_Par, Narucitelj, (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, 'Tvrdo tokareno', 
	RN_TvrdoTokarenje, ID_Pro_TT, SpremnoTT_Pro, SpremnoTT_Pak, PakiranjeTT_Pro, Bazni_RN 
	FROM StanjeProizvodnjeList('Prsteni')
	WHERE SpremnoTT_Pro <> 0*/

SELECT ID_Par, Kupac, Vlasnistvo, Obrada, BrojRN, (SELECT NarudzbeSta.ID_NarZ FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = TmpInventura.BrojRN) AS Narudzba, ID_Pro, 
	(SELECT Proizvodi.NazivPro FROM Proizvodi WHERE Proizvodi.ID_Pro = TmpInventura.ID_Pro) AS Proizvod, Spremno_Pro AS Kolicina_pro, Spremno_Pak AS Kolicina_pak, VrstaPak 
	FROM TmpInventura 
	ORDER BY Kupac, Vlasnistvo, Obrada