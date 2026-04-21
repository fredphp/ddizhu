USE QPPlatformDB
GO

-- 平台签到配置
TRUNCATE TABLE SigninConfig
GO

INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (1, 1000)
INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (2, 2000)
INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (3, 4000)
INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (4, 8000)
INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (5, 16000)
INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (6, 32000)
INSERT INTO [dbo].[SigninConfig] ([DayID], [RewardGold]) VALUES (7, 64000)

GO

-- 手机签到配置
TRUNCATE TABLE SigninConfigMB
GO

INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (1, 1000)
INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (2, 2000)
INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (3, 4000)
INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (4, 8000)
INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (5, 16000)
INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (6, 32000)
INSERT INTO [dbo].[SigninConfigMB] ([DayID], [RewardGold]) VALUES (7, 64000)

GO