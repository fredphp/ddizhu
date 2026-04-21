-- =============================================
-- 网站相关数据库创建脚本
-- 适用于: SQL Server 2019/2022
-- =============================================

USE master
GO

-- =============================================
-- 1. 创建网站前台库 QPNativeWebDB
-- =============================================
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPNativeWebDB')
BEGIN
    ALTER DATABASE [QPNativeWebDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPNativeWebDB]
    PRINT 'QPNativeWebDB 已删除'
END
GO

CREATE DATABASE [QPNativeWebDB] COLLATE Chinese_PRC_CI_AS
GO

ALTER DATABASE [QPNativeWebDB] SET COMPATIBILITY_LEVEL = 160
GO

ALTER DATABASE [QPNativeWebDB] SET AUTO_SHRINK OFF
GO

ALTER DATABASE [QPNativeWebDB] SET RECOVERY SIMPLE
GO

PRINT 'QPNativeWebDB 创建完成'
GO

-- =============================================
-- 2. 创建后台管理库 QPPlatformManagerDB
-- =============================================
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPPlatformManagerDB')
BEGIN
    ALTER DATABASE [QPPlatformManagerDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPPlatformManagerDB]
    PRINT 'QPPlatformManagerDB 已删除'
END
GO

CREATE DATABASE [QPPlatformManagerDB] COLLATE Chinese_PRC_CI_AS
GO

ALTER DATABASE [QPPlatformManagerDB] SET COMPATIBILITY_LEVEL = 160
GO

ALTER DATABASE [QPPlatformManagerDB] SET AUTO_SHRINK OFF
GO

ALTER DATABASE [QPPlatformManagerDB] SET RECOVERY SIMPLE
GO

PRINT 'QPPlatformManagerDB 创建完成'
GO

-- =============================================
-- 3. 创建代理商库 QPAgencyDB
-- =============================================
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPAgencyDB')
BEGIN
    ALTER DATABASE [QPAgencyDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPAgencyDB]
    PRINT 'QPAgencyDB 已删除'
END
GO

CREATE DATABASE [QPAgencyDB] COLLATE Chinese_PRC_CI_AS
GO

ALTER DATABASE [QPAgencyDB] SET COMPATIBILITY_LEVEL = 160
GO

ALTER DATABASE [QPAgencyDB] SET AUTO_SHRINK OFF
GO

ALTER DATABASE [QPAgencyDB] SET RECOVERY SIMPLE
GO

PRINT 'QPAgencyDB 创建完成'
GO

-- =============================================
-- 完成
-- =============================================
PRINT '=========================================='
PRINT '所有网站数据库创建完成！'
PRINT '接下来请执行表结构脚本：'
PRINT '  1. 2_1_网站库脚本.sql'
PRINT '  2. 2_2_后台库脚本.sql'
PRINT '  3. 3_2_代理库脚本.sql'
PRINT '=========================================='
GO
