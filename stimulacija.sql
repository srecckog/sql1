/****** Script for SelectTopNRows command from SSMS  ******/
use feroapp
SELECT id_radnika,radnik,radnik2,brojrn,ObradaA,obradab,obradac,ObradaD,obradae,vrijemeod,vrijemedo,norma,KolicinaOK,OtpadObrada,OtpadMat,vrijemeod2,vrijemedo2
FROM EvidencijaNormiSta ES
where ES.datumunosa='2017-02-27'
order by radnik
  