USE [RFIND]
GO

/****** Object:  Table [dbo].[PlanDjelatnika11]    Script Date: 27.2.2017. 10:17:24 ******/
DROP TABLE [dbo].[PlanDjelatnika11]
GO

/****** Object:  Table [dbo].[PlanDjelatnika11]    Script Date: 27.2.2017. 10:17:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PlanDjelatnika31](
	[rbroj] [int] IDENTITY(1,1) NOT NULL,
	[hala] [nchar](10) NULL,
	[radnapozicija] [varchar](50) NULL,
	[smjena1] [varchar](50) NULL,
	[smjena2] [varchar](50) NULL,
	[smjena3] [varchar](50) NULL,
	[bolovanje] [nvarchar](50) NULL,
	[godišnji] [nvarchar](50) NULL,
	[Grupa] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


