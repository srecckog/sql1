select x1.* 
from( 
select distinct k.id, k.prezimeime, k.funkcija, k.projekt, k.hala, k.linija, k.mjesto_troska,mt.grupa1 gmt,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 61) BDF_AR_IR,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 62) CementacijaDebrecen,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 63) CementacijaUsluga,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 64) KaljenjeUsluga,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 65) Sona,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 66) NSK,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 67) PakiranjeBDF,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 68) Voza�Vili�ara,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 69) DnevniPlanKaljenja,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 70) DnevniPlanPakiranja,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 71) PlanSlaganja,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 72) Slaganje�ar�e,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 73) Predpranje,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 74) Plan�ar�eProces,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 75) DaljnjaObrada,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 76) Raskapanje�ar�e,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 77) ProgListproizvKalj,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 78) ProgListProizvPaki,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 79) UmjeravanjeTvrdomjera,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 80) MjerTvrdo�eRockwell,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 81) ProgTvrdo�e,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 82) Kvalit�ar�MaterOkret,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 83) RadNaUre�ajuPakiranje,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 84) OcjenaKvaliteteKaljMikros,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 85) KontrolaParametaraPe�i,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 86) PriprUzorzaMetalogr,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 87) �kolovNovogDjelat,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 88) Ru�noVo�enjeProcesaUklanjanjeZastoja,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 89) SamostalnoVo�enjeSmjeneBezTestovaINovihPproizvoda,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 90) SamostalnoRije�avanjeZastojaIManjihKvarova,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 91) SamostalanUProvo�enjuPlanaKaljenja,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 92) SamostalanUDokazivanjuKvaliteteTO,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 93) SamostalanUNadzoruIIzmjenamaParametara,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 94) SamostalanDimenzionalnaKontrolaSetUPMjernogStola,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 95) RasporedLjudstva,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 96) IzradaPlanova�ar�iranjaIReceptura,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 97) Mehani�kaPo�telavanja,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 98) Rije�avanjeGre�akaNaUre�aju,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 99) PlaniranjeProizvodnjePremaPlanuKupca,
(select isnull(vrijednost,0) from radnicivjestine v where v.idradnika = k.id and idvjestine = 100) IzradadokumentacijeERSTEMUSTERA,
k.DatumZaposlenja,
k.istek_ugovora,
k.napomena 
from kompetencije k left join radnici_ r on r.id=k.id left join mjestotroska mt on mt.id= r.mt where r.neradi=0) x1 
 where x1.hala in (1,3) and x1.gmt='5' 
 order by prezimeime


 select isnull(vrijednost,0)
 from radnicivjestine2