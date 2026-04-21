# DDizhu - 斗地主棋牌游戏平台

## 项目简介

这是一个完整的网络棋牌游戏平台系统，包含多种游戏（斗地主、炸金花、牛牛、捕鱼等），提供前台网站、后台管理、代理商系统、游戏大厅和游戏服务器等完整功能模块。

## 项目结构

```
ddizhu/
├── qiantai/          # 前台网站（用户端）
├── HT/               # 后台管理系统
├── admin/            # 管理员后台
├── agent/            # 代理商系统
├── Hall/             # 游戏大厅
├── server/           # 游戏服务器
├── roll/             # 轮播图/活动页面
└── README.md
```

## 各模块详细说明

### 1. qiantai（前台网站）

用户访问的前台网站，提供以下功能：
- 用户注册/登录
- 游戏列表展示
- 充值/提现功能
- 活动页面
- 客服中心
- 用户个人中心

**技术栈：**
- ASP.NET Web Forms (.NET Framework 4.5.2)
- HTML/CSS/JavaScript
- jQuery
- 易宝支付、IPS支付接口

**主要文件：**
- `Register.aspx` - 用户注册
- `GameList.aspx` - 游戏列表
- `GameIndex.aspx` - 游戏首页
- `IpsPay/` - 支付接口
- `UserService/` - 用户服务相关页面

### 2. HT（后台管理系统）

游戏运营管理后台，提供以下功能：
- 账户管理
- 游戏管理
- 充值/提现管理
- 代理商管理
- 比赛管理
- 数据统计
- 系统设置

**技术栈：**
- ASP.NET Web Forms (.NET Framework 4.0)
- Chart 数据可视化
- lhgdialog 弹窗组件
- KindEditor 富文本编辑器

**主要模块：**
- `Module/AccountManager/` - 账户管理
- `Module/FilledManager/` - 充值管理
- `Module/AgencyManager/` - 代理商管理
- `Module/MatchManager/` - 比赛管理
- `Module/AppManager/` - 游戏应用管理
- `Module/WebManager/` - 网站内容管理
- `Module/StatManager/` - 数据统计

**核心DLL：**
- `Game.Entity.dll` - 实体类
- `Game.Kernel.dll` - 核心功能
- `Game.Facade.dll` - 外观层
- `Game.Data.dll` - 数据访问层
- `Game.IData.dll` - 数据接口层
- `Game.Utils.dll` - 工具类

### 3. admin（管理员后台）

简化的管理员登录入口，提供基础管理功能。

**技术栈：**
- ASP.NET Web Forms
- .NET Framework 3.5

### 4. agent（代理商系统）

代理商管理平台，提供以下功能：
- 代理商登录
- 玩家管理
- 充值记录
- 佣金结算
- 收益统计

**技术栈：**
- ASP.NET Web Forms (.NET Framework 3.5)
- jQuery
- artDialog 弹窗
- xhEditor 编辑器

**主要模块：**
- `Manage/Agent/` - 代理商管理
- `Manage/Player/` - 玩家管理
- `Manage/Money/` - 财务管理
- `Manage/Notice/` - 公告管理

### 5. Hall（游戏大厅）

游戏大厅网页端，提供：
- 用户中心
- 充值/提现
- 活动中心
- 推广页面
- 移动端适配（mobile/）

**技术栈：**
- HTML5/CSS3/JavaScript
- jQuery
- AmazeUI（移动端UI框架）
- Layer 弹层组件

**特点：**
- 响应式设计
- 支持PC和移动端
- WebSocket 服务（WS/）

### 6. server（游戏服务器）

游戏服务端程序，包含：
- 游戏服务器（GameServer.exe）
- 中心服务器（Center.exe）
- 登录服务器（MTSvrLogon.exe）
- 各游戏模块

**支持的游戏：**
| 游戏 | DLL文件 | 配置文件 |
|------|---------|----------|
| 炸金花 | ZaJinHuaServer.dll | ZaJinHuaConfig_*.ini |
| 斗地主 | LandServer.dll | LandServerConfig.ini |
| 牛牛 | OxNewServer.dll | OxNewConfig_*.ini |
| 捕鱼 | LKpyServer.dll | LKpyConfig_*.xml |
| 百家乐 | BaccaratNewServer.dll | BaccaratNewConfig_*.ini |
| 五星宏辉 | fivestarserver.dll | FiveStar_*.ini |
| 赛车 | HorseBattleServer.dll | HorseBattle.ini |
| 动物大战 | AnimalBattleServer.dll | BirdsAnimalsConfig_*.ini |
| 碰碰车 | BumperCarBattleServer.dll | BumperCarBattle_*.ini |
| 28杠 | 28GangBattleServer.dll | 28GangBattleConfig_*.ini |
| 水浒传 | shz2_server.dll | shz2_config_*.xml |
| 麻将 | SparrowERServer.dll | SparrowERConfig_*.ini |

**服务器配置：**
- `ServerConfig.ini` - 服务器基本配置
- `ServerParameter.ini` - 数据库连接参数（加密）
- `Validate.ini` - 验证配置

## 开发语言

| 层级 | 语言/技术 |
|------|-----------|
| 后端 | C# (ASP.NET Web Forms) |
| 前端 | HTML, CSS, JavaScript |
| 脚本 | jQuery,各种JS插件 |
| 数据库 | T-SQL |
| 服务端 | C++ (Windows DLL/EXE) |

## 项目配置

