-- =============================================
-- 重建所有数据库脚本
-- 用于解决脚本重复执行导致的约束冲突问题
-- 执行此脚本后，再依次执行 2_1 到 2_7 脚本
-- =============================================

USE master
GO

-- 删除所有数据库
PRINT '正在删除数据库...'

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPAccountsDB')
BEGIN
    ALTER DATABASE [QPAccountsDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPAccountsDB]
    PRINT 'QPAccountsDB 已删除'
END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPPlatformDB')
BEGIN
    ALTER DATABASE [QPPlatformDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPPlatformDB]
    PRINT 'QPPlatformDB 已删除'
END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPTreasureDB')
BEGIN
    ALTER DATABASE [QPTreasureDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPTreasureDB]
    PRINT 'QPTreasureDB 已删除'
END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPRecordDB')
BEGIN
    ALTER DATABASE [QPRecordDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPRecordDB]
    PRINT 'QPRecordDB 已删除'
END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPGameScoreDB')
BEGIN
    ALTER DATABASE [QPGameScoreDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPGameScoreDB]
    PRINT 'QPGameScoreDB 已删除'
END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPGameMatchDB')
BEGIN
    ALTER DATABASE [QPGameMatchDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPGameMatchDB]
    PRINT 'QPGameMatchDB 已删除'
END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QPEducateDB')
BEGIN
    ALTER DATABASE [QPEducateDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [QPEducateDB]
    PRINT 'QPEducateDB 已删除'
END
GO

PRINT '=========================================='
PRINT '所有数据库已删除，正在重新创建...'
PRINT '=========================================='
GO

-- 重新创建数据库
CREATE DATABASE [QPAccountsDB] COLLATE Chinese_PRC_CI_AS
GO
CREATE DATABASE [QPPlatformDB] COLLATE Chinese_PRC_CI_AS
GO
CREATE DATABASE [QPTreasureDB] COLLATE Chinese_PRC_CI_AS
GO
CREATE DATABASE [QPRecordDB] COLLATE Chinese_PRC_CI_AS
GO
CREATE DATABASE [QPGameScoreDB] COLLATE Chinese_PRC_CI_AS
GO
CREATE DATABASE [QPGameMatchDB] COLLATE Chinese_PRC_CI_AS
GO
CREATE DATABASE [QPEducateDB] COLLATE Chinese_PRC_CI_AS
GO

PRINT '=========================================='
PRINT '所有数据库创建完成！'
PRINT '现在请依次执行以下脚本：'
PRINT '  1. 2_1_用户库脚本.sql'
PRINT '  2. 2_2_平台库脚本.sql'
PRINT '  3. 2_3_金豆库脚本.sql'
PRINT '  4. 2_4_记录库脚本.sql'
PRINT '  5. 2_5_积分库脚本.sql'
PRINT '  6. 2_6_比赛库脚本.sql'
PRINT '  7. 2_7_练习库脚本.sql'
PRINT '=========================================='
GO
