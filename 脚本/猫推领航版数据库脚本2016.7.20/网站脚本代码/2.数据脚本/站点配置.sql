USE QPNativeWebDB
GO

-- 站点配置
TRUNCATE TABLE ConfigInfo
GO

SET IDENTITY_INSERT [dbo].[ConfigInfo] ON
INSERT [dbo].[ConfigInfo] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8], [SortID]) VALUES (1, N'ContactConfig', N'联系方式配置', N'参数说明
字段1：联系QQ1 
字段2：联系QQ2 
字段3：联系电话', N' ', N' ', N' ', N'', N'', N'', N'', N'', 5)
INSERT [dbo].[ConfigInfo] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8], [SortID]) VALUES (2, N'SiteConfig', N'站点配置', N'参数说明
字段1：站点名称
字段2：站点域名 
字段3：图片域名(修改后30分钟内生效)
字段8：网站底部文字', N'猫推棋牌', N'http://zxqp.maotui.cn', N'http://imagezx.maotui.cn', N'', N'', N'', N'', N'Copyright @ 2014 maotui.cn , All Rights Reserved.&lt;br /&gt;
                版权所有 深圳市猫推科技有限公司&lt;br /&gt;
                ICP许可证：粤网文[2012]0718-028号&lt;br /&gt;
                游戏融入生活，快乐无处不在！&lt;br /&gt;
                E-MAIL：&lt;br /&gt;', 1)
INSERT [dbo].[ConfigInfo] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8], [SortID]) VALUES (3, N'GameFullPackageConfig', N'大厅整包配置', N'字段1：软件名称
字段2：发布日期
字段3：版本号
字段4：操作系统
字段5：软件大小
字段6：下载地址', N'游戏大厅完整版', N'2014年10月30日', N'3.0.0.1', N'XP/vista/Win7', N'20MB', N'/Download/MTGame.exe', N'', N'', 20)
INSERT [dbo].[ConfigInfo] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8], [SortID]) VALUES (4, N'GameJanePackageConfig', N'大厅简包配置', N'字段1：软件名称
字段2：发布日期
字段3：版本号
字段4：操作系统
字段5：软件大小
字段6：下载地址', N'游戏大厅精简版', N'2014年10月30日', N'3.0.0.1', N'XP/vista/Win7', N'4.42MB', N'/Download/MTGame.exe', N'', N'', 15)
INSERT [dbo].[ConfigInfo] ([ConfigID], [ConfigKey], [ConfigName], [ConfigString], [Field1], [Field2], [Field3], [Field4], [Field5], [Field6], [Field7], [Field8], [SortID]) VALUES (7, N'EmailConfig', N'邮箱配置', N'字段1：邮箱账号
字段2：邮箱密码
字段3：SmtpServer服务提供地址smtp.qq.com字段4：端口', N'test@maotui.cn', N'test', N'smtp.qq.com', N'25', N'', N'', N'', N'', 30)
SET IDENTITY_INSERT [dbo].[ConfigInfo] OFF

GO