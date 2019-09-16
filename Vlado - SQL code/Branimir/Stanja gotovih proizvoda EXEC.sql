USE FeroTmp

-- DELETE FROM UlazProizvoda WHERE ID_PRE = 5107
-- DELETE FROM StanjeProizvodnjeTbl ; DELETE FROM StanjeProizvodnjeTblPotrebanMat ; DELETE FROM StanjeProizvodnjeTblStanjeIZR
-- EXEC StanjeProizvodnje  @TmpID_Par = 0, @TmpSessionID = 'xyz', @TmpVrstaNar = 'Prsteni', @TmpDatum = '2015-11-17'

SELECT ID, SessionID, ID_NarS, VlasnistvoFX, ID_Mat, ID_Pro, BrojRN, KolPredBazniRN, Tokarenje, BrojRN1, ProizvedenoTok, Kaljenje, BrojRN2, ProizvedenoKalj, TvrdoTok, BrojRN3, ProizvedenoTT, 
    (CASE WHEN TvrdoTok = 1 THEN (ProizvedenoTT - KolPredBazniRN) WHEN Kaljenje = 1 THEN (ProizvedenoKalj - KolPredBazniRN) WHEN Tokarenje = 1 THEN (ProizvedenoTok - KolPredBazniRN) ELSE 0 END) AS KolZaPred, OmjerPro 
  FROM StanjeProizvodnjeTbl
  WHERE (CASE WHEN TvrdoTok = 1 THEN (ProizvedenoTT - KolPredBazniRN) WHEN Kaljenje = 1 THEN (ProizvedenoKalj - KolPredBazniRN) WHEN Tokarenje = 1 THEN (ProizvedenoTok - KolPredBazniRN) ELSE 0 END) > 0
SELECT * FROM StanjeProizvodnjeTblStanjeIZR WHERE SessionID = 'xyz' AND ID_Mat = 920282 AND VlasnistvoFX = 1
-- EXEC EvidPro2Predatnica @TmpSessionID = 'xyz', @TmpIdPre = 5107, @TmpUsername = 'vvarnaliev'

-- SELECT * FROM UlazProizvodaDetaljnoView WHERE BrojRN = '2759/2015'