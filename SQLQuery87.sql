USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[Check_vrijeme]    Script Date: 14.2.2017. 11:59:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Check_vrijeme] 
	-- Add the parameters for the stored procedure here
	@id1 varchar,
	@datum1 as varchar,
	@datum2 as varchar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT x2.lastname,x2.fxid,x2.dosao,x2.otisao,DATEDIFF(minute,x2.dosao,x2.otisao) as minuta,x2.mt,x2.rv 
  from ( select max(x1.dt) otisao , min(x1.dt) dosao , x1.lastname , x1.extid1 FxId,x1.mt,x1.rv from (  
  select e.no RFID_Hex,m.id mt,e.no2,dt,e.[User],e.Device_ID,r.name,LastName,u.FirstName,u.ExtId extid1,b.extid extid2,e.No2 serial_number,ri.rv  
  from event e  
  left join badge b on e.No= b.BadgeNo  
  left join [dbo].[User] u on u.extid=b.extid 
  left join eventtype t on e.EventType=t.Code  
  left join reader r on e.device_id=r.id  
  left join radnici_ ri on ri.id=u.extid 
  left join mjestotroska m on ri.mt=m.id  
  WHERE E.[USER] IS NOT NULL  and (dt >= @datum1 AND dt<= @datum2 ) and (  EventType not in ('SP23','SP71') ) and u.ExtId= @id1 
  and r.door not in ( 7,8,9,10) ) x1 
  group by x1.lastname,x1.extid1,x1.mt,x1.rv ) x2


END
