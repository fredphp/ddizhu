USE QPTreasureDB
GO

-- 会员等级抽奖配置
TRUNCATE TABLE DayLotterMemberConfig
GO

INSERT INTO [dbo].[DayLotterMemberConfig] ([member], [Times], [interval], [WastTime]) VALUES (0, 1, 216000, 3600)
INSERT INTO [dbo].[DayLotterMemberConfig] ([member], [Times], [interval], [WastTime]) VALUES (1, 4, 200000, 3600)
INSERT INTO [dbo].[DayLotterMemberConfig] ([member], [Times], [interval], [WastTime]) VALUES (2, 5, 180000, 3600)
INSERT INTO [dbo].[DayLotterMemberConfig] ([member], [Times], [interval], [WastTime]) VALUES (3, 6, 150000, 3600)
INSERT INTO [dbo].[DayLotterMemberConfig] ([member], [Times], [interval], [WastTime]) VALUES (4, 8, 120000, 3600)
INSERT INTO [dbo].[DayLotterMemberConfig] ([member], [Times], [interval], [WastTime]) VALUES (5, 12, 100000, 3600)
GO

-- 游戏时长抽奖配置
TRUNCATE TABLE GameLotteryConfig
GO

INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (0, 1, 100, 0, 0, 0, 0.00, N'摇奖数字范围')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (1, 1, 20, 41, 1, 10, 20000.00, N'安慰奖 二万金豆 代号：10')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (2, 21, 30, 2, 2, 7, 60000.00, N'六万金豆 代号：7')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (3, 31, 40, 3, 3, 2, 100000.00, N'十万金豆 代号：2')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (4, 41, 45, 4, 4, 4, 200000.00, N'二十万金豆 代号：4')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (5, 46, 48, 5, 5, 5, 400000.00, N'四十万金豆 代号：5')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (6, 49, 50, 10, 6, 8, 1000000.00, N'一百万金豆 代号：8')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (7, 51, 70, 50, 7, 11, 2000000.00, N'二百万金豆 代号：11')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (8, 71, 80, 80, 81, 9, 10000000.00, N'三等奖 一千万金豆 代号：9')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (9, 81, 90, 90, 91, 6, 20000000.00, N'二等奖 二千万金豆 代号：6')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (10, 91, 95, 95, 102, 3,100000000.00, N'一等奖 一亿金豆 代号：3')
INSERT INTO [dbo].[GameLotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (11, 96, 98, 100, 103, 1, 200000000.00, N'特等奖二亿金豆 代号：1')
GO

-- 幸运币抽奖配置
TRUNCATE TABLE LotteryConfig
GO

INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (0, 1, 100, 0, 0, 0, 0.00, N'摇奖数字范围')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (1, 1, 20, 41, 1, 10, 20000.00, N'安慰奖 二万金豆 代号：10')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (2, 21, 30, 2, 2, 7, 60000.00, N'六万金豆 代号：7')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (3, 31, 40, 3, 3, 2, 100000.00, N'十万金豆 代号：2')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (4, 41, 45, 4, 4, 4, 200000.00, N'二十万金豆 代号：4')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (5, 46, 48, 5, 5, 5, 400000.00, N'四十万金豆 代号：5')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (6, 49, 50, 10, 6, 8, 1000000.00, N'一百万金豆 代号：8')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (7, 51, 70, 50, 7, 11, 2000000.00, N'二百万金豆 代号：11')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (8, 71, 80, 80, 81, 9, 10000000.00, N'三等奖 一千万金豆 代号：9')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (9, 81, 90, 90, 91, 6, 20000000.00, N'二等奖 二千万金豆 代号：6')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (10, 91, 95, 95, 102, 3,100000000.00, N'一等奖 一亿金豆 代号：3')
INSERT INTO [dbo].[LotteryConfig] ([ConfigID], [MinNum], [MaxNum], [Probability],[Number],[Code],[Bonus],[Remark]) VALUES (11, 96, 98, 100, 103, 1, 200000000.00, N'特等奖二亿金豆 代号：1')
GO
