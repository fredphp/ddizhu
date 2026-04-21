# DDizhu 斗地主棋牌游戏平台 - WSL 环境部署说明

## 目录

1. [系统要求](#系统要求)
2. [WSL 环境准备](#wsl-环境准备)
3. [Windows 依赖安装](#windows-依赖安装)
4. [数据库部署](#数据库部署)
5. [Web站点部署](#web站点部署)
6. [游戏服务器部署](#游戏服务器部署)
7. [配置修改](#配置修改)
8. [常见问题](#常见问题)

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
| Windows | Windows 10 19044+ / Windows 11 |
| WSL | WSL 2 (推荐) |
| 数据库 | Microsoft SQL Server 2008 R2 及以上 |
| Web服务器 | IIS 7.0 及以上 |
| .NET Framework | 3.5, 4.0, 4.5.2（多个版本并存） |

---

## WSL 环境准备

### 1. 启用 WSL

在 **Windows PowerShell (管理员)** 中执行：

```powershell
# 启用 WSL 功能
wsl --install

# 或者手动启用
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 重启电脑后，设置 WSL 2 为默认版本
wsl --set-default-version 2
```

### 2. 安装 Linux 发行版

```powershell
# 查看可用发行版
wsl --list --online

# 安装 Ubuntu (推荐)
wsl --install -d Ubuntu-22.04

# 或从 Microsoft Store 安装
```

### 3. 配置 WSL

创建或编辑 `C:\Users\你的用户名\.wslconfig`：

```ini
[wsl2]
memory=4GB
processors=2
swap=2GB
localhostForwarding=true
```

### 4. WSL 常用命令

```bash
# 进入 WSL
wsl

# 指定发行版进入
wsl -d Ubuntu-22.04

# 查看已安装的发行版
wsl -l -v

# 关闭 WSL
wsl --shutdown

# 访问 Windows 文件
cd /mnt/c/Users/你的用户名/
```

---

## Windows 依赖安装

### 1. 安装 Windows 功能 (PowerShell 管理员)

```powershell
# 安装 IIS 及 ASP.NET 支持
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature
Install-WindowsFeature -Name Web-Asp-Net45
Install-WindowsFeature -Name NET-Framework-Features

# 安装 .NET Framework 3.5
Install-WindowsFeature -Name NET-Framework-Core

# 或使用 DISM
dism /online /enable-feature /featurename:NetFx3 /all
dism /online /enable-feature /featurename:NetFx4Extended-ASPNET45 /all
dism /online /enable-feature /featurename:IIS-ASPNET45 /all
```

### 2. 安装 SQL Server

在 **Windows** 中安装 SQL Server：

1. 下载 SQL Server 安装包
2. 运行安装程序，选择"全新安装"
3. 选择功能：数据库引擎服务、SQL Server Management Studio
4. 配置实例（默认实例即可）
5. 设置身份验证模式为"混合模式"
6. 设置 sa 用户密码

### 3. 安装 VC++ 运行库 (游戏服务器需要)

在 **Windows** 中下载安装：
- Microsoft Visual C++ 2010 Redistributable
- Microsoft Visual C++ 2012 Redistributable
- Microsoft Visual C++ 2015-2022 Redistributable

---

## 数据库部署

### 1. 创建数据库

方式一：在 **Windows** 中使用 SQL Server Management Studio 执行：

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

### 2. 从 WSL 连接 SQL Server

```bash
# 安装 SQL Server 工具 (可选)
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt update
sudo apt install mssql-tools unixodbc-dev

# 测试连接
/opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P 'YourPassword'
```

---

## Web站点部署

### 1. 创建 IIS 站点 (在 Windows PowerShell 管理员中执行)

```powershell
# 定义变量
$WebPath = "C:\www\ddizhu"

# 创建目录
New-Item -ItemType Directory -Force -Path "$WebPath\qiantai"
New-Item -ItemType Directory -Force -Path "$WebPath\HT"
New-Item -ItemType Directory -Force -Path "$WebPath\admin"
New-Item -ItemType Directory -Force -Path "$WebPath\agent"
New-Item -ItemType Directory -Force -Path "$WebPath\Hall"

# 创建应用程序池
New-WebAppPool -Name "DDizhu_Web" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Web -Name "managedRuntimeVersion" -Value "v4.0"

New-WebAppPool -Name "DDizhu_HT" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_HT -Name "managedRuntimeVersion" -Value "v4.0"

New-WebAppPool -Name "DDizhu_Admin" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Admin -Name "managedRuntimeVersion" -Value "v4.0"

New-WebAppPool -Name "DDizhu_Agent" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Agent -Name "managedRuntimeVersion" -Value "v2.0"

New-WebAppPool -Name "DDizhu_Hall" -Force
Set-ItemProperty IIS:\AppPools\DDizhu_Hall -Name "managedRuntimeVersion" -Value "v4.0"

# 创建网站
New-Website -Name "DDizhu_Web" -PhysicalPath "$WebPath\qiantai" -ApplicationPool "DDizhu_Web" -Port 80
New-Website -Name "DDizhu_HT" -PhysicalPath "$WebPath\HT" -ApplicationPool "DDizhu_HT" -Port 8080
New-Website -Name "DDizhu_Admin" -PhysicalPath "$WebPath\admin" -ApplicationPool "DDizhu_Admin" -Port 8081
New-Website -Name "DDizhu_Agent" -PhysicalPath "$WebPath\agent" -ApplicationPool "DDizhu_Agent" -Port 8082
New-Website -Name "DDizhu_Hall" -PhysicalPath "$WebPath\Hall" -ApplicationPool "DDizhu_Hall" -Port 8083

# 设置权限
icacls "$WebPath" /grant "IIS_IUSRS:(OI)(CI)F" /T
icacls "$WebPath" /grant "IUSR:(OI)(CI)F" /T
```

### 2. 从 WSL 复制文件到 Windows

```bash
# 在 WSL 中执行
# 设置项目路径
PROJECT_DIR="/home/z/ddizhu-analysis"
WEB_DIR="/mnt/c/www/ddizhu"

# 复制 Web 文件
cp -r "$PROJECT_DIR/qiantai"/* "$WEB_DIR/qiantai/" 2>/dev/null || true
cp -r "$PROJECT_DIR/HT"/* "$WEB_DIR/HT/" 2>/dev/null || true
cp -r "$PROJECT_DIR/admin"/* "$WEB_DIR/admin/" 2>/dev/null || true
cp -r "$PROJECT_DIR/agent"/* "$WEB_DIR/agent/" 2>/dev/null || true
cp -r "$PROJECT_DIR/Hall"/* "$WEB_DIR/Hall/" 2>/dev/null || true
```

### 3. 从 WSL 管理 IIS

```bash
# 启动 IIS
powershell.exe -Command "Start-Service w3svc"

# 停止 IIS
powershell.exe -Command "Stop-Service w3svc"

# 重启 IIS
powershell.exe -Command "Restart-Service w3svc"

# 查看 IIS 状态
powershell.exe -Command "Get-Service w3svc"
```

---

## 游戏服务器部署

### 1. 服务器目录结构

```
C:\GameServer\
├── Center.exe           # 中心服务器
├── MTSvrLogon.exe       # 登录服务器
├── GameServer.exe       # 游戏服务器
├── ServerConfig.ini     # 服务器配置
├── ServerParameter.ini  # 数据库参数
└── *.dll               # 游戏模块DLL
```

### 2. 配置服务器参数

编辑 `C:\GameServer\ServerParameter.ini`：

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

### 3. 从 WSL 启动游戏服务器

由于游戏服务器是 Windows 可执行文件，需要通过 Windows 方式启动：

```bash
# 方式一：直接调用 Windows 可执行文件
cd /mnt/c/GameServer
./Center.exe &
sleep 5
./MTSvrLogon.exe &
sleep 5
./GameServer.exe &

# 方式二：使用 cmd.exe
cmd.exe /c "cd C:\GameServer && start Center.exe"

# 方式三：创建 Windows 批处理文件
cat > /mnt/c/GameServer/start.bat << 'EOF'
@echo off
cd /d C:\GameServer
start Center.exe
timeout /t 5
start MTSvrLogon.exe
timeout /t 5
start GameServer.exe
echo 服务器启动完成
pause
EOF
```

### 4. 配置防火墙 (PowerShell 管理员)

```powershell
# 开放数据库端口
New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow

# 开放游戏服务器端口
New-NetFirewallRule -DisplayName "Game Server" -Direction Inbound -Protocol TCP -LocalPort 7000-8000 -Action Allow

# 开放 Web 端口
New-NetFirewallRule -DisplayName "HTTP" -Direction Inbound -Protocol TCP -LocalPort 80,8080,8081,8082,8083 -Action Allow
```

---

## 配置修改

### 1. 修改前台网站配置

编辑 `C:\www\ddizhu\qiantai\Web.config`：

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

### 2. 使用 WSL 批量修改配置

```bash
# 在 WSL 中执行
WEB_DIR="/mnt/c/www/ddizhu"
DB_SERVER="127.0.0.1"
DB_USER="gameuser"
DB_PASS="YourPassword"

# 更新 qiantai 配置
sed -i "s/Data Source=[^;]*;/Data Source=$DB_SERVER;/g" "$WEB_DIR/qiantai/Web.config"
sed -i "s/User ID=[^;]*;/User ID=$DB_USER;/g" "$WEB_DIR/qiantai/Web.config"
sed -i "s/Password=[^;]*;/Password=$DB_PASS;/g" "$WEB_DIR/qiantai/Web.config"

# 更新其他模块配置
for dir in HT admin agent; do
    if [ -f "$WEB_DIR/$dir/Web.config" ]; then
        sed -i "s/Data Source=[^;]*;/Data Source=$DB_SERVER;/g" "$WEB_DIR/$dir/Web.config"
        sed -i "s/User ID=[^;]*;/User ID=$DB_USER;/g" "$WEB_DIR/$dir/Web.config"
        sed -i "s/Password=[^;]*;/Password=$DB_PASS;/g" "$WEB_DIR/$dir/Web.config"
    fi
done
```

---

## 常见问题

### Q1: WSL 无法访问 Windows 服务

**解决方案：**
```bash
# 使用 localhost 或 127.0.0.1
# WSL2 自动转发 localhost 到 Windows

# 获取 Windows 主机 IP
cat /etc/resolv.conf | grep nameserver | awk '{print $2}'
```

### Q2: 无法执行 Windows 可执行文件

**解决方案：**
```bash
# 确认 WSL 互操作性已启用
cat /etc/wsl.conf

# 如果没有，添加以下内容
sudo tee -a /etc/wsl.conf << EOF
[interop]
enabled = true
appendWindowsPath = true
EOF

# 重启 WSL (在 PowerShell 中)
wsl --shutdown
```

### Q3: 访问网站提示 500 错误

**解决方案：**
1. 检查应用程序池是否启动
2. 检查 .NET Framework 版本是否正确
3. 查看 IIS 日志定位具体错误

### Q4: 数据库连接失败

**解决方案：**
1. 确认 SQL Server 服务已启动
2. 检查 SQL Server 配置管理器中 TCP/IP 是否启用
3. 确认防火墙已开放 1433 端口
4. 验证数据库用户名密码是否正确

### Q5: 游戏服务器无法启动

**解决方案：**
1. 确认已安装 VC++ 运行库
2. 检查数据库连接配置是否正确
3. 确认端口未被占用

### Q6: 文件权限问题

**解决方案：**
```bash
# 在 Windows 中设置权限 (PowerShell 管理员)
$path = "C:\www\ddizhu"
icacls "$path" /grant "IIS_IUSRS:(OI)(CI)F" /T
icacls "$path" /grant "IUSR:(OI)(CI)F" /T

# WSL 中设置文件权限
chmod -R 755 /mnt/c/www/ddizhu
```

---

## 访问地址

| 模块 | 地址 | 默认页面 |
|------|------|----------|
| 前台网站 | http://localhost/ | index.aspx |
| 后台管理 | http://localhost:8080/ | Login.aspx |
| 管理员系统 | http://localhost:8081/ | Login.aspx |
| 代理商系统 | http://localhost:8082/ | Login.aspx |
| 游戏大厅 | http://localhost:8083/ | home.html |

---

## 安全建议

1. **修改默认密码**：部署后立即修改所有默认账户密码
2. **启用 HTTPS**：配置 SSL 证书，使用 HTTPS 加密传输
3. **数据库安全**：使用强密码，限制数据库远程访问
4. **防火墙配置**：只开放必要的端口
5. **定期备份**：设置数据库自动备份计划
6. **日志监控**：启用 IIS 日志和数据库审计

---

## WSL 常用路径对照表

| Windows 路径 | WSL 路径 |
|-------------|----------|
| C:\ | /mnt/c/ |
| C:\Users\用户名 | /mnt/c/Users/用户名 |
| C:\www | /mnt/c/www |
| C:\GameServer | /mnt/c/GameServer |

---

*文档版本：2.0 (WSL 适配版)*
*更新日期：2024年*
