USE FeroApp

SELECT AsnSta.* FROM AsnSta WHERE AsnSta.ID_AsnZ IN(SELECT AsnZag.ID_AsnZ FROM AsnZag WHERE AsnZag.DatumASN = '2016-11-04')