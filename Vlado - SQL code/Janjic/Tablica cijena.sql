USE FeroApp
/*Težina sirovca (otkivak/ispiljak), težina gotovog komada, ulazna cijena sirovog materijala, cijena strojne obrade, datum fakture, dobavljaè sirovog materijala, 
njihova šifra sirovog materijala (ako je otkivak), nevezano na tu fakturu cijena toplinske obrade ako je ima (za danji sluèaj kad se fakturirala za tu poziciju).*/
SELECT *, CAST((SELECT (CASE WHEN ISNULL(OmjerPro, 0) = 0 THEN 1 ELSE OmjerPro END) FROM Materijali WHERE ID_Mat = (SELECT ID_Mat FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS)) AS float) AS Omjer, 
	CAST((SELECT TezinaMatKom FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS) AS float) AS TezinaMatKom, CAST((SELECT TezinaProKom FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS) AS float) AS TezinaProKom, 
	CAST((SELECT (CASE WHEN VrstaOtpisa = 'Komadno' THEN CijenaMatKom ELSE CijenaMatKg * TezinaMatKom END) FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS) AS float) AS CijenaMatKom, 
	CAST((CASE WHEN VrstaOtpisa = 'Komadno' THEN (SELECT CijenaObrada1 FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS) ELSE (SELECT NarudzbeSta.CijenaObrada1 FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS)) END) AS float) AS CijenaTok, 
	CAST((SELECT CijenaObrada2 FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS) AS float) AS CijenaKalj, CAST((SELECT CijenaObrada3 FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS) AS float) AS CijenaTT, 
	(SELECT ID_Mat_Dob FROM Materijali WHERE ID_Mat = (SELECT ID_Mat FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS)) AS SAP_ID_Mat, 
	(SELECT BrojFakture FROM FaktureDetaljnoView WHERE ID_FS = TmpJanjic.ID_FS) AS BrojFakture, (SELECT DatumFakture FROM FaktureDetaljnoView WHERE ID_FS = TmpJanjic.ID_FS) AS DatumFakture, 
	(SELECT NazivPar FROM Partneri WHERE ID_Par = (SELECT ID_Par FROM UlazRobeDetaljnoView WHERE ID_ULR = (SELECT ID_ULR FROM IzlazRobe WHERE ID_IZR = (SELECT ID_IZR FROM UlazProizvoda WHERE ID_ULP = (SELECT ID_ULP FROM FaktureSta WHERE ID_FS = TmpJanjic.ID_FS))))) AS DobaljvacMat 
	FROM TmpJanjic 
	ORDER BY Item