### .NET Framework 版本

| 模块 | 版本 |
|------|------|
| qiantai | .NET Framework 4.5.2 |
| HT | .NET Framework 4.0 |
| admin | .NET Framework 3.5 |
| agent | .NET Framework 3.5 |

### 数据库配置

系统使用 **Microsoft SQL Server** 数据库，包含以下数据库：

| 数据库名 | 用途 |
|----------|------|
| QPGameWeb | 游戏网站数据 |
| QPPlatformDB | 平台数据 |
| QPAccountsDB | 用户账户数据 |
| QPTreasureDB | 游戏/财富数据 |
| QPRecordDB | 记录数据 |
| QPAgencyDB | 代理商数据 |
| QPOtherWebDB | 其他网站数据 |
| QPGameMatchDB | 比赛数据 |

### 数据库连接字符串示例

```xml
<add key="DBGameWeb" value="Data Source=127.0.0.1,1433; Initial Catalog=QPGameWeb; User ID=sa; Password=your_password; Pooling=true" />
<add key="DBPlatform" value="Data Source=127.0.0.1,1433; Initial Catalog=QPPlatformDB; User ID=sa; Password=your_password; Pooling=true" />
<add key="DBAccounts" value="Data Source=127.0.0.1,1433; Initial Catalog=QPAccountsDB; User ID=sa; Password=your_password; Pooling=true" />
<add key="DBTreasure" value="Data Source=127.0.0.1,1433; Initial Catalog=QPTreasureDB; User ID=sa; Password=your_password; Pooling=true" />
<add key="DBRecord" value="Data Source=127.0.0.1,1433; Initial Catalog=QPRecordDB; User ID=sa; Password=your_password; Pooling=true" />
<add key="DBAgency" value="Data Source=127.0.0.1,1433; Initial Catalog=QPAgencyDB; User ID=sa; Password=your_password; Pooling=true" />
```

## 项目启动

### 环境要求

1. **操作系统**：Windows Server 2008/2012/2016 或 Windows 7/10
2. **Web服务器**：IIS 7.0 及以上
3. **数据库**：Microsoft SQL Server 2008 R2 及以上
4. **.NET Framework**：3.5 / 4.0 / 4.5.2（根据模块需求）

### 部署步骤

#### 1. 数据库配置

```sql
-- 创建数据库
CREATE DATABASE QPGameWeb;
CREATE DATABASE QPPlatformDB;
CREATE DATABASE QPAccountsDB;
CREATE DATABASE QPTreasureDB;
CREATE DATABASE QPRecordDB;
CREATE DATABASE QPAgencyDB;
CREATE DATABASE QPOtherWebDB;
CREATE DATABASE QPGameMatchDB;

-- 创建数据库用户并授权
CREATE LOGIN gameuser WITH PASSWORD = 'your_password';
-- 对每个数据库执行
USE QPGameWeb;
CREATE USER gameuser FOR LOGIN gameuser;
ALTER ROLE db_owner ADD MEMBER gameuser;
```

#### 2. IIS 配置

1. 安装 IIS 并启用 ASP.NET 支持
2. 创建网站应用程序池（.NET CLR 版本根据模块选择）
3. 部署各网站目录：
   - qiantai → 主网站
   - HT → 后台管理
   - admin → 管理员后台
   - agent → 代理商系统
   - Hall → 游戏大厅

4. 修改各目录下 `Web.config` 中的数据库连接字符串

#### 3. 游戏服务器配置

1. 修改 `server/ServerParameter.ini` 中的数据库连接信息
2. 配置各游戏模块的 `.ini` 文件
3. 启动服务器：
   ```
   # 先启动中心服务器
   Center.exe
   
   # 再启动登录服务器
   MTSvrLogon.exe
   
   # 最后启动游戏服务器
   GameServer.exe
   ```

4. 或使用 `AutoStart.exe` 一键启动所有服务

### 访问地址

| 模块 | 默认页面 |
|------|----------|
| 前台网站 | index.aspx |
| 后台管理 | Login.aspx |
| 管理员后台 | Login.aspx |
| 代理商系统 | Login.aspx |
| 游戏大厅 | home.html |

## 第三方组件

| 组件 | 用途 |
|------|------|
| AspNetPager | 分页控件 |
| Newtonsoft.Json | JSON处理 |
| LitJSON | JSON处理 |
| QRCoder | 二维码生成 |
| jQuery | 前端脚本库 |
| KindEditor | 富文本编辑器 |
| lhgdialog | 弹窗组件 |
| artDialog | 弹窗组件 |
| AmazeUI | 移动端UI框架 |
| Layer | 弹层组件 |
| My97DatePicker | 日期选择器 |
| xhEditor | 富文本编辑器 |

## 支付接口

系统集成的支付接口：
- 易宝支付（Yeepay）
- IPS支付
- 优卡支付
- 银联支付

## 目录权限

确保以下目录有写入权限：
- `upload/` - 上传文件目录
- `TempImages/` - 临时图片目录
- `gamepic/` - 游戏图片目录

## 注意事项

1. 本项目为预编译项目，源代码已编译为 DLL 文件
2. 数据库连接密码在配置文件中已加密存储
3. 游戏服务器仅支持 Windows 平台
4. 生产环境请修改所有默认密码
5. 建议使用 HTTPS 保护数据传输安全

## 许可证

版权所有 © 猫推科技 - http://www.maotui.cn

---

*本文档由项目代码分析自动生成*
