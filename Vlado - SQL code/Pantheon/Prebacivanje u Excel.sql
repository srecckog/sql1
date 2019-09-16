USE FinkAT

-- OSNOVNI PODACI --
/*SELECT Rad.PantheonID, Rad.RadnikID, (CASE WHEN Rad.NeRadi = 1 THEN 'F' ELSE 'T' END) AS Aktivan, '1. Radnik' AS Status, '' AS eMail, '' AS Prefiks, Rad.PrezimeX AS Prezime, Rad.ImeX AS Ime, '' AS Srednje_ime, '' AS Ime_oca, '' AS Ime_majke, '' AS Sufiks, 
	'' AS Prezime_kod_rodjenja, Rad.JMBG, 'HR' AS Porezni_broj, Rad.OIB, '' AS Porezna_ispostava, (CASE WHEN Rad.Spol = 'M' THEN 1 ELSE 2 END) AS Spol, '' AS Bracni_status, '' AS Datum_vjencanja, 'Hrvatska' AS Drzavljanostvo_drzava, Rad.Drzavljanstvo, Rad.DatumRodjenja, 
	'' AS Posta_rodjenja, '' AS Mjesto_rojdenja, '' AS Opcina_rodjenja, Rad.DrzavaRodjenja, (CASE WHEN Rad.NacinZaposljavanja = 'ODREÐENO' THEN NULL ELSE Rad.DatumZaposljavanja END) AS Datum_pocetka_stalno, 
	(CASE WHEN Rad.NacinZaposljavanja = 'ODREÐENO' THEN NULL ELSE Rad.DatumPrestankaRada END) AS Datum_kraja_stalno, Rad.Adresa, PP.Posta, PP.Mjesto, PO.Opcina_Full AS Opcina, 'HRVATSKA' AS Drzava, 
	'' AS Telefon, (CASE WHEN Rad.NacinZaposljavanja = 'ODREÐENO' THEN Rad.DatumZaposljavanja ELSE NULL END), (CASE WHEN Rad.NacinZaposljavanja = 'ODREÐENO' THEN Rad.DatumPrestankaRada ELSE NULL END), '' AS Ulica_priv, '' AS Posta_priv, '' AS Kraj_priv, '' AS Opcina_priv, '' AS Drzava_priv, 
	'' AS Telefon_priv, '' AS Reg_Auto, '' AS Samohran_a, Rad.RFID AS Brojkartice, '' AS Napomena 
	FROM Radnici Rad 
		LEFT JOIN Pantheon_Poste PP ON Rad.Posta = PP.PostanskiBroj 
		LEFT JOIN Opcine OPC ON Rad.Opcina = OPC.Opcina 
		LEFT JOIN Pantheon_Opcine PO ON OPC.Naziv = PO.Opcina S
	WHERE Rad.RadnikID IN(SELECT PRA.RadnikID FROM PlaceRadArh PRA WHERE PRA.Godina = 2016 AND PRA.Mjesec = 12) 
		OR Rad.NeRadi = 0 
	ORDER BY Rad.RadnikID */
-- PARAMETRI ZA IZRAÈUN PLAÆE --
/*SELECT Rad.PantheonID, Rad.RadnoMjesto, Rad.DatumZaposljavanja, Rad.Lokacija AS Odjel, Rad.MT, Rad.MjestoRada, '' AS Tarifni_razred, 
	(CASE WHEN Rad.NacinZaposljavanja = 'ODREÐENO' THEN 'RADNIK - odreðeno rad. vrijeme' ELSE 'RADNIK - neodreðeno rad. vr.' END) AS Radni_odnos, '' AS Radni_odnos_do, 
	(CASE WHEN Rad.SifraRM IN('Rez', 'Režija') THEN 1 ELSE 8 END) AS Rad_u_smjeni, 0, 'Bez poveæanja'
	FROM Radnici Rad 
	WHERE Rad.RadnikID IN(SELECT PRA.RadnikID FROM PlaceRadArh PRA WHERE PRA.Godina = 2016 AND PRA.Mjesec = 12) 
		OR Rad.NeRadi = 0 
	ORDER BY Rad.RadnikID*/
-- RADNA KNJIŽICA --
/*SELECT Rad.PantheonID, 'T' AS Radni_staz, '1' AS Status, Rad.DatumZaposljavanja AS Pocetak, Rad.DatumPrestankaRada AS Kraj, '' AS Radni_staz, 'F' AS Odmor, 'F' AS Jubilej, 'T' AS Uvazava_se, 'F' AS Probni_rad
	FROM Radnici Rad 
	WHERE Rad.RadnikID IN(SELECT PRA.RadnikID FROM PlaceRadArh PRA WHERE PRA.Godina = 2016 AND PRA.Mjesec = 12) 
		OR Rad.NeRadi = 0 
	ORDER BY Rad.RadnikID*/
