USE QPNativeWebDB
GO

-- 系统广告
TRUNCATE TABLE Ads
GO

INSERT INTO [dbo].[Ads] ([ID], [Title], [ResourceURL], [LinkURL], [Type], [SortID], [Remark]) VALUES (1, N'', N'/Upload/Initialize/Login.bmp', N'http://zxqp.maotui.cn', 1, 10, N'大厅登陆框广告位 [565*135]')
INSERT INTO [dbo].[Ads] ([ID], [Title], [ResourceURL], [LinkURL], [Type], [SortID], [Remark]) VALUES (2, N'', N'/Upload/Initialize/Close.jpg', N'http://zxqp.maotui.cn', 1, 10, N'大厅关闭框广告位 [436*95]')
INSERT INTO [dbo].[Ads] ([ID], [Title], [ResourceURL], [LinkURL], [Type], [SortID], [Remark]) VALUES (3, N'', N'/Upload/Initialize/GameRoom.gif', N'http://zxqp.maotui.cn', 1, 10, N'房间右上角广告位 [218*82]')
INSERT INTO [dbo].[Ads] ([ID], [Title], [ResourceURL], [LinkURL], [Type], [SortID], [Remark]) VALUES (4, N'', N'/Upload/Initialize/PlatformBottom.gif', N'http://zxqp.maotui.cn', 1, 10, N'大厅右下角广告位 [217*266]')
INSERT INTO [dbo].[Ads] ([ID], [Title], [ResourceURL], [LinkURL], [Type], [SortID], [Remark]) VALUES (7, N'', N'/Upload/Initialize/one.png', N'http://zxqp.maotui.cn', 0, 10, N'首页轮换广告')
INSERT INTO [dbo].[Ads] ([ID], [Title], [ResourceURL], [LinkURL], [Type], [SortID], [Remark]) VALUES (8, N'', N'/Upload/Initialize/two.png', N'http://zxqp.maotui.cn', 0, 10, N'首页轮换广告')

GO