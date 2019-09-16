USE FeroApp; 

WITH MyTmpTable1 AS(
SELECT ID_NarS, VrstaNar, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, RN_Kaljenje, RN_TvrdoTokarenje, 
	(CASE StanjeProizvodnjeList.ZavrsnaObrada WHEN 'Brusenje' THEN RN_Brusenje WHEN 'Tvrdo tokarenje' THEN RN_TvrdoTokarenje WHEN 'Kaljenje' THEN RN_Kaljenje ELSE RN_Tokarenje END) AS ZavrsniRN, 
	SpremnoT_Pro, SpremnoK_Pro, SpremnoTT_Pro, SpremnoBR_Pro, 
	(SELECT MAX(EvidencijaProizvodnjeView.Datum) FROM EvidencijaProizvodnjeView WHERE EvidencijaProizvodnjeView.BrojRN = (CASE StanjeProizvodnjeList.ZavrsnaObrada WHEN 'Brusenje' THEN RN_Brusenje WHEN 'Tvrdo tokarenje' THEN RN_TvrdoTokarenje WHEN 'Kaljenje' THEN RN_Kaljenje ELSE RN_Tokarenje END)) AS DatumZadnjeObrade 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') 
	WHERE (NapravljenoT_Pro + NapravljenoK_Pro + NapravljenoTT_Pro + NapravljenoBR_Pro) > 0
	AND (SpremnoT_Pro + SpremnoK_Pro + SpremnoTT_Pro + SpremnoBR_Pro) = 0), 
MyTmpTable2 AS(
SELECT DATEDIFF(DAY,  DatumZadnjeObrade, GETDATE()) AS DanaOdZadnjeObrade, * FROM MyTmpTable1 WHERE DatumZadnjeObrade IS NOT NULL AND DATEDIFF(DAY,  DatumZadnjeObrade, GETDATE()) > 20)

UPDATE NarudzbeSta SET NarudzbeSta.Aktivno = 0, NarudzbeSta.Isporuceno = 1 WHERE NarudzbeSta.ID_NarS IN(SELECT ID_NarS FROM MyTmpTable2)
UPDATE NarudzbeSta SET NarudzbeSta.Aktivno = 0, NarudzbeSta.Isporuceno = 1 WHERE NarudzbeSta.ID_NarS IN(SELECT NS.ID_NarS FROM NarudzbeSta NS WHERE NS.Aktivno = 1 AND NS.Obrada2 = 1 AND NS.BazniRN = 0 AND (SELECT NSx.Aktivno FROM NarudzbeSta NSx WHERE NSx.BrojRN = NS.ParentRN) = 0)
UPDATE NarudzbeSta SET NarudzbeSta.Aktivno = 0, NarudzbeSta.Isporuceno = 1 WHERE NarudzbeSta.ID_NarS IN(SELECT NS.ID_NarS FROM NarudzbeSta NS WHERE NS.Aktivno = 1 AND NS.Obrada3 = 1 AND NS.BazniRN = 0 AND (SELECT NSx.Aktivno FROM NarudzbeSta NSx WHERE NSx.BrojRN = NS.ParentRN) = 0)
UPDATE NarudzbeSta SET NarudzbeSta.Aktivno = 0, NarudzbeSta.Isporuceno = 1 WHERE NarudzbeSta.ID_NarS IN(SELECT NS.ID_NarS FROM NarudzbeSta NS WHERE NS.Aktivno = 1 AND NS.Obrada4 = 1 AND NS.BazniRN = 0 AND (SELECT NSx.Aktivno FROM NarudzbeSta NSx WHERE NSx.BrojRN = NS.ParentRN) = 0)