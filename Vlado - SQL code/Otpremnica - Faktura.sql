USE FeroApp ; DECLARE @TmpBrojFakture varchar(20)

-- Otpremnica 778-1-978 fx
-- 1800 kom sa rn 3387 na 3387
-- 198+1102 kom sa 3389 na 3389
-- 792 kom sa rn 3474 na rn 3831

SET @TmpBrojFakture = '778-1-978'
SELECT ID_FS, ID_Ulp, RedniBroj, VrstaFakture, BrojFakture, KolicinaMat, KolicinaPro, BrojRN, ID_NarZ, Obrada1, BrojRN1, BrojNar1, Obrada2, BrojRN2, BrojNar2 FROM FaktureDetaljnoView WHERE BrojFakture = @TmpBrojFakture AND VrstaTroska = 'Proizvod' ORDER BY ID_Ulp
SELECT * FROM UlazProizvodaDetaljnoView WHERE ID_ULP IN(SELECT ID_Ulp FROM FaktureDetaljnoView WHERE BrojFakture = @TmpBrojFakture AND VrstaTroska = 'Proizvod') ORDER BY ID_Ulp
SELECT * FROM NarudzbeSta WHERE BrojRN IN(SELECT BrojRN FROM FaktureDetaljnoView WHERE BrojFakture = @TmpBrojFakture AND VrstaTroska = 'Proizvod' GROUP BY BrojRN)