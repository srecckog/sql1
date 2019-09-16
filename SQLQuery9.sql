USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[ERN_zbroji]    Script Date: 13.1.2017. 11:19:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gašpariæ Sreæko
-- Create date: 13.1.2017
-- Description:	Update radnog vremena u radnici_
-- =============================================
CREATE PROCEDURE [dbo].[FX_UpdateRVForOneRadnik] 
	-- Add the parameters for the stored procedure here
	@FXID  int,
	@TIP_RV int
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update radnici_2 set rv =@TIP_RV  where id=@FXID



END
