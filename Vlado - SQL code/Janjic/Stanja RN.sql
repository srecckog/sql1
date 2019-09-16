USE FeroApp

SELECT NS.BrojRN AS RN_Tokarenje, NS.BrojRN2 AS RN_Kaljenje, NS.DatumIsporuke, CAST(NS.KolicinaNar AS float) AS KolicinaNar, 
	(SELECT SUM(ISNULL(ENS.KolicinaOK, 0)) FROM EvidencijaNormiSta ENS WHERE ENS.BrojRN = NS.BrojRN AND ENS.ObradaA = 1) AS Tokareno_norme, 
	(SELECT SUM(ISNULL(ENS.OtpadMat, 0)) FROM EvidencijaNormiSta ENS WHERE ENS.BrojRN = NS.BrojRN AND ENS.ObradaA = 1) AS OtpadMat_norme, 
	(SELECT SUM(ISNULL(ENS.OtpadObrada, 0)) FROM EvidencijaNormiSta ENS WHERE ENS.BrojRN = NS.BrojRN AND ENS.ObradaA = 1) AS OtpadObrada_norme, 
	(SELECT SUM(ISNULL(EPV.KolicinaOK, 0)) FROM EvidencijaProizvodnjeView EPV WHERE EPV.BrojRN = NS.BrojRN) AS Tokareno_kontrola, 
	(SELECT SUM(ISNULL(EPV.OtpadMaterijal, 0)) FROM EvidencijaProizvodnjeView EPV WHERE EPV.BrojRN = NS.BrojRN) AS OdpadMat_kontrola, 
	(SELECT SUM(ISNULL(EPV.OtpadObrada, 0)) FROM EvidencijaProizvodnjeView EPV WHERE EPV.BrojRN = NS.BrojRN) AS OdpadObrada_kontrola, 
	(SELECT SUM(ISNULL(EPV.KolicinaOK, 0)) FROM EvidencijaProizvodnjeView EPV WHERE EPV.BrojRN = NS.BrojRN2) AS Kaljeno_kontrola, 
	CAST((SELECT SUM(ISNULL(FS.KolicinaPro, 0)) FROM FaktureSta FS WHERE FS.BrojRN = NS.BrojRN AND FS.VrstaTroska = 'Proizvod') AS float) AS Fakturirano 
	FROM NarudzbeSta NS 
	WHERE NS.BrojRN IN('852/2017', '854/2017', '868/2017', '961/2017')

-- SELECT * FROM StanjeProizvodnjeList('*', 'Neisporuceno') EPL WHERE EPL.Bazni_RN IN('852/2017', '854/2017', '868/2017', '961/2017')