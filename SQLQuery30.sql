USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Update_oznaku]    Script Date: 9.3.2017. 12:46:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

ALTER PROCEDURE [dbo].[Update_oznaku] 
	-- Add the parameters for the stored procedure here
	@id1 int,
	@datum1 date,
	@oznaka1 varchar(3)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	


	update pregledd set oznaka=@oznaka1 where idradnika = @id1 and datum=@datum1

	--select x1.*,@oznaka1 as 'Oznaka' into pregledd
	--from( 
	--select idradnika, r.prezime + ' ' + r.ime as ime, datum, smjena, hala, pv.radnomjesto, dosao, otisao, napomena, ukupno_minuta, (480 - ukupno_minuta) razlika 
	--from pregledvremena pv 
	--left join radnici_ r on r.id = pv.IDRadnika 
	--where datum = @datum1  and pv.IDRadnika=@id1
	--) x1 

	--order by x1.ime, datum

END
