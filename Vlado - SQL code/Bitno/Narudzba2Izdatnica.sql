USE [FeroTmp]
GO

/****** Object:  StoredProcedure [dbo].[Narudzba2Izdatnica]    Script Date: 07/30/2015 19:16:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		VV
-- Create date: 2013-02-14
-- Description:	Utrošak materijala
-- =============================================
CREATE PROCEDURE [dbo].[Narudzba2Izdatnica] 
	@UlazniIdIzd int, @TmpDatumIzdatnice date, @TmpIdNarS int, @TmpUsername varchar(30), @TmpLockEntryDate date
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @AllesGut tinyint ; SET @AllesGut = 1
  
  IF ISNULL(@TmpIdNarS, 0) <> 0
    BEGIN 
      IF ISNULL(@UlazniIdIzd, 0) = 0 
        BEGIN
          IF ISNULL(@TmpDatumIzdatnice, '') = ''
            SET @TmpDatumIzdatnice = CAST(GETDATE() AS DATE)
          ELSE IF @TmpDatumIzdatnice < @TmpLockEntryDate
            BEGIN
              PRINT 'Uneseni datum izdatnice je manji od LockEntryDate!'
              SET @AllesGut = 0
            END
                   
          IF @AllesGut = 1  
            BEGIN
              SELECT @UlazniIdIzd = Izdatnica + 1 FROM Brojaci WHERE ID_BRO = 1
              UPDATE Brojaci SET Izdatnica = @UlazniIdIzd WHERE ID_BRO = 1
          
              INSERT INTO IzlazniDokumenti (VrstaDokumenta, BrojDokumenta, DatumIzlaza, MT, Zatrazio, Odobrio, Skladistar, Primio, Kontrola, Knjizio)
                VALUES('Izdatnica', CAST(@UlazniIdIzd AS Varchar) + '/1', @TmpDatumIzdatnice, '1', @TmpUsername, @TmpUsername, 'Automatski generirani dokument', '', '', '')
	        
    	      SELECT @UlazniIdIzd = SCOPE_IDENTITY()
            END
        END
    
      IF @AllesGut = 1  
        BEGIN
          IF NOT EXISTS(SELECT * FROM IzlazniDokumenti WHERE ID_IZD = @UlazniIdIzd)
            BEGIN
              PRINT 'Uneseni ID izlaznog dokumenta ' + CAST(@UlazniIdIzd AS Varchar) + ' ne postoji u izlaznim dokumentima!'
              SET @AllesGut = 0
            END
          ELSE IF NOT EXISTS(SELECT * FROM IzlazniDokumenti WHERE ID_IZD = @UlazniIdIzd AND VrstaDokumenta = 'Izdatnica')
            BEGIN
              PRINT 'Uneseni ID izlaznog dokumenta ' + CAST(@UlazniIdIzd AS Varchar) + ' nije vrste "Izdatnica"!'
              SET @AllesGut = 0
            END
          ELSE IF (SELECT DatumIzlaza FROM IzlazniDokumenti WHERE ID_IZD = @UlazniIdIzd) < @TmpLockEntryDate
            BEGIN
              PRINT 'Odabrana izdatnica ID ' + CAST(@UlazniIdIzd AS Varchar) + ' ima datum manji od LockEntryDate!'
              SET @AllesGut = 0
            END
        END
        
      IF @AllesGut = 1
        BEGIN
          IF ISNULL(@UlazniIdIzd, 0) <> 0
            BEGIN
              PRINT 'Knjižiti stavke narudžbe ID ' + CAST(@TmpIdNarS AS Varchar) + ' u izlazni dokument ID ' + CAST(@UlazniIdIzd AS Varchar)
            END
        END
    END
  ELSE
    BEGIN
      PRINT 'Nema IDa stavke narudžbe!'
    END
END

GO

