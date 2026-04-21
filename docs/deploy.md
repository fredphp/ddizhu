# DDizhu 斗地主棋牌游戏平台 - WSL 环境部署说明

## 目录

1. [系统要求](#系统要求)
2. [部署架构说明](#部署架构说明)
3. [WSL 环境准备](#wsl-环境准备)
4. [一键部署](#一键部署)
5. [数据库配置](#数据库配置)
6. [Web服务配置](#web服务配置)
7. [游戏服务器配置](#游戏服务器配置)
8. [配置修改](#配置修改)
9. [常见问题](#常见问题)

---

## 系统要求

### 硬件要求

| 配置项 | 最低要求 | 推荐配置 |
|--------|----------|----------|
| CPU | 2核 | 4核及以上 |
| 内存 | 4GB | 8GB及以上 |
| 硬盘 | 50GB | 100GB及以上 SSD |

### 软件要求

| 软件 | 版本要求 |
|------|----------|
| Windows | Windows 10 19044+ / Windows 11 |
| WSL | WSL 2 (推荐 Ubuntu 22.04) |
| 数据库 | Microsoft SQL Server 2008 R2 及以上 (运行在 Windows 中) |
| Web服务器 | IIS 7.0 及以上 (运行在 Windows 中) |

---

## 部署架构说明

### 项目运行方式

本项目是 ASP.NET Web Forms 项目，采用以下部署架构：

```
┌─────────────────────────────────────────────────────────────┐
│                      Windows 系统                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ SQL Server  │  │    IIS      │  │   游戏服务器 .exe    │  │
│  │  (数据库)   │  │  (Web服务)  │  │  (Windows 程序)     │  │
│  └─────────────┘  └──────┬──────┘  └──────────┬──────────┘  │
│                          │                     │             │
│                          ▼                     ▼             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              WSL (Linux 子系统)                        │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │         /opt/ddizhu/                            │  │  │
│  │  │  ├── www/          (Web 文件)                   │  │  │
│  │  │  ├── server/       (游戏服务器文件)             │  │  │
│  │  │  ├── config/       (配置文件)                   │  │  │
│  │  │  └── logs/         (日志文件)                   │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  │                                                       │  │
│  │  deploy.sh, start.sh (部署和管理脚本)                 │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### 关键说明

1. **Web 文件部署在 WSL 中**：不占用 Windows C 盘空间
2. **数据库运行在 Windows 中**：SQL Server 需要 Windows 环境
3. **IIS 运行在 Windows 中**：通过 WSL 互操作访问 WSL 中的文件
4. **游戏服务器是 Windows 程序**：需要通过 Wine 或在 Windows 中运行

---

## WSL 环境准备

### 1. 安装 WSL

在 **Windows PowerShell (管理员)** 中执行：

```powershell
# 启用 WSL
wsl --install

# 或手动安装 Ubuntu
wsl --install -d Ubuntu-22.04
```

### 2. 配置 WSL

创建 `C:\Users\<用户名>\.wslconfig`：

```ini
[wsl2]
memory=4GB
processors=2
swap=2GB
```

### 3. 进入 WSL

```bash
# 打开 WSL
wsl

# 或指定发行版
wsl -d Ubuntu-22.04
```

---

## 一键部署

### 克隆项目

```bash
# 在 WSL 中
cd ~
git clone https://github.com/fredphp/ddizhu.git
cd ddizhu
```

### 执行部署脚本

```bash
# 添加执行权限
chmod +x deploy.sh start.sh

# 执行部署
./deploy.sh

# 查看部署状态
./deploy.sh --status
```

### 部署选项

| 选项 | 说明 |
|------|------|
| `--force` | 强制重新部署 |
| `--install-sql` | 在 Windows 中安装 SQL Server Express |
| `--status` | 检查部署状态 |
| `--check-db` | 检查数据库状态 |

### 部署路径

所有文件部署在 WSL 文件系统中，不占用 Windows C 盘：

```
/opt/ddizhu/
├── www/           # Web 文件
│   ├── qiantai/   # 前台网站
│   ├── HT/        # 后台管理
│   ├── admin/     # 管理员后台
│   ├── agent/     # 代理商系统
│   └── Hall/      # 游戏大厅
├── server/        # 游戏服务器文件
├── config/        # 配置脚本
│   ├── create_database.sql
│   ├── configure_iis.ps1
│   └── update_config.sh
└── logs/          # 日志文件
```

---

## 数据库配置

### 方式一：自动安装 SQL Server

```bash
# 在 WSL 中执行（需要管理员权限）
./deploy.sh --install-sql
```

此命令会：
1. 在 Windows 中安装 Chocolatey
2. 安装 SQL Server Express
3. 安装 SQL Server Management Studio

### 方式二：手动安装

1. 下载 SQL Server Express：https://www.microsoft.com/zh-cn/sql-server/sql-server-downloads
2. 运行安装程序，选择"基本"安装
3. 安装完成后，执行数据库创建脚本

### 创建数据库

```bash
# 查看数据库脚本位置
cat /opt/ddizhu/config/create_database.sql
```

在 Windows SQL Server Management Studio 中执行此脚本。

### 所需数据库（8个）

| 数据库 | 用途 |
|--------|------|
| QPGameWeb | 游戏网站数据 |
| QPPlatformDB | 平台数据 |
| QPAccountsDB | 用户账户数据 |
| QPTreasureDB | 游戏/财富数据 |
| QPRecordDB | 记录数据 |
| QPAgencyDB | 代理商数据 |
| QPOtherWebDB | 其他网站数据 |
| QPGameMatchDB | 比赛数据 |

---

## Web服务配置

### 配置 IIS 指向 WSL 文件

IIS 需要配置为访问 WSL 文件系统中的文件。

**步骤：**

1. 在 WSL 中查看配置脚本：
```bash
cat /opt/ddizhu/config/configure_iis.ps1
```

2. 将脚本复制到 Windows：
```powershell
# 在 Windows PowerShell 中
wsl -e cat /opt/ddizhu/config/configure_iis.ps1 | Out-File -FilePath C:\temp\configure_iis.ps1
```

3. 以管理员身份运行：
```powershell
powershell -ExecutionPolicy Bypass -File C:\temp\configure_iis.ps1
```

### 手动配置 IIS

如果自动脚本失败，可手动配置：

1. **打开 IIS 管理器**
2. **创建应用程序池**：
   - DDizhu_Web (.NET v4.0)
   - DDizhu_HT (.NET v4.0)
   - DDizhu_Admin (.NET v4.0)
   - DDizhu_Agent (.NET v2.0)
   - DDizhu_Hall (.NET v4.0)

3. **创建网站**，物理路径使用 WSL 路径格式：
   ```
   \\wsl$\Ubuntu\opt\ddizhu\www\qiantai
   \\wsl$\Ubuntu\opt\ddizhu\www\HT
   ...
   ```

### 访问地址

| 模块 | 地址 |
|------|------|
| 前台网站 | http://localhost |
| 后台管理 | http://localhost:8080 |
| 管理员系统 | http://localhost:8081 |
| 代理商系统 | http://localhost:8082 |
| 游戏大厅 | http://localhost:8083 |

---

## 游戏服务器配置

游戏服务器是 Windows 可执行程序，有两种运行方式：

### 方式一：在 Windows 中运行（推荐）

```powershell
# 在 Windows 中，通过文件资源管理器访问
\\wsl$\Ubuntu\opt\ddizhu\server\

# 双击运行或使用命令行
Center.exe
MTSvrLogon.exe
GameServer.exe
```

### 方式二：使用 Wine 运行

```bash
# 在 WSL 中安装 Wine
sudo apt update
sudo apt install wine64

# 运行服务器
cd /opt/ddizhu/server
wine Center.exe
wine MTSvrLogon.exe
wine GameServer.exe
```

---

## 配置修改

### 更新数据库连接

```bash
# 运行配置更新脚本
/opt/ddizhu/config/update_config.sh
```

按提示输入：
- 数据库服务器地址
- 数据库端口
- 用户名
- 密码

### 手动修改配置

配置文件位置：`/opt/ddizhu/www/*/Web.config`

```bash
# 编辑配置文件
nano /opt/ddizhu/www/qiantai/Web.config
```

数据库连接字符串格式：
```xml
<add key="DBGameWeb" value="Data Source=127.0.0.1,1433; Initial Catalog=QPGameWeb; User ID=sa; Password=your_password; Pooling=true" />
```

---

## 常见问题

### Q1: IIS 无法访问 WSL 文件

**解决方案：**
1. 确保 WSL 服务正在运行：`wsl --list --verbose`
2. 使用正确的路径格式：`\\wsl$\Ubuntu\opt\ddizhu\www\`
3. 检查文件权限：`ls -la /opt/ddizhu/www/`

### Q2: 数据库连接失败

**解决方案：**
1. 确认 SQL Server 服务已启动
2. 检查 TCP/IP 协议是否启用
3. 确认防火墙开放 1433 端口
4. 验证用户名密码

### Q3: 游戏服务器无法启动

**解决方案：**
1. 游戏服务器是 Windows 程序，需要在 Windows 中运行
2. 如需在 WSL 中运行，安装 Wine：`sudo apt install wine64`

### Q4: 磁盘空间不足

**解决方案：**
项目部署在 WSL 文件系统中，不占用 Windows C 盘。

查看磁盘空间：
```bash
df -h /opt
```

清理空间：
```bash
# 清理 apt 缓存
sudo apt clean

# 清理日志
rm -rf /opt/ddizhu/logs/*.log
```

### Q5: 如何重新部署

```bash
# 强制重新部署
./deploy.sh --force
```

---

## 快速参考

### 部署脚本

```bash
./deploy.sh              # 执行部署
./deploy.sh --status     # 检查状态
./deploy.sh --force      # 强制重新部署
./deploy.sh --install-sql # 安装 SQL Server
```

### 启动脚本

```bash
./start.sh --all         # 启动所有服务
./start.sh --web         # 启动 Web 服务
./start.sh --game        # 启动游戏服务器
./start.sh --status      # 查看状态
./start.sh --stop        # 停止所有服务
```

### 重要路径

| 用途 | 路径 |
|------|------|
| Web 文件 | /opt/ddizhu/www/ |
| 服务器文件 | /opt/ddizhu/server/ |
| 配置文件 | /opt/ddizhu/config/ |
| 日志文件 | /opt/ddizhu/logs/ |

---

*文档版本：3.0 (WSL Linux 部署版)*
*更新日期：2024年*
