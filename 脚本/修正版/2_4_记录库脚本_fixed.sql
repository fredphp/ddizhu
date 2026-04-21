USE [QPRecordDB]
GO
/****** Object:  Table [dbo].[web_GoldStatIstical]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[web_GoldStatIstical](
	[Tm] [datetime] NULL,
	[Score] [bigint] NULL,
	[InsureScore] [bigint] NULL,
	[ScoreSum] [bigint] NULL,
	[dianka] [bigint] NULL,
	[wangyin] [bigint] NULL,
	[yikatong] [bigint] NULL,
	[zaixian] [bigint] NULL,
	[qiandao] [bigint] NULL,
	[zhuanpan] [bigint] NULL,
	[jinduan] [bigint] NULL,
	[tuiguang] [bigint] NULL,
	[jifentojinbi] [bigint] NULL,
	[bisai] [bigint] NULL,
	[zhuce] [bigint] NULL,
	[zengsong] [bigint] NULL,
	[xinshoulingqu] [bigint] NULL,
	[shoujilingqu] [bigint] NULL,
	[ziliaolingqu] [bigint] NULL,
	[chongzhilingqu] [bigint] NULL,
	[renwulingqu] [bigint] NULL,
	[jinbitojifen] [bigint] NULL,
	[zhuanzhangshuishou] [bigint] NULL,
	[shuishou] [bigint] NULL,
	[xitong] [bigint] NULL,
	[daoju] [bigint] NULL,
	[lipin] [bigint] NULL,
	[shangcheng] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordTask]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordTask](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[TaskID] [int] NOT NULL,
	[AwardGold] [int] NOT NULL,
	[AwardMedal] [int] NOT NULL,
	[InputDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordTask] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordTask', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordTask', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordTask', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordTask', @level2type=N'COLUMN',@level2name=N'TaskID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordTask', @level2type=N'COLUMN',@level2name=N'AwardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordTask', @level2type=N'COLUMN',@level2name=N'AwardMedal'
GO
/****** Object:  Table [dbo].[RecordSigninRewardCount]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordSigninRewardCount](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RewardGold] [int] NOT NULL,
	[CountDate] [int] NOT NULL,
	[ClientID] [nvarchar](15) NOT NULL,
	[InputDate] [datetime] NOT NULL,
	[OldGold] [bigint] NOT NULL,
	[NewGold] [bigint] NOT NULL,
 CONSTRAINT [PK_RecordSigninRewardCount] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninRewardCount', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninRewardCount', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninRewardCount', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连续天数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninRewardCount', @level2type=N'COLUMN',@level2name=N'CountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签到时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninRewardCount', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
/****** Object:  Table [dbo].[RecordSigninMB]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordSigninMB](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RewardGold] [int] NOT NULL,
	[ClientID] [nvarchar](15) NOT NULL,
	[InputDate] [datetime] NOT NULL,
	[OldGold] [bigint] NOT NULL,
	[NewGold] [bigint] NOT NULL,
 CONSTRAINT [PK_RecordSigninMB] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninMB', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninMB', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninMB', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签到时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSigninMB', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
/****** Object:  Table [dbo].[RecordSignin]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordSignin](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RewardGold] [int] NOT NULL,
	[ClientID] [nvarchar](15) NOT NULL,
	[InputDate] [datetime] NOT NULL,
	[OldGold] [bigint] NOT NULL,
	[NewGold] [bigint] NOT NULL,
 CONSTRAINT [PK_RecordSingin] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSignin', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSignin', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSignin', @level2type=N'COLUMN',@level2name=N'RewardGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签到时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSignin', @level2type=N'COLUMN',@level2name=N'InputDate'
GO
/****** Object:  Table [dbo].[RecordSendProperty]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordSendProperty](
	[PropID] [tinyint] NOT NULL,
	[SourceUserID] [int] NOT NULL,
	[TargetUserID] [int] NOT NULL,
	[PropPrice] [int] NOT NULL,
	[PropCount] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[SendTime] [datetime] NOT NULL,
	[ClientIP] [nvarchar](15) NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'PropID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'SourceUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'TargetUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'PropPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'道具数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'PropCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'SendTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendProperty', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
/****** Object:  Table [dbo].[RecordSendPresent]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordSendPresent](
	[PresentID] [tinyint] NOT NULL,
	[RcvUserID] [int] NOT NULL,
	[SendUserID] [int] NOT NULL,
	[LovelinessRcv] [int] NOT NULL,
	[LovelinessSend] [int] NOT NULL,
	[PresentPrice] [int] NOT NULL,
	[PresentCount] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[SendTime] [datetime] NOT NULL,
	[ClientIP] [nvarchar](15) NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'礼物标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'PresentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'RcvUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'SendUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'魅力数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'LovelinessRcv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'魅力数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'LovelinessSend'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'礼物价钱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'PresentPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'礼物数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'PresentCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'SendTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSendPresent', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
/****** Object:  Table [dbo].[RecordPasswdExpend]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordPasswdExpend](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[OperMasterID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ReLogonPasswd] [nvarchar](32) NOT NULL,
	[ReInsurePasswd] [nvarchar](32) NOT NULL,
	[ClientIP] [nvarchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordPasswdExpend] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作网管' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'OperMasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'ReLogonPasswd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'ReInsurePasswd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordPasswdExpend', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Table [dbo].[RecordLevelPresent]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordLevelPresent](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[LevelGold] [decimal](18, 2) NOT NULL,
	[GetTime] [datetime] NOT NULL,
	[CurGold] [decimal](18, 2) NOT NULL,
	[CurMedal] [int] NOT NULL,
	[Medal] [int] NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'等级奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordLevelPresent', @level2type=N'COLUMN',@level2name=N'LevelGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordLevelPresent', @level2type=N'COLUMN',@level2name=N'GetTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取前金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordLevelPresent', @level2type=N'COLUMN',@level2name=N'CurGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取前元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordLevelPresent', @level2type=N'COLUMN',@level2name=N'CurMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordLevelPresent', @level2type=N'COLUMN',@level2name=N'Medal'
GO
/****** Object:  Table [dbo].[RecordGrantWith]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantWith](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[withFront] [bigint] NOT NULL,
	[withMoney] [bigint] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[UserID] [int] NOT NULL,
	[CollectDate] [datetime] NULL,
	[insurescore] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转账后的银行金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantWith', @level2type=N'COLUMN',@level2name=N'insurescore'
GO
/****** Object:  Table [dbo].[RecordGrantTreasure]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantTreasure](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[CurGold] [bigint] NOT NULL,
	[AddGold] [bigint] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_RecordGrantScore] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来访地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'CurGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增加金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'AddGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作理由' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantTreasure', @level2type=N'COLUMN',@level2name=N'Reason'
GO
/****** Object:  Table [dbo].[RecordGrantTransfer]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantTransfer](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[TransferFront] [bigint] NOT NULL,
	[TransferMoney] [bigint] NOT NULL,
	[addUserID] [int] NOT NULL,
	[delUserID] [int] NOT NULL,
	[CollectDate] [datetime] NULL,
	[ClientIP] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RecordGrantMember]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantMember](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[GrantCardType] [int] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
	[MemberDays] [int] NOT NULL,
 CONSTRAINT [PK_RecordGrantMenber] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户端IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送的会员卡类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'GrantCardType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠送会员卡原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantMember', @level2type=N'COLUMN',@level2name=N'Reason'
GO
/****** Object:  Table [dbo].[RecordGrantGameScore]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantGameScore](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[CurScore] [bigint] NOT NULL,
	[AddScore] [int] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_RecordGrantGameScore] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来访地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'CurScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增加积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'AddScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作理由' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameScore', @level2type=N'COLUMN',@level2name=N'Reason'
GO
/****** Object:  Table [dbo].[RecordGrantGameID]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantGameID](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[CurGameID] [int] NOT NULL,
	[ReGameID] [int] NOT NULL,
	[IDLevel] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_RecordGrantGameID] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'CurGameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠予标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'ReGameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID级别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'IDLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠予地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠予时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantGameID', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Table [dbo].[RecordGrantExperience]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantExperience](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[CurExperience] [int] NOT NULL,
	[AddExperience] [int] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_RecordGrantExperience] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠予地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠予时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前经验' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'CurExperience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'补加经验' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'AddExperience'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'赠予原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantExperience', @level2type=N'COLUMN',@level2name=N'Reason'
GO
/****** Object:  Table [dbo].[RecordGrantClearScore]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantClearScore](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[CurScore] [bigint] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_RecordGrantClearScore] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户端IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收集日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'CurScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'清零负分原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearScore', @level2type=N'COLUMN',@level2name=N'Reason'
GO
/****** Object:  Table [dbo].[RecordGrantClearFlee]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordGrantClearFlee](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[CurFlee] [int] NOT NULL,
	[Reason] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_RecordGrantFlee] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'MasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'服务地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前逃跑次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'CurFlee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'理由' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordGrantClearFlee', @level2type=N'COLUMN',@level2name=N'Reason'
GO
/****** Object:  Table [dbo].[RecordEveryDayRoomData]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordEveryDayRoomData](
	[DateID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Waste] [bigint] NOT NULL,
	[Revenue] [bigint] NOT NULL,
	[Medal] [int] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordEveryDayRoomData] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[KindID] ASC,
	[ServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'损耗' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'Waste'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'Revenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'Medal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录入日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayRoomData', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Table [dbo].[RecordEveryDayData]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordEveryDayData](
	[DateID] [int] NOT NULL,
	[UserTotal] [int] NOT NULL,
	[PayUserTotal] [int] NOT NULL,
	[ActiveUserTotal] [int] NOT NULL,
	[LossUser] [int] NOT NULL,
	[LossUserTotal] [int] NOT NULL,
	[LossPayUser] [int] NOT NULL,
	[LossPayUserTotal] [int] NOT NULL,
	[PayTotalAmount] [int] NOT NULL,
	[PayAmountForCurrency] [int] NOT NULL,
	[GoldTotal] [bigint] NOT NULL,
	[CurrencyTotal] [bigint] NOT NULL,
	[GameTax] [bigint] NOT NULL,
	[GameTaxTotal] [bigint] NOT NULL,
	[BankTax] [bigint] NOT NULL,
	[Waste] [bigint] NOT NULL,
	[UserAVGOnlineTime] [int] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordEveryDayData_1] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'DateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'UserTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值玩家' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'PayUserTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活跃用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'ActiveUserTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日流失玩家数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'LossUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户流失总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'LossUserTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日流失充值玩家数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'LossPayUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值用户流失总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'LossPayUserTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'PayTotalAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值货币金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'PayAmountForCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'金币总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'GoldTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平台币总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'CurrencyTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日游戏税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'GameTax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税收总额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'GameTaxTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日银行税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'BankTax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当日损耗' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'Waste'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'平均在线时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'UserAVGOnlineTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEveryDayData', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Table [dbo].[RecordEncashPresent]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordEncashPresent](
	[UserID] [int] NOT NULL,
	[CurGold] [bigint] NOT NULL,
	[CurPresent] [int] NOT NULL,
	[EncashGold] [int] NOT NULL,
	[EncashPresent] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[ClientIP] [nvarchar](15) NOT NULL,
	[EncashTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'CurGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前礼物数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'CurPresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换金币数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'EncashGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换礼物数目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'EncashPresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordEncashPresent', @level2type=N'COLUMN',@level2name=N'EncashTime'
GO
/****** Object:  Table [dbo].[RecordDayData]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDayData](
	[DateID] [int] NOT NULL,
	[PayBankGold] [decimal](18, 2) NOT NULL,
	[PayCardGold] [decimal](18, 2) NOT NULL,
	[PayTureGold] [decimal](18, 2) NOT NULL,
	[PayNewUserGold] [decimal](18, 2) NOT NULL,
	[PayBankMedal] [int] NOT NULL,
	[PayCardMedal] [int] NOT NULL,
	[PayTureMedal] [int] NOT NULL,
	[PayNewUserMedal] [int] NOT NULL,
	[PreMatchGold] [decimal](18, 2) NOT NULL,
	[PreMatchMedal] [int] NOT NULL,
	[PreLevelGold] [decimal](18, 2) NOT NULL,
	[PreLevelMedal] [int] NOT NULL,
	[PreFideGold] [decimal](18, 2) NOT NULL,
	[PreFideMedal] [int] NOT NULL,
	[PreTaskGold] [decimal](18, 2) NOT NULL,
	[PreTaskMedal] [int] NOT NULL,
	[PreReferGold] [decimal](18, 2) NOT NULL,
	[PreReferMedal] [int] NOT NULL,
	[PreMealGold] [decimal](18, 2) NOT NULL,
	[PreMealMedal] [int] NOT NULL,
	[PreRegstGold] [decimal](18, 2) NOT NULL,
	[PreRegstMedal] [int] NOT NULL,
	[PreTurnGold] [decimal](18, 2) NOT NULL,
	[PreTurnMedal] [int] NOT NULL,
	[PreSignGold] [decimal](18, 2) NOT NULL,
	[PreSignMedal] [int] NOT NULL,
	[TotalInsure] [decimal](18, 2) NOT NULL,
	[TotalScore] [decimal](18, 2) NOT NULL,
	[TotalMedal] [bigint] NOT NULL,
	[Time] [datetime] NOT NULL,
	[LostWin] [decimal](18, 0) NOT NULL,
	[BankRevenue] [decimal](18, 2) NOT NULL,
	[GameRevenue] [decimal](18, 2) NOT NULL,
	[BuyPro] [decimal](18, 2) NOT NULL,
	[MedalToScore] [decimal](18, 2) NOT NULL,
	[AdminGrant] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_RecordDayData] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'DateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网银充值金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayBankGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'亿卡充值金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayCardGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实卡充值金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayTureGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新手卡充值金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayNewUserGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网银充值元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayBankMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'亿卡充值元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayCardMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实卡充值元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayTureMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新手卡充值元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PayNewUserMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreMatchGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'比赛赠送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreMatchMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'等级奖励金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreLevelGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'等级奖励元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreLevelMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'低保赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreFideGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'低保赠送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreFideMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreTaskGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务赠送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreTaskMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐人赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreReferGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐人赠送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreReferMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'泡点赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreMealGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'泡点赠送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreMealMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreRegstGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册赠送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreRegstMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转盘摇奖金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreTurnGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转盘摇奖元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreTurnMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签到奖励' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreSignGold'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签到送元宝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'PreSignMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行金币合计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'TotalInsure'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'玩家携带金币合计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'TotalScore'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'元宝合计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'TotalMedal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'银行转账税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'BankRevenue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏税收' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'GameRevenue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买道具' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'BuyPro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'元宝兑换金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'MedalToScore'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'后台赠送金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordDayData', @level2type=N'COLUMN',@level2name=N'AdminGrant'
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_DateID]  DEFAULT ((0)) FOR [DateID]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayBankGold]  DEFAULT ((0)) FOR [PayBankGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayCardGold]  DEFAULT ((0)) FOR [PayCardGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayTureGold]  DEFAULT ((0)) FOR [PayTureGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayNewUserGold]  DEFAULT ((0)) FOR [PayNewUserGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayBankMedal]  DEFAULT ((0)) FOR [PayBankMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayCardMedal]  DEFAULT ((0)) FOR [PayCardMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayTureMedal]  DEFAULT ((0)) FOR [PayTureMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PayNewUserMedal]  DEFAULT ((0)) FOR [PayNewUserMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreMatchGold]  DEFAULT ((0)) FOR [PreMatchGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreMatchMedal]  DEFAULT ((0)) FOR [PreMatchMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreLevelGold]  DEFAULT ((0)) FOR [PreLevelGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreLevelMedal]  DEFAULT ((0)) FOR [PreLevelMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreFideGold]  DEFAULT ((0)) FOR [PreFideGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreFideMedal]  DEFAULT ((0)) FOR [PreFideMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreTaskGold]  DEFAULT ((0)) FOR [PreTaskGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreTaskMedal]  DEFAULT ((0)) FOR [PreTaskMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreReferGold]  DEFAULT ((0)) FOR [PreReferGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreReferMedal]  DEFAULT ((0)) FOR [PreReferMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreMealGold]  DEFAULT ((0)) FOR [PreMealGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreMealMedal]  DEFAULT ((0)) FOR [PreMealMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreRegstGold]  DEFAULT ((0)) FOR [PreRegstGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreRegstMedal]  DEFAULT ((0)) FOR [PreRegstMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreTurnGold]  DEFAULT ((0)) FOR [PreTurnGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreTurnMedal]  DEFAULT ((0)) FOR [PreTurnMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreSignGold]  DEFAULT ((0)) FOR [PreSignGold]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_PreSignMedal]  DEFAULT ((0)) FOR [PreSignMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_TotalInsure]  DEFAULT ((0)) FOR [TotalInsure]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_TotalScore]  DEFAULT ((0)) FOR [TotalScore]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_TotalMedal]  DEFAULT ((0)) FOR [TotalMedal]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_Time]  DEFAULT (getdate()) FOR [Time]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_LostWin]  DEFAULT ((0)) FOR [LostWin]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_BankRevenue]  DEFAULT ((0)) FOR [BankRevenue]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_GameRevenue]  DEFAULT ((0)) FOR [GameRevenue]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_BuyPro]  DEFAULT ((0)) FOR [BuyPro]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_MedalToScore]  DEFAULT ((0)) FOR [MedalToScore]
GO

ALTER TABLE [dbo].[RecordDayData] ADD  CONSTRAINT [DF_RecordDayData_AdminGrant]  DEFAULT ((0)) FOR [AdminGrant]
GO
/****** Object:  Table [dbo].[RecordConvertUserMedal]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordConvertUserMedal](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CurInsureScore] [bigint] NOT NULL,
	[CurUserMedal] [bigint] NOT NULL,
	[ConvertUserMedal] [bigint] NOT NULL,
	[ConvertRate] [decimal](18, 2) NOT NULL,
	[IsGamePlaza] [tinyint] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordConvertUserMedal] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前银行金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'CurInsureScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'CurUserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换奖牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'ConvertUserMedal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'ConvertRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否大厅(0:大厅,1:网站)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'IsGamePlaza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertUserMedal', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Table [dbo].[RecordConvertPresent]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordConvertPresent](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[CurInsureScore] [bigint] NOT NULL,
	[CurPresent] [int] NOT NULL,
	[ConvertPresent] [int] NOT NULL,
	[ConvertRate] [int] NOT NULL,
	[IsGamePlaza] [tinyint] NOT NULL,
	[ClientIP] [varchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordConvertPresent] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'房间标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'ServerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换前银行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'CurInsureScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换前魅力点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'CurPresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换点数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'ConvertPresent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'ConvertRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换场所(0:大厅,1:网页)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'IsGamePlaza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'兑换日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordConvertPresent', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Table [dbo].[RecordBaseEnsureMB]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecordBaseEnsureMB](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[BaseEnsureGold] [decimal](18, 2) NOT NULL,
	[ClientID] [varchar](50) NOT NULL,
	[TakeTime] [datetime] NOT NULL,
	[OldGold] [decimal](18, 2) NOT NULL,
	[NewGold] [decimal](18, 2) NOT NULL,
	[OldInsureGold] [decimal](18, 2) NOT NULL,
	[NewInsureGold] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'低保领取金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBaseEnsureMB', @level2type=N'COLUMN',@level2name=N'BaseEnsureGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBaseEnsureMB', @level2type=N'COLUMN',@level2name=N'TakeTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取前金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBaseEnsureMB', @level2type=N'COLUMN',@level2name=N'OldGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取后金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBaseEnsureMB', @level2type=N'COLUMN',@level2name=N'NewGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取前银行金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBaseEnsureMB', @level2type=N'COLUMN',@level2name=N'OldInsureGold'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领取后银行金币' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordBaseEnsureMB', @level2type=N'COLUMN',@level2name=N'NewInsureGold'
GO
/****** Object:  Table [dbo].[RecordBaseEnsure]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordBaseEnsure](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[BaseEnsureGold] [int] NOT NULL,
	[ClientID] [nvarchar](15) NOT NULL,
	[TakeTime] [datetime] NOT NULL,
	[OldGold] [bigint] NOT NULL,
	[OldInsureGold] [bigint] NOT NULL,
	[NewGold] [bigint] NOT NULL,
	[NewInsureGold] [bigint] NOT NULL,
 CONSTRAINT [PK_RecoreBaseEnsure] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordAccountsExpend]    Script Date: 10/28/2015 13:04:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordAccountsExpend](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[OperMasterID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ReAccounts] [nvarchar](31) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[ClientIP] [nvarchar](15) NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordAccountsExpend] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作网管' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'OperMasterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'历史账号或昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'ReAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'历史记录类型 0:历史账号 1:历史昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'ClientIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordAccountsExpend', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
/****** Object:  Default [DF_RecordAccountsExpend_OperMasterID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordAccountsExpend] ADD  CONSTRAINT [DF_RecordAccountsExpend_OperMasterID]  DEFAULT ((0)) FOR [OperMasterID]
GO
/****** Object:  Default [DF_RecordAccountsExpend_Type]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordAccountsExpend] ADD  CONSTRAINT [DF_RecordAccountsExpend_Type]  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF_RecordAccountsExpend_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordAccountsExpend] ADD  CONSTRAINT [DF_RecordAccountsExpend_ClientIP]  DEFAULT (N'000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordAccountsExpend_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordAccountsExpend] ADD  CONSTRAINT [DF_RecordAccountsExpend_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecoreBaseEnsure_BaseEnsureGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsure] ADD  CONSTRAINT [DF_RecoreBaseEnsure_BaseEnsureGold]  DEFAULT ((0)) FOR [BaseEnsureGold]
GO
/****** Object:  Default [DF_RecoreBaseEnsure_OldGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsure] ADD  CONSTRAINT [DF_RecoreBaseEnsure_OldGold]  DEFAULT ((0)) FOR [OldGold]
GO
/****** Object:  Default [DF_RecordBaseEnsure_OldInsureGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsure] ADD  CONSTRAINT [DF_RecordBaseEnsure_OldInsureGold]  DEFAULT ((0)) FOR [OldInsureGold]
GO
/****** Object:  Default [DF_RecoreBaseEnsure_NewGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsure] ADD  CONSTRAINT [DF_RecoreBaseEnsure_NewGold]  DEFAULT ((0)) FOR [NewGold]
GO
/****** Object:  Default [DF_RecordBaseEnsure_NewInsureGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsure] ADD  CONSTRAINT [DF_RecordBaseEnsure_NewInsureGold]  DEFAULT ((0)) FOR [NewInsureGold]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_BaseEnsureGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_BaseEnsureGold]  DEFAULT ((0)) FOR [BaseEnsureGold]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_ClientID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_ClientID]  DEFAULT (N'') FOR [ClientID]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_TakeTime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_TakeTime]  DEFAULT (getdate()) FOR [TakeTime]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_OldGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_OldGold]  DEFAULT ((0)) FOR [OldGold]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_NewGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_NewGold]  DEFAULT ((0)) FOR [NewGold]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_OldInsureGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_OldInsureGold]  DEFAULT ((0)) FOR [OldInsureGold]
GO
/****** Object:  Default [DF_RecordBaseEnsureMB_NewInsureGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordBaseEnsureMB] ADD  CONSTRAINT [DF_RecordBaseEnsureMB_NewInsureGold]  DEFAULT ((0)) FOR [NewInsureGold]
GO
/****** Object:  Default [DF_RecordConvertPresent_KindID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertPresent] ADD  CONSTRAINT [DF_RecordConvertPresent_KindID]  DEFAULT ((0)) FOR [KindID]
GO
/****** Object:  Default [DF_RecordConvertPresent_ServerID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertPresent] ADD  CONSTRAINT [DF_RecordConvertPresent_ServerID]  DEFAULT ((0)) FOR [ServerID]
GO
/****** Object:  Default [DF_RecordConvertPresent_CurInsureScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertPresent] ADD  CONSTRAINT [DF_RecordConvertPresent_CurInsureScore]  DEFAULT ((0)) FOR [CurInsureScore]
GO
/****** Object:  Default [DF_RecordConvertPresent_CurPresent]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertPresent] ADD  CONSTRAINT [DF_RecordConvertPresent_CurPresent]  DEFAULT ((0)) FOR [CurPresent]
GO
/****** Object:  Default [DF_RecordConvertPresent_IsGamePlaza]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertPresent] ADD  CONSTRAINT [DF_RecordConvertPresent_IsGamePlaza]  DEFAULT ((0)) FOR [IsGamePlaza]
GO
/****** Object:  Default [DF_RecordConvertPresent_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertPresent] ADD  CONSTRAINT [DF_RecordConvertPresent_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_CurInsureScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_CurInsureScore]  DEFAULT ((0)) FOR [CurInsureScore]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_CurUserMedal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_CurUserMedal]  DEFAULT ((0)) FOR [CurUserMedal]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_ConvertUserMedal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_ConvertUserMedal]  DEFAULT ((0)) FOR [ConvertUserMedal]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_ConvertRate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_ConvertRate]  DEFAULT ((0)) FOR [ConvertRate]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_IsGamePlaza]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_IsGamePlaza]  DEFAULT ((0)) FOR [IsGamePlaza]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_ClientIP]  DEFAULT ('') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordConvertUserMedal_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordConvertUserMedal] ADD  CONSTRAINT [DF_RecordConvertUserMedal_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordEncashPresent_EncashTime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEncashPresent] ADD  CONSTRAINT [DF_RecordEncashPresent_EncashTime]  DEFAULT (getdate()) FOR [EncashTime]
GO
/****** Object:  Default [DF_RecordEveryDayData_UserTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_UserTotal]  DEFAULT ((0)) FOR [UserTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_PayUserTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_PayUserTotal]  DEFAULT ((0)) FOR [PayUserTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_ActiveUserNum]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_ActiveUserNum]  DEFAULT ((0)) FOR [ActiveUserTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_LossUser]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_LossUser]  DEFAULT ((0)) FOR [LossUser]
GO
/****** Object:  Default [DF_RecordEveryDayData_LossUserTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_LossUserTotal]  DEFAULT ((0)) FOR [LossUserTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_LossPayUser]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_LossPayUser]  DEFAULT ((0)) FOR [LossPayUser]
GO
/****** Object:  Default [DF_RecordEveryDayData_LossPayUserTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_LossPayUserTotal]  DEFAULT ((0)) FOR [LossPayUserTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_PayTotalAmount]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_PayTotalAmount]  DEFAULT ((0)) FOR [PayTotalAmount]
GO
/****** Object:  Default [DF_RecordEveryDayData_PayAmountForCurrency]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_PayAmountForCurrency]  DEFAULT ((0)) FOR [PayAmountForCurrency]
GO
/****** Object:  Default [DF_RecordEveryDayData_GoldTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_GoldTotal]  DEFAULT ((0)) FOR [GoldTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_CurrencyTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_CurrencyTotal]  DEFAULT ((0)) FOR [CurrencyTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_GameTax]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_GameTax]  DEFAULT ((0)) FOR [GameTax]
GO
/****** Object:  Default [DF_RecordEveryDayData_GameTaxTotal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_GameTaxTotal]  DEFAULT ((0)) FOR [GameTaxTotal]
GO
/****** Object:  Default [DF_RecordEveryDayData_ThatDayBankTax]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_ThatDayBankTax]  DEFAULT ((0)) FOR [BankTax]
GO
/****** Object:  Default [DF_RecordEveryDayData_Waste]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_Waste]  DEFAULT ((0)) FOR [Waste]
GO
/****** Object:  Default [DF_RecordEveryDayData_UserAVGOnlineTime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_RecordEveryDayData_UserAVGOnlineTime]  DEFAULT ((0)) FOR [UserAVGOnlineTime]
GO
/****** Object:  Default [DF_Table_1_InputDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayData] ADD  CONSTRAINT [DF_Table_1_InputDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordEveryDayRoomData_Waste]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayRoomData] ADD  CONSTRAINT [DF_RecordEveryDayRoomData_Waste]  DEFAULT ((0)) FOR [Waste]
GO
/****** Object:  Default [DF_RecordEveryDayRoomData_Revenue]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayRoomData] ADD  CONSTRAINT [DF_RecordEveryDayRoomData_Revenue]  DEFAULT ((0)) FOR [Revenue]
GO
/****** Object:  Default [DF_RecordEveryDayRoomData_Medal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayRoomData] ADD  CONSTRAINT [DF_RecordEveryDayRoomData_Medal]  DEFAULT ((0)) FOR [Medal]
GO
/****** Object:  Default [DF_RecordEveryDayRoomData_InputDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordEveryDayRoomData] ADD  CONSTRAINT [DF_RecordEveryDayRoomData_InputDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantFlee_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearFlee] ADD  CONSTRAINT [DF_RecordGrantFlee_ClientIP]  DEFAULT ('000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantFlee_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearFlee] ADD  CONSTRAINT [DF_RecordGrantFlee_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantFlee_CurFlee]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearFlee] ADD  CONSTRAINT [DF_RecordGrantFlee_CurFlee]  DEFAULT ((0)) FOR [CurFlee]
GO
/****** Object:  Default [DF_RecordGrantFlee_Reason]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearFlee] ADD  CONSTRAINT [DF_RecordGrantFlee_Reason]  DEFAULT (N'') FOR [Reason]
GO
/****** Object:  Default [DF_RecordGrantClearScore_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearScore] ADD  CONSTRAINT [DF_RecordGrantClearScore_ClientIP]  DEFAULT ('000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantClearScore_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearScore] ADD  CONSTRAINT [DF_RecordGrantClearScore_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantClearScore_UserID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearScore] ADD  CONSTRAINT [DF_RecordGrantClearScore_UserID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_RecordGrantClearScore_CurScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearScore] ADD  CONSTRAINT [DF_RecordGrantClearScore_CurScore]  DEFAULT ((0)) FOR [CurScore]
GO
/****** Object:  Default [DF_RecordGrantClearScore_Reason]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantClearScore] ADD  CONSTRAINT [DF_RecordGrantClearScore_Reason]  DEFAULT ('') FOR [Reason]
GO
/****** Object:  Default [DF_RecordGrantExperience_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantExperience] ADD  CONSTRAINT [DF_RecordGrantExperience_ClientIP]  DEFAULT ('000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantExperience_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantExperience] ADD  CONSTRAINT [DF_RecordGrantExperience_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantExperience_CurExperience]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantExperience] ADD  CONSTRAINT [DF_RecordGrantExperience_CurExperience]  DEFAULT ((0)) FOR [CurExperience]
GO
/****** Object:  Default [DF_RecordGrantExperience_AddExperience]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantExperience] ADD  CONSTRAINT [DF_RecordGrantExperience_AddExperience]  DEFAULT ((0)) FOR [AddExperience]
GO
/****** Object:  Default [DF_RecordGrantExperience_Reason]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantExperience] ADD  CONSTRAINT [DF_RecordGrantExperience_Reason]  DEFAULT (N'') FOR [Reason]
GO
/****** Object:  Default [DF_RecordGrantGameID_IDLevel]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameID] ADD  CONSTRAINT [DF_RecordGrantGameID_IDLevel]  DEFAULT ((0)) FOR [IDLevel]
GO
/****** Object:  Default [DF_RecordGrantGameID_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameID] ADD  CONSTRAINT [DF_RecordGrantGameID_ClientIP]  DEFAULT ('000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantGameID_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameID] ADD  CONSTRAINT [DF_RecordGrantGameID_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantGameScore_VisitIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameScore] ADD  CONSTRAINT [DF_RecordGrantGameScore_VisitIP]  DEFAULT (N'000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantGameScore_CreateDatetime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameScore] ADD  CONSTRAINT [DF_RecordGrantGameScore_CreateDatetime]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantGameScore_CurScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameScore] ADD  CONSTRAINT [DF_RecordGrantGameScore_CurScore]  DEFAULT ((0)) FOR [CurScore]
GO
/****** Object:  Default [DF_RecordGrantGameScore_AddScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameScore] ADD  CONSTRAINT [DF_RecordGrantGameScore_AddScore]  DEFAULT ((0)) FOR [AddScore]
GO
/****** Object:  Default [DF_RecordGrantGameScore_Reason]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantGameScore] ADD  CONSTRAINT [DF_RecordGrantGameScore_Reason]  DEFAULT (N'') FOR [Reason]
GO
/****** Object:  Default [DF_RecordGrantMenber_MasterID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_RecordGrantMenber_MasterID]  DEFAULT ((0)) FOR [MasterID]
GO
/****** Object:  Default [DF_RecordGrantMenber_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_RecordGrantMenber_ClientIP]  DEFAULT ('000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantMenber_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_RecordGrantMenber_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantMenber_UserID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_RecordGrantMenber_UserID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_Table_1_CardType]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_Table_1_CardType]  DEFAULT ((0)) FOR [GrantCardType]
GO
/****** Object:  Default [DF_RecordGrantMenber_Reason]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_RecordGrantMenber_Reason]  DEFAULT ('') FOR [Reason]
GO
/****** Object:  Default [DF_RecordGrantMember_MemberDays]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantMember] ADD  CONSTRAINT [DF_RecordGrantMember_MemberDays]  DEFAULT ((0)) FOR [MemberDays]
GO
/****** Object:  Default [DF_RecordGrantScore_VisitIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantTreasure] ADD  CONSTRAINT [DF_RecordGrantScore_VisitIP]  DEFAULT (N'000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordGrantScore_CreateDatetime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantTreasure] ADD  CONSTRAINT [DF_RecordGrantScore_CreateDatetime]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordGrantScore_CurScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantTreasure] ADD  CONSTRAINT [DF_RecordGrantScore_CurScore]  DEFAULT ((0)) FOR [CurGold]
GO
/****** Object:  Default [DF_RecordGrantScore_AddScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantTreasure] ADD  CONSTRAINT [DF_RecordGrantScore_AddScore]  DEFAULT ((0)) FOR [AddGold]
GO
/****** Object:  Default [DF_RecordGrantScore_Reason]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordGrantTreasure] ADD  CONSTRAINT [DF_RecordGrantScore_Reason]  DEFAULT (N'') FOR [Reason]
GO
/****** Object:  Default [DF_RecordLevelPresent_LevelGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordLevelPresent] ADD  CONSTRAINT [DF_RecordLevelPresent_LevelGold]  DEFAULT ((0)) FOR [LevelGold]
GO
/****** Object:  Default [DF_RecordLevelPresent_GetTime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordLevelPresent] ADD  CONSTRAINT [DF_RecordLevelPresent_GetTime]  DEFAULT (getdate()) FOR [GetTime]
GO
/****** Object:  Default [DF_RecordLevelPresent_CurGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordLevelPresent] ADD  CONSTRAINT [DF_RecordLevelPresent_CurGold]  DEFAULT ((0)) FOR [CurGold]
GO
/****** Object:  Default [DF_RecordLevelPresent_CurMedal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordLevelPresent] ADD  CONSTRAINT [DF_RecordLevelPresent_CurMedal]  DEFAULT ((0)) FOR [CurMedal]
GO
/****** Object:  Default [DF_RecordLevelPresent_Medal]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordLevelPresent] ADD  CONSTRAINT [DF_RecordLevelPresent_Medal]  DEFAULT ((0)) FOR [Medal]
GO
/****** Object:  Default [DF_RecordPasswdExpend_UserID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordPasswdExpend] ADD  CONSTRAINT [DF_RecordPasswdExpend_UserID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_RecordPasswdExpend_ReLogonPass]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordPasswdExpend] ADD  CONSTRAINT [DF_RecordPasswdExpend_ReLogonPass]  DEFAULT (N'--') FOR [ReLogonPasswd]
GO
/****** Object:  Default [DF_RecordPasswdExpend_ReInsurePass]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordPasswdExpend] ADD  CONSTRAINT [DF_RecordPasswdExpend_ReInsurePass]  DEFAULT (N'--') FOR [ReInsurePasswd]
GO
/****** Object:  Default [DF_RecordPasswdExpend_ClientIP]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordPasswdExpend] ADD  CONSTRAINT [DF_RecordPasswdExpend_ClientIP]  DEFAULT ('000.000.000.000') FOR [ClientIP]
GO
/****** Object:  Default [DF_RecordPasswdExpend_CollectDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordPasswdExpend] ADD  CONSTRAINT [DF_RecordPasswdExpend_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
/****** Object:  Default [DF_RecordSendPresent_SendTime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSendPresent] ADD  CONSTRAINT [DF_RecordSendPresent_SendTime]  DEFAULT (getdate()) FOR [SendTime]
GO
/****** Object:  Default [DF_RecordSendProperty_SendTime]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSendProperty] ADD  CONSTRAINT [DF_RecordSendProperty_SendTime]  DEFAULT (getdate()) FOR [SendTime]
GO
/****** Object:  Default [DF_RecordSingin_AwardGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSignin] ADD  CONSTRAINT [DF_RecordSingin_AwardGold]  DEFAULT ((0)) FOR [RewardGold]
GO
/****** Object:  Default [DF_RecordSingin_ClientID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSignin] ADD  CONSTRAINT [DF_RecordSingin_ClientID]  DEFAULT ('') FOR [ClientID]
GO
/****** Object:  Default [DF_RecordSingin_InputDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSignin] ADD  CONSTRAINT [DF_RecordSingin_InputDate]  DEFAULT (getdate()) FOR [InputDate]
GO
/****** Object:  Default [DF_RecordSignin_OldGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSignin] ADD  CONSTRAINT [DF_RecordSignin_OldGold]  DEFAULT ((0)) FOR [OldGold]
GO
/****** Object:  Default [DF_RecordSignin_NewGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSignin] ADD  CONSTRAINT [DF_RecordSignin_NewGold]  DEFAULT ((0)) FOR [NewGold]
GO
/****** Object:  Default [DF_RecordSigninMB_AwardGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninMB] ADD  CONSTRAINT [DF_RecordSigninMB_AwardGold]  DEFAULT ((0)) FOR [RewardGold]
GO
/****** Object:  Default [DF_RecordSigninMB_ClientID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninMB] ADD  CONSTRAINT [DF_RecordSigninMB_ClientID]  DEFAULT ('') FOR [ClientID]
GO
/****** Object:  Default [DF_RecordSigninMB_InputDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninMB] ADD  CONSTRAINT [DF_RecordSigninMB_InputDate]  DEFAULT (getdate()) FOR [InputDate]
GO
/****** Object:  Default [DF_RecordSigninMB_OldGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninMB] ADD  CONSTRAINT [DF_RecordSigninMB_OldGold]  DEFAULT ((0)) FOR [OldGold]
GO
/****** Object:  Default [DF_RecordSigninMB_NewGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninMB] ADD  CONSTRAINT [DF_RecordSigninMB_NewGold]  DEFAULT ((0)) FOR [NewGold]
GO
/****** Object:  Default [DF_RecordSigninRewardCount_AwardGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninRewardCount] ADD  CONSTRAINT [DF_RecordSigninRewardCount_AwardGold]  DEFAULT ((0)) FOR [RewardGold]
GO
/****** Object:  Default [DF_RecordSigninRewardCount_CountDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninRewardCount] ADD  CONSTRAINT [DF_RecordSigninRewardCount_CountDate]  DEFAULT ((0)) FOR [CountDate]
GO
/****** Object:  Default [DF_RecordSigninRewardCount_ClientID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninRewardCount] ADD  CONSTRAINT [DF_RecordSigninRewardCount_ClientID]  DEFAULT ('') FOR [ClientID]
GO
/****** Object:  Default [DF_RecordSigninRewardCount_InputDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninRewardCount] ADD  CONSTRAINT [DF_RecordSigninRewardCount_InputDate]  DEFAULT (getdate()) FOR [InputDate]
GO
/****** Object:  Default [DF_RecordSigninRewardCount_OldGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninRewardCount] ADD  CONSTRAINT [DF_RecordSigninRewardCount_OldGold]  DEFAULT ((0)) FOR [OldGold]
GO
/****** Object:  Default [DF_RecordSigninRewardCount_NewGold]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordSigninRewardCount] ADD  CONSTRAINT [DF_RecordSigninRewardCount_NewGold]  DEFAULT ((0)) FOR [NewGold]
GO
/****** Object:  Default [DF_RecardTask_DateID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordTask] ADD  CONSTRAINT [DF_RecardTask_DateID]  DEFAULT ((0)) FOR [DateID]
GO
/****** Object:  Default [DF_RecardTask_UserID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordTask] ADD  CONSTRAINT [DF_RecardTask_UserID]  DEFAULT ((0)) FOR [UserID]
GO
/****** Object:  Default [DF_RecardTask_TaskID]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordTask] ADD  CONSTRAINT [DF_RecardTask_TaskID]  DEFAULT ((0)) FOR [TaskID]
GO
/****** Object:  Default [DF_RecordTask_InputDate]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[RecordTask] ADD  CONSTRAINT [DF_RecordTask_InputDate]  DEFAULT (getdate()) FOR [InputDate]
GO
/****** Object:  Default [DF_Temp_Score]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_Score]  DEFAULT ((0)) FOR [Score]
GO
/****** Object:  Default [DF_Temp_InsureScore]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_InsureScore]  DEFAULT ((0)) FOR [InsureScore]
GO
/****** Object:  Default [DF_Temp_ScoreSum]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_ScoreSum]  DEFAULT ((0)) FOR [ScoreSum]
GO
/****** Object:  Default [DF_Temp_dianka]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_dianka]  DEFAULT ((0)) FOR [dianka]
GO
/****** Object:  Default [DF_Temp_wangyin]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_wangyin]  DEFAULT ((0)) FOR [wangyin]
GO
/****** Object:  Default [DF_Temp_yikatong]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_yikatong]  DEFAULT ((0)) FOR [yikatong]
GO
/****** Object:  Default [DF_Temp_zaixian]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_zaixian]  DEFAULT ((0)) FOR [zaixian]
GO
/****** Object:  Default [DF_Temp_qiandao]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_qiandao]  DEFAULT ((0)) FOR [qiandao]
GO
/****** Object:  Default [DF_Temp_zhuanpan]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_zhuanpan]  DEFAULT ((0)) FOR [zhuanpan]
GO
/****** Object:  Default [DF_Temp_jinduan]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_jinduan]  DEFAULT ((0)) FOR [jinduan]
GO
/****** Object:  Default [DF_Temp_tuiguang]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_tuiguang]  DEFAULT ((0)) FOR [tuiguang]
GO
/****** Object:  Default [DF_Temp_jifentojinbi]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_jifentojinbi]  DEFAULT ((0)) FOR [jifentojinbi]
GO
/****** Object:  Default [DF_Temp_bisai]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_bisai]  DEFAULT ((0)) FOR [bisai]
GO
/****** Object:  Default [DF_Temp_zhuce]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_zhuce]  DEFAULT ((0)) FOR [zhuce]
GO
/****** Object:  Default [DF_web_GoldStatIstical_zengsong]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_zengsong]  DEFAULT ((0)) FOR [zengsong]
GO
/****** Object:  Default [DF_web_GoldStatIstical_xinshoulingqu]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_xinshoulingqu]  DEFAULT ((0)) FOR [xinshoulingqu]
GO
/****** Object:  Default [DF_web_GoldStatIstical_shoujilingqu]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_shoujilingqu]  DEFAULT ((0)) FOR [shoujilingqu]
GO
/****** Object:  Default [DF_web_GoldStatIstical_ziliaolingqu]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_ziliaolingqu]  DEFAULT ((0)) FOR [ziliaolingqu]
GO
/****** Object:  Default [DF_web_GoldStatIstical_chongzhilingqu]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_chongzhilingqu]  DEFAULT ((0)) FOR [chongzhilingqu]
GO
/****** Object:  Default [DF_web_GoldStatIstical_renwulingqu]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_renwulingqu]  DEFAULT ((0)) FOR [renwulingqu]
GO
/****** Object:  Default [DF_Temp_jinbitojifen]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_jinbitojifen]  DEFAULT ((0)) FOR [jinbitojifen]
GO
/****** Object:  Default [DF_web_GoldStatIstical_zhuanzhangshuishou]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_web_GoldStatIstical_zhuanzhangshuishou]  DEFAULT ((0)) FOR [zhuanzhangshuishou]
GO
/****** Object:  Default [DF_Temp_shuishou]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_shuishou]  DEFAULT ((0)) FOR [shuishou]
GO
/****** Object:  Default [DF_Temp_xitong]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_xitong]  DEFAULT ((0)) FOR [xitong]
GO
/****** Object:  Default [DF_Temp_daoju]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_daoju]  DEFAULT ((0)) FOR [daoju]
GO
/****** Object:  Default [DF_Temp_lipin]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_lipin]  DEFAULT ((0)) FOR [lipin]
GO
/****** Object:  Default [DF_Temp_shangcheng]    Script Date: 10/28/2015 13:04:51 ******/
ALTER TABLE [dbo].[web_GoldStatIstical] ADD  CONSTRAINT [DF_Temp_shangcheng]  DEFAULT ((0)) FOR [shangcheng]
GO
