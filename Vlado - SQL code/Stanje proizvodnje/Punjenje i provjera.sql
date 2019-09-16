USE FeroApp ; DECLARE @SessionID varchar(30) ; SET @SessionID = 'abc: ' + CONVERT(VARCHAR(8), GETDATE(), 108)

-- DELETE FROM StanjeProizvodnjeTbl ; DELETE FROM StanjeProizvodnjeTblStanjeIZR ; DELETE FROM StanjeProizvodnjeTblPotrebanMat
-- DBCC CHECKIDENT(StanjeProizvodnjeTbl, RESEED, 1) ; DBCC CHECKIDENT(StanjeProizvodnjeTblStanjeIZR, RESEED, 1) ; DBCC CHECKIDENT(StanjeProizvodnjeTblPotrebanMat, RESEED, 1)
-- EXEC dbo.StanjeProizvodnje @TmpID_Par = 0, @TmpSessionID = @SessionID, @TmpVrstaNar = 'Prsteni', @TmpDatum = '2015-12-30'

SELECT * FROM StanjeProizvodnjeTbl
-- SELECT * FROM StanjeProizvodnjeTblStanjeIZR
/*SELECT ID_Mat, VlasnistvoFX, SUM(KolicinaOK) AS Kol_ok, SUM(KolicinaOtpadMat) AS Kol_otp_mat, SUM(KolicinaOtpadObrada) AS Kol_otp_obr, (SELECT SUM(SaldoKolicina) FROM StanjeProizvodnjeTblStanjeIZR WHERE StanjeProizvodnjeTblStanjeIZR.ID_Mat = StanjeProizvodnjeTblPotrebanMat.ID_Mat AND StanjeProizvodnjeTblStanjeIZR.VlasnistvoFX = StanjeProizvodnjeTblPotrebanMat.VlasnistvoFX) AS Izdatnica_kom 
	FROM StanjeProizvodnjeTblPotrebanMat 
	GROUP BY ID_Mat, VlasnistvoFX
	ORDER BY ID_Mat*/