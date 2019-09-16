USE FeroApp ; DECLARE @DatumOd date, @DatumDo date ; SET @DatumOd = '2016-01-01' ; SET @DatumDo = '2016-06-30'

UPDATE UlazProizvoda SET FinkOK = 1, IznosUlp = dbo.CalcVrijednostULP(ID_ULP, 0), IznosUlpOtpad = dbo.CalcVrijednostUlpOtpad(ID_ULP, 0) 
	WHERE ID_ULP in(SELECT ID_ULP FROM UlazProizvodaDetaljnoView WHERE DatumDokumenta BETWEEN @DatumOd AND @DatumDo AND ID_Skl NOT IN(103,104,107) AND FinkOK = 0)

UPDATE UlazProizvodaKorekcija SET FinkOK = 1, IznosUpk = dbo.CalcVrijednostUPK(ID_UPK, 0) 
	WHERE ID_UPK in(SELECT ID_UPK FROM UpkDetaljnoView WHERE DatumKorekcije BETWEEN @DatumOd AND @DatumDo AND ID_Skl NOT IN(103,104,107) AND FinkOK = 0)

UPDATE UlazRobe SET FinkOK = 1, IznosUlr = dbo.CalcVrijednostULR(ID_ULR)
	WHERE ID_ULR in(SELECT ID_ULR FROM UlazRobeDetaljnoView WHERE DatumUlaza BETWEEN @DatumOd AND @DatumDo AND ID_Skl NOT IN(99,103,104,107) AND FinkOK = 0)

UPDATE UlazRobeKorekcija SET FinkOK = 1, IznosUrk = dbo.CalcVrijednostURK(ID_URK)
	WHERE ID_URK in(SELECT ID_URK FROM UrkDetaljnoView WHERE DatumKorekcije BETWEEN @DatumOd AND @DatumDo AND ID_Skl NOT IN(99,103,104,107) AND FinkOK = 0)

UPDATE IzlazRobe SET FinkOK = 1, IznosIzr = dbo.CalcVrijednostIZR(ID_IZR)
	WHERE ID_IZR in(SELECT ID_IZR FROM IzlazRobeDetaljnoView WHERE DatumIzlaza BETWEEN @DatumOd AND @DatumDo AND ID_Skl NOT IN(99,103,104,107) AND FinkOK = 0)

UPDATE IzlazRobeKorekcija SET FinkOK = 1, IznosIrk = dbo.CalcVrijednostIRK(ID_IRK)
	WHERE ID_IRK in(SELECT ID_IRK FROM IrkDetaljnoView WHERE DatumKorekcije BETWEEN @DatumOd AND @DatumDo AND ID_Skl NOT IN(99,103,104,107) AND FinkOK = 0)
