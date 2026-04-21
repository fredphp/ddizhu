-- =============================================
-- 斗地主数据库初始化脚本
-- 适用于: Docker SQL Server
-- 执行方式: sqlcmd -S localhost,1433 -U sa -P 'Admin@1234' -i 0_创建数据库.sql
-- =============================================

USE master
GO

-- 删除已存在的数据库（如果需要重新初始化）
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPAccountsDB')
DROP DATABASE [QPAccountsDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPPlatformDB')
DROP DATABASE [QPPlatformDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPTreasureDB')
DROP DATABASE [QPTreasureDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPRecordDB')
DROP DATABASE [QPRecordDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPGameScoreDB')
DROP DATABASE [QPGameScoreDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPGameMatchDB')
DROP DATABASE [QPGameMatchDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPEducateDB')
DROP DATABASE [QPEducateDB]
GO

-- 创建用户库
CREATE DATABASE [QPAccountsDB] COLLATE Chinese_PRC_CI_AS
GO

-- 创建平台库
CREATE DATABASE [QPPlatformDB] COLLATE Chinese_PRC_CI_AS
GO

-- 创建金豆库（财富库）
CREATE DATABASE [QPTreasureDB] COLLATE Chinese_PRC_CI_AS
GO

-- 创建记录库
CREATE DATABASE [QPRecordDB] COLLATE Chinese_PRC_CI_AS
GO

-- 创建积分库
CREATE DATABASE [QPGameScoreDB] COLLATE Chinese_PRC_CI_AS
GO

-- 创建比赛库
CREATE DATABASE [QPGameMatchDB] COLLATE Chinese_PRC_CI_AS
GO

-- 创建练习库
CREATE DATABASE [QPEducateDB] COLLATE Chinese_PRC_CI_AS
GO

PRINT '数据库创建完成！'
GO
