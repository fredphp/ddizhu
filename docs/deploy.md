# DDizhu 斗地主棋牌游戏平台 - 环境部署说明

## 目录

1. [系统要求](#系统要求)
2. [环境准备](#环境准备)
3. [数据库部署](#数据库部署)
4. [Web站点部署](#web站点部署)
5. [游戏服务器部署](#游戏服务器部署)
6. [配置修改](#配置修改)
7. [常见问题](#常见问题)

---

## 系统要求

### 硬件要求

| 配置项 | 最低要求 | 推荐配置 |
|--------|----------|----------|
| CPU | 2核 | 4核及以上 |
| 内存 | 4GB | 8GB及以上 |
| 硬盘 | 50GB | 100GB及以上 SSD |
| 网络 | 100Mbps | 1000Mbps |

### 软件要求

| 软件 | 版本要求 |
|------|----------|
| 操作系统 | Windows Server 2008 R2 / 2012 / 2016 / 2019 |
| 数据库 | Microsoft SQL Server 2008 R2 及以上 |
| Web服务器 | IIS 7.0 及以上 |
| .NET Framework | 3.5, 4.0, 4.5.2（多个版本并存） |

---

## 环境准备

### 1. 安装 Windows 功能

以管理员身份运行 PowerShell：

```powershell
# 安装 IIS 及 ASP.NET 支持
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature
Install-WindowsFeature -Name Web-Asp-Net45
Install-WindowsFeature -Name NET-Framework-Features

# 安装 .NET Framework 3.5
Install-WindowsFeature -Name NET-Framework-Core
```

### 2. 安装 SQL Server

1. 下载 SQL Server 安装包
2. 运行安装程序，选择"全新安装"
3. 选择功能：数据库引擎服务、SQL Server Management Studio
4. 配置实例（默认实例即可）
5. 设置身份验证模式为"混合模式"
6. 设置 sa 用户密码

### 3. 安装其他依赖

```powershell
# 启用 Windows 功能
dism /online /enable-feature /featurename:NetFx3 /all
dism /online /enable-feature /featurename:NetFx4Extended-ASPNET45 /all
dism /online /enable-feature /featurename:IIS-ASPNET45 /all
```

---

## 数据库部署

### 1. 创建数据库

打开 SQL Server Management Studio，执行以下脚本：

```sql
-- 创建所有数据库
CREATE DATABASE QPGameWeb;
CREATE DATABASE QPPlatformDB;
CREATE DATABASE QPAccountsDB;
CREATE DATABASE QPTreasureDB;
CREATE DATABASE QPRecordDB;
CREATE DATABASE QPAgencyDB;
CREATE DATABASE QPOtherWebDB;
CREATE DATABASE QPGameMatchDB;
GO

-- 创建数据库用户
CREATE LOGIN gameuser WITH PASSWORD = 'YourStrongPassword123!';
GO

-- 授权
USE QPGameWeb;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPPlatformDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPAccountsDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPTreasureDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPRecordDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPAgencyDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPOtherWebDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO

USE QPGameMatchDB;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
GO
```

### 2. 导入数据库结构

如果有数据库备份文件或脚本，执行导入：

```sql
-- 从备份恢复
RESTORE DATABASE QPGameWeb FROM DISK = 'C:\backup\QPGameWeb.bak' WITH REPLACE;
-- 其他数据库类似...
```

---

## Web站点部署

### 1. 创建 IIS 站点

使用 PowerShell 或 IIS 管理器创建站点：

```powershell
# 创建应用程序池
New-WebAppPool -Name "DDizhu_Web" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Web -Name "managedRuntimeVersion" -Value "v4.0"

New-WebAppPool -Name "DDizhu_Admin" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Admin -Name "managedRuntimeVersion" -Value "v4.0"

New-WebAppPool -Name "DDizhu_Agent" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Agent -Name "managedRuntimeVersion" -Value "v2.0"

New-WebAppPool -Name "DDizhu_Hall" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Hall -Name "managedRuntimeVersion" -Value "v4.0"
```

### 2. 创建网站

```powershell
# 前台网站
New-Website -Name "DDizhu_Web" -PhysicalPath "D:\www\ddizhu\qiantai" -ApplicationPool "DDizhu_Web" -Port 80

# 后台管理
New-Website -Name "DDizhu_Admin" -PhysicalPath "D:\www\ddizhu\HT" -ApplicationPool "DDizhu_Admin" -Port 8080

# 代理商系统
New-Website -Name "DDizhu_Agent" -PhysicalPath "D:\www\ddizhu\agent" -ApplicationPool "DDizhu_Agent" -Port 8081

# 游戏大厅
New-Website -Name "DDizhu_Hall" -PhysicalPath "D:\www\ddizhu\Hall" -ApplicationPool "DDizhu_Hall" -Port 8082
```

### 3. 配置应用程序池

| 应用程序池 | .NET CLR 版本 | 托管管道模式 |
|-----------|---------------|--------------|
| DDizhu_Web | v4.0 | 集成 |
| DDizhu_Admin | v4.0 | 集成 |
| DDizhu_Agent | v2.0 | 集成 |
| DDizhu_Hall | v4.0 | 集成 |

### 4. 设置目录权限

```powershell
# 设置 IIS_IUSRS 权限
$path = "D:\www\ddizhu"
icacls "$path" /grant "IIS_IUSRS:(OI)(CI)F" /T
icacls "$path" /grant "IUSR:(OI)(CI)F" /T

# 设置上传目录写入权限
icacls "$path\qiantai\upload" /grant "IIS_IUSRS:(OI)(CI)M" /T
icacls "$path\HT\TempImages" /grant "IIS_IUSRS:(OI)(CI)M" /T
```

---

## 游戏服务器部署

### 1. 服务器目录结构

```
D:\GameServer\
├── Center.exe           # 中心服务器
├── MTSvrLogon.exe       # 登录服务器
├── GameServer.exe       # 游戏服务器
├── ServerConfig.ini     # 服务器配置
├── ServerParameter.ini  # 数据库参数
└── *.dll               # 游戏模块DLL
```

### 2. 配置服务器参数

编辑 `ServerParameter.ini`：

```ini
[PlatformDB]
DBPort=1433
DBAddr=127.0.0.1
DBUser=gameuser
DBPass=YourPassword
DBName=QPPlatformDB

[TreasureDB]
DBPort=1433
DBAddr=127.0.0.1
DBUser=gameuser
DBPass=YourPassword
DBName=QPTreasureDB

[AccountsDB]
DBPort=1433
DBAddr=127.0.0.1
DBUser=gameuser
DBPass=YourPassword
DBName=QPAccountsDB
```

### 3. 配置防火墙

```powershell
# 开放数据库端口
New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow

# 开放游戏服务器端口
New-NetFirewallRule -DisplayName "Game Server" -Direction Inbound -Protocol TCP -LocalPort 7000-8000 -Action Allow
```

### 4. 启动服务器

```batch
:: 按顺序启动
cd D:\GameServer
start Center.exe
timeout /t 5
start MTSvrLogon.exe
timeout /t 5
start GameServer.exe
```

---

## 配置修改

### 1. 修改前台网站配置

编辑 `qiantai/Web.config`：

```xml
<appSettings>
  <add key="DBGameWeb" value="Data Source=YOUR_SERVER; Initial Catalog=QPGameWeb; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBPlatform" value="Data Source=YOUR_SERVER; Initial Catalog=QPPlatformDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBAccounts" value="Data Source=YOUR_SERVER; Initial Catalog=QPAccountsDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBTreasure" value="Data Source=YOUR_SERVER; Initial Catalog=QPTreasureDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBRecord" value="Data Source=YOUR_SERVER; Initial Catalog=QPRecordDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBAgency" value="Data Source=YOUR_SERVER; Initial Catalog=QPAgencyDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
</appSettings>
```

### 2. 修改后台管理配置

编辑 `HT/Web.config`：

```xml
<appSettings>
  <add key="DBGameWeb" value="Data Source=YOUR_SERVER; Initial Catalog=QPGameWeb; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBPlatform" value="Data Source=YOUR_SERVER; Initial Catalog=QPPlatformDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBAccounts" value="Data Source=YOUR_SERVER; Initial Catalog=QPAccountsDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBTreasure" value="Data Source=YOUR_SERVER; Initial Catalog=QPTreasureDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBRecord" value="Data Source=YOUR_SERVER; Initial Catalog=QPRecordDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBAgency" value="Data Source=YOUR_SERVER; Initial Catalog=QPAgencyDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBOtherWeb" value="Data Source=YOUR_SERVER; Initial Catalog=QPOtherWebDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBGameMatch" value="Data Source=YOUR_SERVER; Initial Catalog=QPGameMatchDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
</appSettings>
```

### 3. 修改代理商系统配置

编辑 `agent/Web.config`：

```xml
<appSettings>
  <add key="DBGameWeb" value="Data Source=YOUR_SERVER; Initial Catalog=QPGameWeb; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBPlatform" value="Data Source=YOUR_SERVER; Initial Catalog=QPPlatformDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBAccounts" value="Data Source=YOUR_SERVER; Initial Catalog=QPAccountsDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBTreasure" value="Data Source=YOUR_SERVER; Initial Catalog=QPTreasureDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBRecord" value="Data Source=YOUR_SERVER; Initial Catalog=QPRecordDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
  <add key="DBAgency" value="Data Source=YOUR_SERVER; Initial Catalog=QPAgencyDB; User ID=gameuser; Password=YOUR_PASSWORD; Pooling=true" />
</appSettings>
```

---

## 常见问题

### Q1: 访问网站提示 500 错误

**解决方案：**
1. 检查应用程序池是否启动
2. 检查 .NET Framework 版本是否正确
3. 查看 IIS 日志定位具体错误

### Q2: 数据库连接失败

**解决方案：**
1. 确认 SQL Server 服务已启动
2. 检查 SQL Server 配置管理器中 TCP/IP 是否启用
3. 确认防火墙已开放 1433 端口
4. 验证数据库用户名密码是否正确

### Q3: 游戏服务器无法启动

**解决方案：**
1. 确认已安装 VC++ 运行库
2. 检查数据库连接配置是否正确
3. 确认端口未被占用

### Q4: 图片/上传文件无法显示

**解决方案：**
1. 检查目录权限是否正确
2. 确认 IIS_IUSRS 有读取权限

---

## 访问地址

| 模块 | 地址 | 默认页面 |
|------|------|----------|
| 前台网站 | http://your-domain/ | index.aspx |
| 后台管理 | http://your-domain:8080/ | Login.aspx |
| 代理商系统 | http://your-domain:8081/ | Login.aspx |
| 游戏大厅 | http://your-domain:8082/ | home.html |

---

## 安全建议

1. **修改默认密码**：部署后立即修改所有默认账户密码
2. **启用 HTTPS**：配置 SSL 证书，使用 HTTPS 加密传输
3. **数据库安全**：使用强密码，限制数据库远程访问
4. **防火墙配置**：只开放必要的端口
5. **定期备份**：设置数据库自动备份计划
6. **日志监控**：启用 IIS 日志和数据库审计

---

*文档版本：1.0*
*更新日期：2024年*
