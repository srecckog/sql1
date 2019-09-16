USE FinkAT ; DECLARE @DatumOd date, @DatumDo date, @TmpGodina int;

SET @DatumOd = '2016-01-01';
SET @DatumDo = '2016-04-15';
SET @TmpGodina = 2016;

WITH MyTmpTable AS(
SELECT RadnikID, Ime, OpcinaRada, Opcina, (CASE WHEN DatumZaposljavanja2 IS NULL THEN DatumZaposljavanja ELSE DatumZaposljavanja2 END) AS DatumZaposljavanja, (CASE WHEN DatumPrestankaRada2 IS NULL THEN DatumPrestankaRada ELSE DatumPrestankaRada2 END) AS DatumPrestanka, oib, SifraRM, RadnoMjesto, (select sum(PlaceRadArh.Sati_NaRadu + PlaceRadArh.Sati_GodisnjiOdmor + PlaceRadArh.Sati_DrzavniBlagdan + PlaceRadArh.Sati_PlaceniDopust + PlaceRadArh.Sati_BolovanjeFirma + PlaceRadArh.Sati_NeopravdaniIzostanak + PlaceRadArh.Sati_Blagdan + PlaceRadArh.Sati_Nocni + PlaceRadArh.B1sat + PlaceRadArh.B2sat) from PlaceRadArh where PlaceRadArh.RadnikID = Radnici.RadnikID AND PlaceRadArh.Godina = @TmpGodina AND Mjesec <= MONTH(@DatumDo)) AS Sati, 
	CAST((select sum(PlaceRadArh.Iznos_Stimulacija + PlaceRadArh.Iznos_BolovanjeFirma + PlaceRadArh.OsnovicaRedovanRad + PlaceRadArh.OsnovicaNocniRad + PlaceRadArh.OsnovicaNeopravdaniIzostanak + PlaceRadArh.OsnovicaPrekovremeno + PlaceRadArh.OsnovicaGodOdmor + PlaceRadArh.OsnovicaNeiskorGO + PlaceRadArh.OsnovicaDrzBla + PlaceRadArh.OsnovicaPlaDopust + PlaceRadArh.OsnovicaDodatak + PlaceRadArh.OsnovicaNeplacGod + PlaceRadArh.OsnovicaPreraspod + PlaceRadArh.OsnovicaOtpremnina) from PlaceRadArh where PlaceRadArh.RadnikID = Radnici.RadnikID AND PlaceRadArh.Godina = @TmpGodina AND Mjesec <= MONTH(@DatumDo)) AS float) AS Bruto, 
	CAST((select sum(PlaceRadArh.DopZdrav1 + PlaceRadArh.DopZdrav2 + PlaceRadArh.DopZdrav3 + PlaceRadArh.DopZdrav4) from PlaceRadArh where PlaceRadArh.RadnikID = Radnici.RadnikID AND PlaceRadArh.Godina = @TmpGodina AND Mjesec <= MONTH(@DatumDo)) AS float) AS Dop_na_placu
	FROM Radnici 
	WHERE DatumZaposljavanja BETWEEN @DatumOd AND @DatumDo OR DatumPrestankaRada BETWEEN @DatumOd AND @DatumDo)

SELECT *, (CASE WHEN DatumZaposljavanja BETWEEN @DatumOd AND @DatumDo AND DatumPrestanka BETWEEN @DatumOd AND @DatumDo THEN 'Došli + otišli' WHEN DatumZaposljavanja BETWEEN @DatumOd AND @DatumDo THEN 'Došli' ELSE 'Otišli' END) AS Opis FROM MyTmpTable 
	ORDER BY Opis, SifraRM, RadnoMjesto

/*USE FinkAT;

WITH MyTmpTable AS(
SELECT RadnikID, ImeX AS Ime, PrezimeX AS Prezime, (CASE WHEN DatumZaposljavanja2 IS NULL THEN DatumZaposljavanja ELSE DatumZaposljavanja2 END) AS DatumZaposljavanja, (CASE WHEN DatumPrestankaRada2 IS NULL THEN DatumPrestankaRada ELSE DatumPrestankaRada2 END) AS DatumPrestanka 
	FROM Radnici 
	WHERE YEAR(DatumZaposljavanja) = 2012 
	OR YEAR(DatumZaposljavanja2) = 2012 
	OR YEAR(DatumPrestankaRada) = 2012 
	OR YEAR(DatumPrestankaRada2) = 2012)

SELECT *, (CASE WHEN YEAR(DatumZaposljavanja) = YEAR(DatumPrestanka) THEN 'Došli + otišli' WHEN YEAR(DatumZaposljavanja) = 2012 THEN 'Došli' ELSE 'Otišli' END) AS Opis FROM MyTmpTable 
	ORDER BY DatumZaposljavanja*/