-- RAÈUNI --
/*SELECT Rad.PantheonID, 'T' AS Aktivan, 'D' AS Tip_racuna, (SELECT PB.Banka FROM Pantheon_Banke PB WHERE PB.Banka = ((SELECT Ban.Naziv FROM Banke Ban WHERE Ban.ID_BAN = Rad.SifraBanke))) AS Banka, 
	(SELECT SUBSTRING(Ban.Ziro,1 ,7) FROM Banke Ban WHERE Ban.ID_BAN = Rad.SifraBanke) + Rad.BrTekRacuna AS Racun, '' AS Racun_I, SUBSTRING(Rad.IBAN, 1, 2) AS UPN_referenca, SUBSTRING(Rad.IBAN, 3, 2) AS Model, 
	'' AS Poziv, '' AS Poziv_P, '' AS Jedinica_banke, Rad.BrTekRacuna AS Broj_partije, 'S' AS Kreiranje_platnog_naloga, 'X' AS Nacin_isplate 
	FROM Radnici Rad 
	WHERE Rad.RadnikID IN(SELECT PRA.RadnikID FROM PlaceRadArh PRA WHERE PRA.Godina = 2016 AND PRA.Mjesec = 12) 
		OR Rad.NeRadi = 0 
	ORDER BY Rad.RadnikID*/
-- PROIZVOLJNA POLJA --
/*SELECT Rad.PantheonID, 'T' AS Aktivan, 'F' AS Otplacen, 0 AS Prioritet, Kre.Naziv, '' AS Kreditor_I, 'M' AS Tecaj, KZ.BrojPartijeKredita, 
	KZ.Datum AS RazdobljeOd, '' AS RazdboljeDo, 'HRK' AS Valuta, KZ.BrojRata, CAST(KZ.IznosRate AS float) AS Iznos_rate, CAST(KZ.IznosKredita AS float) AS Iznos_kredita, '0' AS Periodika, KZ.Vrsta AS Tip, '' AS Model, KZ.BrojPartijeKredita AS Poziv, '' AS Jdinica_banke, 
	32 AS Sifra_platnog_naloga, 'OTHR' AS Sifra_namjene, 14 AS Vrsta_posla, 'N' AS Osobni_odbitak, CAST(KZ.UkupnoObustavljeno AS float) AS Obustavljeno, KZ.BrojObracunatihRata 
	FROM KreditiZag KZ 
		LEFT JOIN Radnici Rad ON KZ.ID_Radnika = Rad.RadnikID 
		LEFT JOIN Kreditori Kre ON KZ.ID_Kreditora = Kre.ID_KRE 
	WHERE Neaktivan = 0*/
-- OSOBNI ODBITAK --
/*SELECT Rad.RadnikID, Rad.PantheonID, CAST(Rad.PoreznaOlaksica AS float) AS Osobni_odbitak
	FROM Radnici Rad 
	WHERE (Rad.RadnikID IN(SELECT PRA.RadnikID FROM PlaceRadArh PRA WHERE PRA.Godina = 2016 AND PRA.Mjesec = 12) 
		OR Rad.NeRadi = 0) 		
	ORDER BY Rad.RadnikID */
-- ZAŠTIÈENI RAÈUNI --
/*SELECT Rad.RadnikID, Rad.PantheonID, (SELECT Banke.Naziv FROM Banke WHERE Banke.ID_BAN = (CASE WHEN Rad.ZasticeniRN = 1 THEN Rad.SifraBanke ELSE Rad.SifraBanke2 END)) AS Banka, 
	(CASE WHEN Rad.ZasticeniRN = 1 THEN Rad.BrTekRacuna ELSE Rad.BrTekRacuna2 END) AS TekuciRN, (CASE WHEN Rad.ZasticeniRN = 1 THEN 'Da' ELSE '-' END) AS JediniRacun 
	FROM Radnici Rad 
	WHERE (Rad.RadnikID IN(SELECT PRA.RadnikID FROM PlaceRadArh PRA WHERE PRA.Godina = 2016 AND PRA.Mjesec = 12) 
		OR Rad.NeRadi = 0) 		
		AND (Rad.ZasticeniRN = 1 OR Rad.BrTekRacuna2 <> '')
	ORDER BY Rad.RadnikID */