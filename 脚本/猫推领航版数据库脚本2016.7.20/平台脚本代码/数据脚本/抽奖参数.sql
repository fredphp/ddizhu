USE QPPlatformDB
GO

-- 抽奖配置
TRUNCATE TABLE PublicConfig
GO

SET IDENTITY_INSERT [dbo].[PublicConfig] ON
INSERT [dbo].[PublicConfig] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8]) VALUES (1, N'Website',N'网站参数配置',N'参数说明：Field2：抽奖页网站页脚信息', N'', N'Copyright  2016 All Rights Reserved', N'', N'', N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[PublicConfig] ON
INSERT [dbo].[PublicConfig] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8]) VALUES (3, N'GameLottery',N'游戏时常抽奖配置',N'参数配置说明：Field1：活动状态，0-开启，1-禁止', 1, N'', N'', N'', N'', N'', N'', N'')

GO
