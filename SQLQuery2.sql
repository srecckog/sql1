USE [RFIND]
GO
/****** Object:  UserDefinedFunction [dbo].[EvidNormiRadaD]    Script Date: 20.2.2018. 8:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[EvidNormiRadaD] 
(@DatumOd date, @DatumDo date)
RETURNS TABLE 
AS
RETURN

select top 1000 x1.* from (
SELECT Radnik, ID_Radnika, 'Stroj' AS Vrsta, (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiSta.ID_Radnika) AS Firma, 
	(SELECT Datum from feroapp.dbo.EvidencijaNormiZag WHERE ID_ENZ = feroapp.dbo.EvidencijaNormiSta.ID_ENZ) AS Datum, 
	(SELECT Hala from feroapp.dbo.EvidencijaNormiZag WHERE ID_ENZ = feroapp.dbo.EvidencijaNormiSta.ID_ENZ) AS Hala, 
	(SELECT Smjena from feroapp.dbo.EvidencijaNormiZag WHERE ID_ENZ = feroapp.dbo.EvidencijaNormiSta.ID_ENZ) AS Smjena, Linija, 
	(SELECT Partneri.NazivPar from feroapp.dbo.Partneri WHERE Partneri.ID_Par = (SELECT NDV.ID_Par from feroapp.dbo.NarudzbeDetaljnoView NDV WHERE NDV.BrojRN = EvidencijaNormiSta.BrojRN)) AS NazivPar, BrojRN, 
	(SELECT NazivPro from feroapp.dbo.Proizvodi WHERE ID_Pro = (SELECT ID_Pro from feroapp.dbo. NarudzbeSta WHERE BrojRN = feroapp.dbo.EvidencijaNormiSta.BrojRN)) AS Proizvod, Norma, KolicinaOK, OtpadObrada, OtpadMat, 
	(CASE WHEN VrijemeOd IS NULL OR VrijemeDo IS NULL THEN 0 WHEN DATEDIFF(n, VrijemeOd, VrijemeDo) < 0 THEN DATEDIFF(n, VrijemeOd, VrijemeDo) + 1440 ELSE DATEDIFF(n, VrijemeOd, VrijemeDo) END) AS MinutaRadaRadnika, 
	Napomena1, Napomena2, Napomena3, '' TekstCheck01, '' TekstCheck02, '' TekstCheck03, '' TekstCheck04, 
	'' TekstCheck05, '' TekstCheck06, '' TekstCheck07, '' TekstCheck08, '' TekstCheck09, '' TekstCheck10, '' TekstCheck11, '' TekstCheck12, '' TekstCheck13, 
	'' TekstCheck14, '' TekstCheck15, '' TekstCheck16, '' TekstCheck17, '' TekstCheck18, '' TekstCheck19, '' TekstCheck20, (CASE WHEN ISNULL(ID_Radnika2, 0) = 0 THEN '' ELSE 'Pomoć ' + Radnik2 END) AS PomocniRadnik, ID_Radnika2, 
	(CASE WHEN VrijemeOd2 IS NULL OR VrijemeDo2 IS NULL THEN 0 WHEN DATEDIFF(n, VrijemeOd2, VrijemeDo2) < 0 THEN DATEDIFF(n, VrijemeOd2, VrijemeDo2) + 1440 ELSE DATEDIFF(HOUR, VrijemeOd2, VrijemeDo2) END) AS MinutaRadaPomocnogRadnika
	from feroapp.dbo.EvidencijaNormiSta WHERE ID_ENZ IN(SELECT ID_ENZ from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo) AND ID_Radnika IS NOT NULL AND ID_Radnika <> 0 
UNION ALL 
SELECT Radnik, ID_Radnika, 'Ostalo' AS Vrsta, (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiRadnici.ID_Radnika), 
	(SELECT Datum from feroapp.dbo.EvidencijaNormiZag WHERE ID_ENZ = EvidencijaNormiRadnici.ID_ENZ), 
	(SELECT Hala from feroapp.dbo.EvidencijaNormiZag WHERE ID_ENZ = EvidencijaNormiRadnici.ID_ENZ), 
	(SELECT Smjena from feroapp.dbo.EvidencijaNormiZag WHERE ID_ENZ = EvidencijaNormiRadnici.ID_ENZ), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati*60, Napomena1, Napomena2, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	from feroapp.dbo.EvidencijaNormiRadnici 
	WHERE ID_ENZ IN(SELECT ID_ENZ from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo) AND ID_Radnika IS NOT NULL AND ID_Radnika <> 0 
UNION ALL 
SELECT (SELECT UPPER(FxFirme.dbo.AppUsers.UserPunoIme) from FxFirme.dbo.AppUsers WHERE FxFirme.dbo.AppUsers.UserName = EvidencijaNormiZag.UserName), NULL, 'Šteler', '-', 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Steler*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo 
UNION ALL 
SELECT UPPER(Steler2), ID_Steler2, 'Šteler #2', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Steler2), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Steler2*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo. EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Steler2 IS NOT NULL AND ID_Steler2 <> 0 
UNION ALL 
SELECT UPPER(Kontrola), ID_Kontrola, 'Kontrola', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Kontrola), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Kontrola*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Kontrola IS NOT NULL AND ID_Kontrola <> 0 
UNION ALL 
SELECT UPPER(Kontrola2), ID_Kontrola2, 'Kontrola', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Kontrola2), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Kontrola2*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Kontrola2 IS NOT NULL AND ID_Kontrola2 <> 0 
UNION ALL 
SELECT UPPER(Kontrola3), ID_Kontrola3, 'Kontrola', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Kontrola3), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Kontrola3*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Kontrola3 IS NOT NULL AND ID_Kontrola3 <> 0 
UNION ALL 
SELECT UPPER(Bravar), ID_Bravar, 'Bravar', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Bravar), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Bravar*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Bravar IS NOT NULL AND ID_Bravar <> 0 
UNION ALL 
SELECT UPPER(Bravar2), ID_Bravar2, 'Bravar', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Bravar2), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Bravar2*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Bravar2 IS NOT NULL AND ID_Bravar2 <> 0 
UNION ALL 
SELECT UPPER(Pilar), ID_Pilar, 'Pilar', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Pilar), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Pilar*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo  AND ID_Pilar IS NOT NULL AND ID_Pilar <> 0 
UNION ALL 
SELECT UPPER(Ekolog), ID_Ekolog, 'Ekolog', (SELECT (CASE WHEN ID_Firme = 1 THEN 'AT' ELSE 'FX' END) from feroapp.dbo. Radnici WHERE ID_Radnika = EvidencijaNormiZag.ID_Ekolog), 
	Datum, Hala, Smjena, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, BrojSati_Ekolog*60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from feroapp.dbo.EvidencijaNormiZag WHERE Datum BETWEEN @DatumOd AND @DatumDo AND ID_Ekolog IS NOT NULL AND ID_Ekolog <> 0 
	UNION ALL 

-- na bo,go,0e
SELECT (prezime+' '+ime) ime, idradnika, 'NDBG', (SELECT (CASE WHEN charindex('Fero',r.poduzece)>0  THEN 'AT' ELSE 'FX' END)) , 
	@Datumod, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, pv.radnomjesto, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	from rfind.dbo.radnici_ r
	left join pregledvremena pv on r.id=pv.idradnika
	where  @Datumod=pv.datum and ( pv.radnomjesto in ( 'BO','BO2','B.O.','GO','G.O') or year(dosao)=1900) and r.mt  in ( 700,702,716,701) 
	
	UNION ALL
-- novi djelatnici	
SELECT (prezime+' '+ime) ime, id, 'NDNZ', (SELECT (CASE WHEN charindex('Fero',r.poduzece)>0  THEN 'AT' ELSE 'FX' END)) , 
	@Datumod, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, r.radnomjesto, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	from rfind.dbo.radnici_ r
	where  @Datumod<=r.DatumZaposlenja

union all
-- nezaplanirani
SELECT (prezime+' '+ime) ime, id, 'NDP', (SELECT (CASE WHEN charindex('Fero',r.poduzece)>0  THEN 'AT' ELSE 'FX' END)) , 
	@Datumod, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, r.radnomjesto, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	from rfind.dbo.radnici_ r
	WHERE r.id not in 
	(
	select idradnika
	from pregledvremena
	where datum=@datumOd
	)
	and r.neradi=0
	and r.mt IN ( 700,701,702,716)

	) x1


	order by x1.vrsta,x1.hala,x1.smjena,x1.linija