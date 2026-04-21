USE QPPlatformDB
GO

-- 签到配置
TRUNCATE TABLE GameTypeItem
GO

INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (11, 0, 100, '赛事中心', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (13, 0, 102, '热门捕鱼', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (20, 0, 103, '热门捕鱼', 1)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (3, 0, 104, '牌类游戏', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (9, 0, 105, '对战游戏', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (5, 0, 106, '麻将游戏', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (12, 0, 107, '多人游戏', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (14, 0, 108, '棋类游戏', 0)
INSERT INTO [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (4, 0, 109, '休闲游戏', 0)

GO