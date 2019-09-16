USE FeroTmp

DECLARE @TmpBrojRN varchar(20), @TmpVrijednost decimal(17,6), @TmpIdUlr int, @TmpSaldoKolicina decimal(11,2), @TmpSaldoVrijednost decimal(20,10), @TmpKolicinaZaLipu decimal(30,20)  -- ID_IZD = 13494
DECLARE @TmpPreostaloKn decimal(30,20), @TmpPreostaloKom decimal(30,20), @TmpKolicinaZaIzdatnicu decimal(30,20), @TmpVrijednostZaIzdatnicu decimal(30,20)

DECLARE RadniNaloziList CURSOR FOR 
  SELECT BrojRN, Vrijednost 
    FROM TmpRN105_RN
OPEN RadniNaloziList
FETCH NEXT FROM RadniNaloziList INTO @TmpBrojRN, @TmpVrijednost
  WHILE @@FETCH_STATUS = 0
    BEGIN
	  IF @TmpBrojRN = '05/362-15' 
        PRINT 'RN ' + @TmpBrojRN + ', vrijednost ' + CAST(@TmpVrijednost AS varchar)
	  SET @TmpPreostaloKn = @TmpVrijednost

	  DECLARE StanjaUlrList CURSOR FOR 
        SELECT ID_ULR, SaldoKolicina, SaldoVrijednost, KolicinaZaLipu 
          FROM TmpRN105_ULR
		    WHERE SaldoKolicina > 0
		    ORDER BY ID_ULR
	  OPEN StanjaUlrList
	  FETCH NEXT FROM StanjaUlrList INTO @TmpIdUlr, @TmpSaldoKolicina, @TmpSaldoVrijednost, @TmpKolicinaZaLipu
	    WHILE @@FETCH_STATUS = 0
		  BEGIN
			IF @TmpSaldoVrijednost = @TmpPreostaloKn
			  BEGIN
			    UPDATE TmpRN105_ULR SET SaldoKolicina = 0, SaldoVrijednost = 0 WHERE ID_ULR = @TmpIdUlr
			    INSERT INTO IzlazRobe (ID_IZD, BrojRN, ID_Mat, JM, ID_ULR, MT, Kolicina, UserName, Uzorak, Neaktivno, FinkOK, IznosIzr)
				  VALUES(13494, @TmpBrojRN, (SELECT UlazRobe.ID_MAT FROM UlazRobe WHERE UlazRobe.ID_ULR = @TmpIdUlr), (SELECT UlazRobe.JM FROM UlazRobe WHERE UlazRobe.ID_ULR = @TmpIdUlr), @TmpIdUlr, '1', @TmpSaldoKolicina, 'vvarnaliev', 0, 0, 0, 0)
			    IF @TmpBrojRN = '05/362-15' 
   			      PRINT '      ID_ULR ' + CAST(@TmpIdUlr AS varchar) + ', vrijednost ' + CAST(@TmpSaldoVrijednost AS varchar)
				BREAK
			  END
			ELSE IF @TmpSaldoVrijednost < @TmpPreostaloKn
			  BEGIN
			    UPDATE TmpRN105_ULR SET SaldoKolicina = 0, SaldoVrijednost = 0 WHERE ID_ULR = @TmpIdUlr
			    INSERT INTO IzlazRobe (ID_IZD, BrojRN, ID_Mat, JM, ID_ULR, MT, Kolicina, UserName, Uzorak, Neaktivno, FinkOK, IznosIzr)
				  VALUES(13494, @TmpBrojRN, (SELECT UlazRobe.ID_MAT FROM UlazRobe WHERE UlazRobe.ID_ULR = @TmpIdUlr), (SELECT UlazRobe.JM FROM UlazRobe WHERE UlazRobe.ID_ULR = @TmpIdUlr), @TmpIdUlr, '1', @TmpSaldoKolicina, 'vvarnaliev', 0, 0, 0, 0)
				SET @TmpPreostaloKn  -= @TmpSaldoVrijednost
				SET @TmpPreostaloKom -= @TmpSaldoKolicina

			    IF @TmpBrojRN = '05/362-15' 
   			      PRINT '      ID_ULR ' + CAST(@TmpIdUlr AS varchar) + ', vrijednost ' + CAST(@TmpSaldoVrijednost AS varchar) + ', preostalo Kn ' + CAST(@TmpPreostaloKn AS varchar)
			  END		    
			ELSE IF @TmpSaldoVrijednost > @TmpPreostaloKn
			  BEGIN
			    SET @TmpVrijednostZaIzdatnicu = @TmpPreostaloKn
			    SET @TmpKolicinaZaIzdatnicu = @TmpSaldoKolicina / (@TmpSaldoVrijednost / @TmpPreostaloKn)

				UPDATE TmpRN105_ULR SET SaldoKolicina -= @TmpKolicinaZaIzdatnicu, SaldoVrijednost -= @TmpVrijednostZaIzdatnicu WHERE ID_ULR = @TmpIdUlr
			    INSERT INTO IzlazRobe (ID_IZD, BrojRN, ID_Mat, JM, ID_ULR, MT, Kolicina, UserName, Uzorak, Neaktivno, FinkOK, IznosIzr)
				  VALUES(13494, @TmpBrojRN, (SELECT UlazRobe.ID_MAT FROM UlazRobe WHERE UlazRobe.ID_ULR = @TmpIdUlr), (SELECT UlazRobe.JM FROM UlazRobe WHERE UlazRobe.ID_ULR = @TmpIdUlr), @TmpIdUlr, '1', @TmpKolicinaZaIzdatnicu, 'vvarnaliev', 0, 0, 0, 0)
				IF @TmpBrojRN = '05/362-15' 
				  PRINT '      ID_ULR ' + CAST(@TmpIdUlr AS varchar) + ', vrijednost ' + CAST(@TmpVrijednostZaIzdatnicu AS varchar) + ', kolicina ' + CAST(@TmpKolicinaZaIzdatnicu AS varchar) + '  - BREAK'
				BREAK
			  END
		    FETCH NEXT FROM StanjaUlrList INTO @TmpIdUlr, @TmpSaldoKolicina, @TmpSaldoVrijednost, @TmpKolicinaZaLipu
		  END
	  CLOSE StanjaUlrList ; DEALLOCATE StanjaUlrList

      FETCH NEXT FROM RadniNaloziList INTO @TmpBrojRN, @TmpVrijednost
    END
CLOSE RadniNaloziList ; DEALLOCATE RadniNaloziList

