USE [RFIND]
GO
/****** Object:  StoredProcedure [dbo].[sp_VrijemeUlazaIzlaza]    Script Date: 12.12.2016. 13:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_VrijemeUlazaIzlaza] 
	-- Add the parameters for the stored procedure here
	@Location  int,
	@DatumOd Datetime,
	@DatumDo Datetime,
	@Prezimee varchar
	
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  SELECT lastname,dan,fxid,dosao,otisao,DATEDIFF(minute,dosao,otisao) as minuta
	   from (
  select max(x1.dt) otisao,min(x1.dt) dosao,convert(varchar,datepart(day,x1.dt))+'.'+convert(varchar,datepart(month,x1.dt) ) +'.'+convert(varchar,datepart(year,x1.dt) )dan ,x1.lastname,x1.extid1 FxId
  from (
  select e.no RFID_Hex,e.no2,dt,e.[User],e.Device_ID,r.name,e.EventType,LastName,u.FirstName,t.CodeName,u.ExtId extid1,b.extid extid2,e.No2 serial_number
  from event e
  left join badge b on e.No= b.BadgeNo
  left join [dbo].[User] u on u.extid=b.extid
  left join eventtype t on e.EventType=t.Code
  left join reader r on e.device_id=r.id
  WHERE E.[USER] IS NOT NULL
  and u.LastName like '%'+@Prezimee+'%'
  and cast(dt as datetime) >=cast(@DatumOd as datetime) and cast( dt as datetime)<=cast(@datumDo as datetime)
  AND EventType!='SP23'
    
 ) x1
 group by convert(varchar,datepart(day,x1.dt))+'.'+convert(varchar,datepart(month,x1.dt) ) +'.'+convert(varchar,datepart(year,x1.dt) ) ,x1.lastname,x1.extid1
 ) x2
 end
