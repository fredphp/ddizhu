USE [QPAgencyDB]
GO
/****** Object:  Table [dbo].[UserPlayTime]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPlayTime](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[DateID] [int] NOT NULL,
	[AgencyID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[PlayTimeCount] [int] NOT NULL,
 CONSTRAINT [PK_UserPlayTime] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlayTime', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlayTime', @level2type=N'COLUMN',@level2name=N'AgencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlayTime', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlayTime', @level2type=N'COLUMN',@level2name=N'PlayTimeCount'
GO
/****** Object:  Table [dbo].[UserPlay]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPlay](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[DateID] [int] NOT NULL,
	[AgencyID] [int] NOT NULL,
	[RegisterCounts] [int] NOT NULL,
	[CanUserCounts] [int] NOT NULL,
	[IsEnd] [int] NOT NULL,
	[UserPayCounts] [int] NOT NULL,
 CONSTRAINT [PK_UserPlay] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlay', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlay', @level2type=N'COLUMN',@level2name=N'AgencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册用户数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlay', @level2type=N'COLUMN',@level2name=N'RegisterCounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效用户数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlay', @level2type=N'COLUMN',@level2name=N'CanUserCounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否结算0 未结算  1 已结算' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlay', @level2type=N'COLUMN',@level2name=N'IsEnd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理充值人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPlay', @level2type=N'COLUMN',@level2name=N'UserPayCounts'
GO
/****** Object:  Table [dbo].[RecordRoyalty]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordRoyalty](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[AgencyID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[UserWin] [decimal](18, 2) NOT NULL,
	[RoyaltyTotal] [decimal](18, 2) NOT NULL,
	[RoyaltyRatio] [int] NOT NULL,
	[RoyaltyTime] [datetime] NOT NULL,
	[RoyaltyGold] [decimal](18, 2) NOT NULL,
	[Remark] [varchar](127) NOT NULL,
	[RoyaltyType] [int] NULL,
 CONSTRAINT [PK_RecordRoyalty] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'AgencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产生本次抽水的游戏玩家' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家输赢' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'UserWin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'抽水总额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'RoyaltyTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'本次抽水比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'RoyaltyRatio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'抽水时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'RoyaltyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'本次抽水金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'RoyaltyGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型  0 游戏抽水 1 充值分成' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRoyalty', @level2type=N'COLUMN',@level2name=N'RoyaltyType'
GO
/****** Object:  Table [dbo].[RecordDraw]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordDraw](
	[DrawID] [int] IDENTITY(1,1) NOT NULL,
	[AgencyID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[CurGold] [decimal](18, 2) NOT NULL,
	[DrawGold] [decimal](18, 2) NOT NULL,
	[EndGold] [decimal](18, 2) NOT NULL,
	[DrewTime] [datetime] NOT NULL,
	[RevenueGold] [decimal](18, 2) NOT NULL,
	[Result] [int] NOT NULL,
	[Remark] [varchar](500) NOT NULL,
 CONSTRAINT [PK_RecordDraw] PRIMARY KEY CLUSTERED 
(
	[DrawID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款记录编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'DrawID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'AgencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到账玩家' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款前金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'CurGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'DrawGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款后金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'EndGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'DrewTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手续费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'RevenueGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请结果0申请中  1同意  2到账' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'Result'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'理由' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDraw', @level2type=N'COLUMN',@level2name=N'Remark'
GO
/****** Object:  Table [dbo].[RecordBringGold]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordBringGold](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[AgencyID] [int] NOT NULL,
	[BankName] [varchar](50) NOT NULL,
	[BankAgencyName] [varchar](20) NOT NULL,
	[BankNum] [varchar](50) NOT NULL,
	[BankAddr] [varchar](50) NOT NULL,
	[CurGold] [decimal](18, 2) NOT NULL,
	[DrawGold] [decimal](18, 2) NOT NULL,
	[RevenueGold] [decimal](18, 2) NOT NULL,
	[Result] [int] NOT NULL,
	[Remark] [varchar](500) NOT NULL,
	[ApplyTime] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordBringGold] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'AgencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开户行名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'BankName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开户姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'BankAgencyName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行卡号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'BankNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开户行地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'BankAddr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请提款时金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'CurGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'DrawGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手续费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'RevenueGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提款状态0 申请中  1已同意  2未同意' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'Result'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBringGold', @level2type=N'COLUMN',@level2name=N'ApplyTime'
GO
/****** Object:  Table [dbo].[News]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[NewsName] [varchar](127) NOT NULL,
	[NewsTime] [datetime] NOT NULL,
	[NewsCont] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公告编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'NewsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公告标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'NewsName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公共插入时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'NewsTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公告内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'NewsCont'
GO
/****** Object:  Table [dbo].[DateRecord]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateRecord](
	[DateID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgencyInfo]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AgencyInfo](
	[AgencyID] [int] IDENTITY(10000,1) NOT NULL,
	[AgencyName] [varchar](20) NOT NULL,
	[LoginName] [varchar](50) NOT NULL,
	[LoginPwd] [varchar](50) NOT NULL,
	[SafePwdFirst] [varchar](50) NOT NULL,
	[SafePwdSecond] [varchar](50) NOT NULL,
	[AgencyEmail] [varchar](100) NOT NULL,
	[AgencyPhone] [varchar](20) NOT NULL,
	[AgencyQQ] [varchar](15) NOT NULL,
	[AgencyGold] [decimal](18, 2) NOT NULL,
	[AgencyRoyalty] [int] NOT NULL,
	[AgencyParentID] [int] NOT NULL,
	[AgencyFlag] [int] NOT NULL,
	[AgencyLink] [varchar](200) NOT NULL,
	[UserPrice] [decimal](18, 0) NOT NULL,
	[UserPlayTime] [int] NOT NULL,
	[BankName] [varchar](127) NOT NULL,
	[BankNum] [varchar](127) NOT NULL,
	[BankAddr] [varchar](127) NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
	[CanUse] [int] NOT NULL,
	[PayRevenue] [int] NOT NULL,
 CONSTRAINT [PK_AgencyInfo] PRIMARY KEY CLUSTERED 
(
	[AgencyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录名(用户名)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'LoginName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'LoginPwd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'一级安全密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'SafePwdFirst'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'二级安全密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'SafePwdSecond'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理QQ号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyQQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理的金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理的抽水比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyRoyalty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上级代理编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyParentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理是否被冻结(1被冻结、0未冻结)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理推广链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'AgencyLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效玩家单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'UserPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效会员时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'UserPlayTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开户行名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'BankName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行卡号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'BankNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行卡办理地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'BankAddr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否可以新增下级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'CanUse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家充值分成比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyInfo', @level2type=N'COLUMN',@level2name=N'PayRevenue'
GO
/****** Object:  Table [dbo].[AgencyConfig]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AgencyConfig](
	[AgencyConfigName] [varchar](20) NOT NULL,
	[UserPlayTime] [int] NOT NULL,
	[UserPrice] [decimal](18, 2) NOT NULL,
	[OverdueDay] [int] NOT NULL,
	[RegisterCount] [int] NOT NULL,
	[UserCount] [int] NOT NULL,
	[Revenue] [int] NOT NULL,
	[DrawMoney] [int] NOT NULL,
	[SelectDay] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[PayRevenue] [decimal](18, 2) NULL,
 CONSTRAINT [PK_AgencyConfig] PRIMARY KEY CLUSTERED 
(
	[AgencyConfigName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏多长时间为有效会员 单位：秒' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'UserPlayTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效会员单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'UserPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'多少天注册(有效会员少于多少个)冻结' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'OverdueDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少注册个数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'RegisterCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最少有效会员个数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'UserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结算手续费比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每次最少结算金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'DrawMoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理可以查看多少天的记录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'SelectDay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理新增下级代理状态 0 开启 1 关闭' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家充值取出多少分给代理' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgencyConfig', @level2type=N'COLUMN',@level2name=N'PayRevenue'
GO
/****** Object:  Table [dbo].[Agency_User]    Script Date: 04/05/2016 15:45:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agency_User](
	[AgencyID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Agency_User] PRIMARY KEY CLUSTERED 
(
	[AgencyID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_AgencyConfig_AgencyConfigName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_AgencyConfigName]  DEFAULT ('AgencyConfig') FOR [AgencyConfigName]
GO
/****** Object:  Default [DF_AgencyConfig_UserPlayTime]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_UserPlayTime]  DEFAULT ((0)) FOR [UserPlayTime]
GO
/****** Object:  Default [DF_AgencyConfig_UserPrice]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_UserPrice]  DEFAULT ((0)) FOR [UserPrice]
GO
/****** Object:  Default [DF_AgencyConfig_RegisterCount]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_RegisterCount]  DEFAULT ((0)) FOR [RegisterCount]
GO
/****** Object:  Default [DF_AgencyConfig_UserCount]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_UserCount]  DEFAULT ((0)) FOR [UserCount]
GO
/****** Object:  Default [DF_AgencyConfig_Revenue]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_Revenue]  DEFAULT ((5)) FOR [Revenue]
GO
/****** Object:  Default [DF_AgencyConfig_DrawMoney]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_DrawMoney]  DEFAULT ((0)) FOR [DrawMoney]
GO
/****** Object:  Default [DF_AgencyConfig_SelectDay]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_SelectDay]  DEFAULT ((0)) FOR [SelectDay]
GO
/****** Object:  Default [DF_AgencyConfig_Status]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_Status]  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF_AgencyConfig_PayRevenue]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyConfig] ADD  CONSTRAINT [DF_AgencyConfig_PayRevenue]  DEFAULT ((0)) FOR [PayRevenue]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyName]  DEFAULT (N'') FOR [AgencyName]
GO
/****** Object:  Default [DF_AgencyInfo_LoginName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_LoginName]  DEFAULT (N'') FOR [LoginName]
GO
/****** Object:  Default [DF_AgencyInfo_LoginPwd]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_LoginPwd]  DEFAULT (N'') FOR [LoginPwd]
GO
/****** Object:  Default [DF_AgencyInfo_SafePwdFirst]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_SafePwdFirst]  DEFAULT (N'') FOR [SafePwdFirst]
GO
/****** Object:  Default [DF_AgencyInfo_SafePwdSecond]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_SafePwdSecond]  DEFAULT (N'') FOR [SafePwdSecond]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyEmail]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyEmail]  DEFAULT (N'') FOR [AgencyEmail]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyPhone]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyPhone]  DEFAULT (N'') FOR [AgencyPhone]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyQQ]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyQQ]  DEFAULT (N'') FOR [AgencyQQ]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyGold]  DEFAULT ((0)) FOR [AgencyGold]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyRoyalty]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyRoyalty]  DEFAULT ((10)) FOR [AgencyRoyalty]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyParentID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyParentID]  DEFAULT ((0)) FOR [AgencyParentID]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyFlag]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyFlag]  DEFAULT ((0)) FOR [AgencyFlag]
GO
/****** Object:  Default [DF_AgencyInfo_AgencyLink]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_AgencyLink]  DEFAULT (N'') FOR [AgencyLink]
GO
/****** Object:  Default [DF_AgencyInfo_UserPrice]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_UserPrice]  DEFAULT ((0)) FOR [UserPrice]
GO
/****** Object:  Default [DF_AgencyInfo_UserPlayTime]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_UserPlayTime]  DEFAULT ((0)) FOR [UserPlayTime]
GO
/****** Object:  Default [DF_AgencyInfo_BankName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_BankName]  DEFAULT (N'') FOR [BankName]
GO
/****** Object:  Default [DF_AgencyInfo_BankNum]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_BankNum]  DEFAULT (N'') FOR [BankNum]
GO
/****** Object:  Default [DF_AgencyInfo_BankAddr]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_BankAddr]  DEFAULT (N'') FOR [BankAddr]
GO
/****** Object:  Default [DF_AgencyInfo_Register]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_Register]  DEFAULT (getdate()) FOR [RegisterDate]
GO
/****** Object:  Default [DF_AgencyInfo_CanUse]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_CanUse]  DEFAULT ((0)) FOR [CanUse]
GO
/****** Object:  Default [DF_AgencyInfo_PayRevenue]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[AgencyInfo] ADD  CONSTRAINT [DF_AgencyInfo_PayRevenue]  DEFAULT ((10)) FOR [PayRevenue]
GO
/****** Object:  Default [DF_DateRecord_DateID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[DateRecord] ADD  CONSTRAINT [DF_DateRecord_DateID]  DEFAULT (CONVERT([int],CONVERT([float],getdate(),(0)),(0))) FOR [DateID]
GO
/****** Object:  Default [DF_News_NewsName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[News] ADD  CONSTRAINT [DF_News_NewsName]  DEFAULT (N'') FOR [NewsName]
GO
/****** Object:  Default [DF_News_NewsTime]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[News] ADD  CONSTRAINT [DF_News_NewsTime]  DEFAULT (getdate()) FOR [NewsTime]
GO
/****** Object:  Default [DF_News_NewsCont]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[News] ADD  CONSTRAINT [DF_News_NewsCont]  DEFAULT (N'') FOR [NewsCont]
GO
/****** Object:  Default [DF_RecordBringGold_AgencyID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_AgencyID]  DEFAULT ((0)) FOR [AgencyID]
GO
/****** Object:  Default [DF_RecordBringGold_BankName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_BankName]  DEFAULT (N'') FOR [BankName]
GO
/****** Object:  Default [DF_RecordBringGold_BankAgencyName]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_BankAgencyName]  DEFAULT ('') FOR [BankAgencyName]
GO
/****** Object:  Default [DF_RecordBringGold_BankNum]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_BankNum]  DEFAULT (N'') FOR [BankNum]
GO
/****** Object:  Default [DF_RecordBringGold_BankAddr]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_BankAddr]  DEFAULT (N'') FOR [BankAddr]
GO
/****** Object:  Default [DF_RecordBringGold_CurGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_CurGold]  DEFAULT ((0)) FOR [CurGold]
GO
/****** Object:  Default [DF_RecordBringGold_DrawGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_DrawGold]  DEFAULT ((0)) FOR [DrawGold]
GO
/****** Object:  Default [DF_RecordBringGold_RevenueGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_RevenueGold]  DEFAULT ((0)) FOR [RevenueGold]
GO
/****** Object:  Default [DF_RecordBringGold_Result]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_Result]  DEFAULT ((0)) FOR [Result]
GO
/****** Object:  Default [DF_RecordBringGold_Remark]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_Remark]  DEFAULT ('处理中') FOR [Remark]
GO
/****** Object:  Default [DF_RecordBringGold_ApplyTime]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordBringGold] ADD  CONSTRAINT [DF_RecordBringGold_ApplyTime]  DEFAULT (getdate()) FOR [ApplyTime]
GO
/****** Object:  Default [DF_RecordDraw_AgencyID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_AgencyID]  DEFAULT ((0)) FOR [AgencyID]
GO
/****** Object:  Default [DF_RecordDraw_UserID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_UserID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_RecordDraw_CurGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_CurGold]  DEFAULT ((0)) FOR [CurGold]
GO
/****** Object:  Default [DF_RecordDraw_DrawGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_DrawGold]  DEFAULT ((0)) FOR [DrawGold]
GO
/****** Object:  Default [DF_RecordDraw_EndGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_EndGold]  DEFAULT ((0)) FOR [EndGold]
GO
/****** Object:  Default [DF_RecordDraw_DrewTime]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_DrewTime]  DEFAULT (getdate()) FOR [DrewTime]
GO
/****** Object:  Default [DF_RecordDraw_RevenueGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_RevenueGold]  DEFAULT ((0)) FOR [RevenueGold]
GO
/****** Object:  Default [DF_RecordDraw_Result]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_Result]  DEFAULT ((0)) FOR [Result]
GO
/****** Object:  Default [DF_RecordDraw_Remark]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordDraw] ADD  CONSTRAINT [DF_RecordDraw_Remark]  DEFAULT ('处理中') FOR [Remark]
GO
/****** Object:  Default [DF_RecordRoyalty_AgencyID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_AgencyID]  DEFAULT ((0)) FOR [AgencyID]
GO
/****** Object:  Default [DF_Table_1_SubID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_Table_1_SubID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_RecordRoyalty_UserWin]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_UserWin]  DEFAULT ((0)) FOR [UserWin]
GO
/****** Object:  Default [DF_RecordRoyalty_RoyaltyTotal]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_RoyaltyTotal]  DEFAULT ((0)) FOR [RoyaltyTotal]
GO
/****** Object:  Default [DF_RecordRoyalty_RoyaltyRatio]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_RoyaltyRatio]  DEFAULT ((0)) FOR [RoyaltyRatio]
GO
/****** Object:  Default [DF_RecordRoyalty_RoyaltyTime]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_RoyaltyTime]  DEFAULT (getdate()) FOR [RoyaltyTime]
GO
/****** Object:  Default [DF_RecordRoyalty_RoyaltyGold]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_RoyaltyGold]  DEFAULT ((0)) FOR [RoyaltyGold]
GO
/****** Object:  Default [DF_RecordRoyalty_Remark]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_Remark]  DEFAULT (N'') FOR [Remark]
GO
/****** Object:  Default [DF_RecordRoyalty_RoyaltyType]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[RecordRoyalty] ADD  CONSTRAINT [DF_RecordRoyalty_RoyaltyType]  DEFAULT ((0)) FOR [RoyaltyType]
GO
/****** Object:  Default [DF_UserPlay_DateID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlay] ADD  CONSTRAINT [DF_UserPlay_DateID]  DEFAULT (CONVERT([int],CONVERT([float],getdate(),(0)),(0))) FOR [DateID]
GO
/****** Object:  Default [DF_UserPlay_AgencyID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlay] ADD  CONSTRAINT [DF_UserPlay_AgencyID]  DEFAULT ((0)) FOR [AgencyID]
GO
/****** Object:  Default [DF_UserPlay_RegisterCounts]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlay] ADD  CONSTRAINT [DF_UserPlay_RegisterCounts]  DEFAULT ((0)) FOR [RegisterCounts]
GO
/****** Object:  Default [DF_UserPlay_CanUserCounts]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlay] ADD  CONSTRAINT [DF_UserPlay_CanUserCounts]  DEFAULT ((0)) FOR [CanUserCounts]
GO
/****** Object:  Default [DF_UserPlay_IsEnd]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlay] ADD  CONSTRAINT [DF_UserPlay_IsEnd]  DEFAULT ((0)) FOR [IsEnd]
GO
/****** Object:  Default [DF_UserPlay_UserPayCounts]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlay] ADD  CONSTRAINT [DF_UserPlay_UserPayCounts]  DEFAULT ((0)) FOR [UserPayCounts]
GO
/****** Object:  Default [DF_UserPlayTime_DateID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlayTime] ADD  CONSTRAINT [DF_UserPlayTime_DateID]  DEFAULT (CONVERT([int],CONVERT([float],getdate(),(0)),(0))) FOR [DateID]
GO
/****** Object:  Default [DF_UserPlayTime_AgencyID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlayTime] ADD  CONSTRAINT [DF_UserPlayTime_AgencyID]  DEFAULT ((0)) FOR [AgencyID]
GO
/****** Object:  Default [DF_UserPlayTime_UserID]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlayTime] ADD  CONSTRAINT [DF_UserPlayTime_UserID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_UserPlayTime_PlayTimeCount]    Script Date: 04/05/2016 15:45:51 ******/
ALTER TABLE [dbo].[UserPlayTime] ADD  CONSTRAINT [DF_UserPlayTime_PlayTimeCount]  DEFAULT ((0)) FOR [PlayTimeCount]
GO
