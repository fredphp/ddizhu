#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 一键部署脚本 (WSL 版本)
# 适用系统：Windows WSL (Windows Subsystem for Linux)
# 使用方法：./deploy.sh [--force]
# 选项：
#   --force    强制重新部署，覆盖已存在的文件
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置变量（请根据实际情况修改）
DB_SERVER="127.0.0.1"
DB_PORT="1433"
DB_USER="gameuser"
DB_PASSWORD="YourStrongPassword123!"

# WSL 路径 (使用 /mnt/c/ 格式)
INSTALL_DIR="/mnt/c/GameServer"
WEB_DIR="/mnt/c/www/ddizhu"

# 项目目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 强制模式
FORCE_MODE=false

# 打印函数
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_skip() {
    echo -e "${CYAN}[SKIP]${NC} $1"
}

# 检查 WSL 环境
check_wsl() {
    print_info "检查 WSL 环境..."
    
    if [[ ! -f /proc/version ]]; then
        print_error "此脚本需要在 WSL 环境中运行"
        exit 1
    fi
    
    if ! grep -qi "microsoft" /proc/version; then
        print_error "此脚本需要在 WSL 环境中运行"
        exit 1
    fi
    
    print_success "WSL 环境检测通过"
    
    # 检查互操作性
    if ! command -v powershell.exe &> /dev/null; then
        print_warning "Windows 互操作性未启用，部分功能可能受限"
    else
        print_success "Windows 互操作性已启用"
    fi
}

# 检查目录是否已存在
check_directories_exist() {
    [[ -d "$INSTALL_DIR" && -d "$WEB_DIR/qiantai" && -d "$WEB_DIR/HT" && -d "$WEB_DIR/admin" && -d "$WEB_DIR/agent" && -d "$WEB_DIR/Hall" ]]
}

# 检查文件是否已复制
check_files_copied() {
    local has_files=true
    
    # 检查关键文件是否存在
    [[ -f "$WEB_DIR/qiantai/Web.config" ]] || has_files=false
    [[ -f "$WEB_DIR/HT/Web.config" ]] || has_files=false
    [[ -f "$WEB_DIR/agent/Web.config" ]] || has_files=false
    
    $has_files
}

# 检查脚本是否已生成
check_scripts_generated() {
    [[ -f "$INSTALL_DIR/create_database.sql" && -f "$INSTALL_DIR/configure_iis.ps1" && -f "$INSTALL_DIR/update_config.ps1" ]]
}

# 检查 IIS 站点是否已配置
check_iis_configured() {
    if command -v powershell.exe &> /dev/null; then
        local result=$(powershell.exe -Command "(Get-Website -Name 'DDizhu_Web' -ErrorAction SilentlyContinue).Name" 2>/dev/null | tr -d '\r\n')
        [[ -n "$result" ]]
    else
        false
    fi
}

# 创建目录结构
create_directories() {
    if check_directories_exist && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "目录已存在，跳过创建"
        return
    fi
    
    print_info "创建目录结构..."
    
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$INSTALL_DIR/logs"
    mkdir -p "$INSTALL_DIR/pids"
    mkdir -p "$WEB_DIR"
    mkdir -p "$WEB_DIR/qiantai"
    mkdir -p "$WEB_DIR/HT"
    mkdir -p "$WEB_DIR/admin"
    mkdir -p "$WEB_DIR/agent"
    mkdir -p "$WEB_DIR/Hall"
    
    print_success "目录创建完成"
    print_info "Windows 路径: C:\\GameServer"
    print_info "Windows 路径: C:\\www\\ddizhu"
}

# 复制文件
copy_files() {
    if check_files_copied && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "项目文件已存在，跳过复制 (使用 --force 强制覆盖)"
        return
    fi
    
    print_info "复制项目文件..."
    
    local copied_count=0
    
    # 复制 Web 文件
    if [[ -d "$SCRIPT_DIR/qiantai" ]]; then
        cp -r "$SCRIPT_DIR/qiantai"/* "$WEB_DIR/qiantai/" 2>/dev/null || true
        print_success "已复制: qiantai"
        ((copied_count++))
    fi
    
    if [[ -d "$SCRIPT_DIR/HT" ]]; then
        cp -r "$SCRIPT_DIR/HT"/* "$WEB_DIR/HT/" 2>/dev/null || true
        print_success "已复制: HT"
        ((copied_count++))
    fi
    
    if [[ -d "$SCRIPT_DIR/admin" ]]; then
        cp -r "$SCRIPT_DIR/admin"/* "$WEB_DIR/admin/" 2>/dev/null || true
        print_success "已复制: admin"
        ((copied_count++))
    fi
    
    if [[ -d "$SCRIPT_DIR/agent" ]]; then
        cp -r "$SCRIPT_DIR/agent"/* "$WEB_DIR/agent/" 2>/dev/null || true
        print_success "已复制: agent"
        ((copied_count++))
    fi
    
    if [[ -d "$SCRIPT_DIR/Hall" ]]; then
        cp -r "$SCRIPT_DIR/Hall"/* "$WEB_DIR/Hall/" 2>/dev/null || true
        print_success "已复制: Hall"
        ((copied_count++))
    fi
    
    # 复制游戏服务器文件
    if [[ -d "$SCRIPT_DIR/server" ]]; then
        cp -r "$SCRIPT_DIR/server"/* "$INSTALL_DIR/" 2>/dev/null || true
        print_success "已复制: server"
        ((copied_count++))
    fi
    
    if [[ $copied_count -eq 0 ]]; then
        print_warning "没有文件需要复制"
    else
        print_success "文件复制完成 ($copied_count 个目录)"
    fi
}

# 生成数据库创建脚本
generate_db_script() {
    if [[ -f "$INSTALL_DIR/create_database.sql" ]] && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "数据库脚本已存在，跳过生成"
        return
    fi
    
    print_info "生成数据库脚本..."
    
    cat > "$INSTALL_DIR/create_database.sql" << 'EOF'
-- DDizhu 数据库创建脚本
-- 请在 SQL Server Management Studio 中执行
-- 如果数据库已存在，脚本会跳过创建

-- 检查并创建数据库
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPGameWeb') CREATE DATABASE QPGameWeb;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPPlatformDB') CREATE DATABASE QPPlatformDB;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPAccountsDB') CREATE DATABASE QPAccountsDB;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPTreasureDB') CREATE DATABASE QPTreasureDB;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPRecordDB') CREATE DATABASE QPRecordDB;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPAgencyDB') CREATE DATABASE QPAgencyDB;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPOtherWebDB') CREATE DATABASE QPOtherWebDB;
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QPGameMatchDB') CREATE DATABASE QPGameMatchDB;
GO

-- 检查并创建登录用户
IF NOT EXISTS (SELECT loginname FROM master.dbo.syslogins WHERE name = 'gameuser')
BEGIN
    CREATE LOGIN gameuser WITH PASSWORD = 'YourStrongPassword123!';
END
GO

-- 授权 (每个数据库)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPGameWeb')
BEGIN
    USE QPGameWeb;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPPlatformDB')
BEGIN
    USE QPPlatformDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPAccountsDB')
BEGIN
    USE QPAccountsDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPTreasureDB')
BEGIN
    USE QPTreasureDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPRecordDB')
BEGIN
    USE QPRecordDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPAgencyDB')
BEGIN
    USE QPAgencyDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPOtherWebDB')
BEGIN
    USE QPOtherWebDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QPGameMatchDB')
BEGIN
    USE QPGameMatchDB;
    IF NOT EXISTS (SELECT name FROM sysusers WHERE name = 'gameuser')
    BEGIN
        CREATE USER gameuser FOR LOGIN gameuser;
        ALTER ROLE db_owner ADD MEMBER gameuser;
    END
END
GO

PRINT '数据库脚本执行完成！';
EOF
    
    print_success "数据库脚本已生成: C:\\GameServer\\create_database.sql"
}

# 生成 IIS 配置脚本
generate_iis_script() {
    if [[ -f "$INSTALL_DIR/configure_iis.ps1" ]] && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "IIS 配置脚本已存在，跳过生成"
        return
    fi
    
    print_info "生成 IIS 配置脚本..."
    
    cat > "$INSTALL_DIR/configure_iis.ps1" << 'EOF'
# DDizhu IIS 配置脚本
# 请以管理员身份运行 PowerShell 执行此脚本
# 支持重复执行，不会重复创建已存在的资源

param(
    [string]$WebPath = "C:\www\ddizhu"
)

Write-Host "配置 IIS 站点..." -ForegroundColor Green

# 创建应用程序池（如果不存在）
$appPools = @(
    @{Name="DDizhu_Web"; Version="v4.0"},
    @{Name="DDizhu_HT"; Version="v4.0"},
    @{Name="DDizhu_Admin"; Version="v4.0"},
    @{Name="DDizhu_Agent"; Version="v2.0"},
    @{Name="DDizhu_Hall"; Version="v4.0"}
)

foreach ($pool in $appPools) {
    if (Get-WebAppPool -Name $pool.Name -ErrorAction SilentlyContinue) {
        Write-Host "应用程序池已存在: $($pool.Name)" -ForegroundColor DarkGray
    } else {
        New-WebAppPool -Name $pool.Name -Force
        Set-ItemProperty "IIS:\AppPools\$($pool.Name)" -Name "managedRuntimeVersion" -Value $pool.Version
        Write-Host "创建应用程序池: $($pool.Name)" -ForegroundColor Cyan
    }
}

# 创建网站（如果不存在）
$sites = @(
    @{Name="DDizhu_Web"; Path="qiantai"; Port=80},
    @{Name="DDizhu_HT"; Path="HT"; Port=8080},
    @{Name="DDizhu_Admin"; Path="admin"; Port=8081},
    @{Name="DDizhu_Agent"; Path="agent"; Port=8082},
    @{Name="DDizhu_Hall"; Path="Hall"; Port=8083}
)

foreach ($site in $sites) {
    $physicalPath = Join-Path $WebPath $site.Path
    if (Get-Website -Name $site.Name -ErrorAction SilentlyContinue) {
        Write-Host "网站已存在: $($site.Name)" -ForegroundColor DarkGray
    } else {
        New-Website -Name $site.Name -PhysicalPath $physicalPath -ApplicationPool $site.Name -Port $site.Port
        Write-Host "创建网站: $($site.Name) (端口: $($site.Port))" -ForegroundColor Cyan
    }
}

# 设置权限
Write-Host "设置目录权限..." -ForegroundColor Green
icacls "$WebPath" /grant "IIS_IUSRS:(OI)(CI)F" /T 2>$null
icacls "$WebPath" /grant "IUSR:(OI)(CI)F" /T 2>$null

# 启动 IIS
Start-Service w3svc -ErrorAction SilentlyContinue

Write-Host "IIS 配置完成！" -ForegroundColor Green
EOF
    
    print_success "IIS 配置脚本已生成: C:\\GameServer\\configure_iis.ps1"
}

# 生成配置文件更新脚本
generate_config_script() {
    if [[ -f "$INSTALL_DIR/update_config.ps1" ]] && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "配置更新脚本已存在，跳过生成"
        return
    fi
    
    print_info "生成配置更新脚本..."
    
    cat > "$INSTALL_DIR/update_config.ps1" << 'EOF'
# 配置文件更新脚本
# 请以管理员身份运行
# 支持重复执行

param(
    [string]$WebPath = "C:\www\ddizhu",
    [string]$DbServer = "127.0.0.1",
    [string]$DbUser = "gameuser",
    [string]$DbPassword = "YourStrongPassword123!"
)

Write-Host "更新配置文件..." -ForegroundColor Green

# 数据库连接字符串模板
$connectionTemplate = "Data Source=$DbServer; Initial Catalog={DB_NAME}; User ID=$DbUser; Password=$DbPassword; Pooling=true"

# 需要更新的配置
$configs = @(
    @{File="qiantai\Web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB")},
    @{File="HT\Web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB", "QPOtherWebDB", "QPGameMatchDB")},
    @{File="agent\Web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB")},
    @{File="admin\web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB")}
)

foreach ($config in $configs) {
    $filePath = Join-Path $WebPath $config.File
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw
        
        # 更新数据库连接
        $dbMappings = @{
            "QPGameWeb" = "DBGameWeb"
            "QPPlatformDB" = "DBPlatform"
            "QPAccountsDB" = "DBAccounts"
            "QPTreasureDB" = "DBTreasure"
            "QPRecordDB" = "DBRecord"
            "QPAgencyDB" = "DBAgency"
            "QPOtherWebDB" = "DBOtherWeb"
            "QPGameMatchDB" = "DBGameMatch"
        }
        
        foreach ($db in $config.DBs) {
            $key = $dbMappings[$db]
            $connectionString = $connectionTemplate -replace "{DB_NAME}", $db
            $pattern = "(<add key=`"$key`" value=`")[^`"]*(`" />)"
            $replacement = "`${1}$connectionString`${2}"
            $content = $content -replace $pattern, $replacement
        }
        
        Set-Content -Path $filePath -Value $content -Encoding UTF8
        Write-Host "已更新: $($config.File)" -ForegroundColor Cyan
    } else {
        Write-Host "文件不存在: $($config.File)" -ForegroundColor DarkGray
    }
}

Write-Host "配置文件更新完成！" -ForegroundColor Green
EOF
    
    print_success "配置更新脚本已生成: C:\\GameServer\\update_config.ps1"
}

# 生成游戏服务器启动脚本
generate_server_script() {
    if [[ -f "$INSTALL_DIR/start_server.bat" ]] && [[ -f "$INSTALL_DIR/stop_server.bat" ]] && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "服务器启动脚本已存在，跳过生成"
        return
    fi
    
    print_info "生成游戏服务器启动脚本..."
    
    # Windows 批处理脚本
    cat > "$INSTALL_DIR/start_server.bat" << 'EOF'
@echo off
chcp 65001 >nul
title DDizhu 游戏服务器

echo ==========================================
echo   DDizhu 游戏服务器启动中...
echo ==========================================
echo.

cd /d C:\GameServer

echo [1/3] 启动中心服务器...
start "Center Server" Center.exe
timeout /t 5 /nobreak >nul

echo [2/3] 启动登录服务器...
start "Logon Server" MTSvrLogon.exe
timeout /t 5 /nobreak >nul

echo [3/3] 启动游戏服务器...
start "Game Server" GameServer.exe
timeout /t 3 /nobreak >nul

echo.
echo ==========================================
echo   所有服务器启动完成！
echo ==========================================
echo.
pause
EOF

    # 停止脚本
    cat > "$INSTALL_DIR/stop_server.bat" << 'EOF'
@echo off
chcp 65001 >nul
echo 停止所有游戏服务器...

taskkill /IM Center.exe /F 2>nul
taskkill /IM MTSvrLogon.exe /F 2>nul
taskkill /IM GameServer.exe /F 2>nul

echo 所有服务器已停止
pause
EOF
    
    print_success "服务器启动脚本已生成"
    print_info "  - C:\\GameServer\\start_server.bat"
    print_info "  - C:\\GameServer\\stop_server.bat"
}

# 检查部署状态
check_deployment_status() {
    echo ""
    echo "=========================================="
    echo "  部署状态检查"
    echo "=========================================="
    echo ""
    
    # 检查目录
    echo -e "${CYAN}[目录状态]${NC}"
    if [[ -d "$INSTALL_DIR" ]]; then
        echo -e "  GameServer: ${GREEN}已创建${NC}"
    else
        echo -e "  GameServer: ${RED}未创建${NC}"
    fi
    
    if [[ -d "$WEB_DIR" ]]; then
        echo -e "  Web目录: ${GREEN}已创建${NC}"
    else
        echo -e "  Web目录: ${RED}未创建${NC}"
    fi
    
    # 检查文件
    echo ""
    echo -e "${CYAN}[文件状态]${NC}"
    for dir in qiantai HT admin agent Hall; do
        if [[ -f "$WEB_DIR/$dir/Web.config" ]]; then
            echo -e "  $dir: ${GREEN}已部署${NC}"
        else
            echo -e "  $dir: ${RED}未部署${NC}"
        fi
    done
    
    # 检查脚本
    echo ""
    echo -e "${CYAN}[脚本状态]${NC}"
    for script in create_database.sql configure_iis.ps1 update_config.ps1 start_server.bat; do
        if [[ -f "$INSTALL_DIR/$script" ]]; then
            echo -e "  $script: ${GREEN}已生成${NC}"
        else
            echo -e "  $script: ${RED}未生成${NC}"
        fi
    done
    
    # 检查 IIS
    echo ""
    echo -e "${CYAN}[IIS 状态]${NC}"
    if check_iis_configured; then
        echo -e "  DDizhu 站点: ${GREEN}已配置${NC}"
    else
        echo -e "  DDizhu 站点: ${RED}未配置${NC}"
    fi
    
    echo ""
    echo "=========================================="
}

# 打印部署指南
print_guide() {
    echo ""
    echo "=========================================="
    echo -e "${GREEN}DDizhu 部署脚本执行完成！${NC}"
    echo "=========================================="
    echo ""
    echo "后续步骤："
    echo ""
    echo -e "${YELLOW}1. 执行数据库脚本：${NC}"
    echo "   - 打开 SQL Server Management Studio (Windows)"
    echo "   - 连接到数据库服务器"
    echo "   - 打开并执行: C:\\GameServer\\create_database.sql"
    echo ""
    echo -e "${YELLOW}2. 配置 IIS (以管理员身份运行 PowerShell)：${NC}"
    echo "   powershell -ExecutionPolicy Bypass -File \"C:\\GameServer\\configure_iis.ps1\""
    echo ""
    echo -e "${YELLOW}3. 更新数据库配置：${NC}"
    echo "   powershell -ExecutionPolicy Bypass -File \"C:\\GameServer\\update_config.ps1\" -DbServer 127.0.0.1 -DbUser gameuser -DbPassword YourPassword"
    echo ""
    echo -e "${YELLOW}4. 启动游戏服务器 (双击运行)：${NC}"
    echo "   C:\\GameServer\\start_server.bat"
    echo ""
    echo -e "${YELLOW}5. 或使用 WSL 启动脚本：${NC}"
    echo "   ./start.sh --all"
    echo ""
    echo "=========================================="
    echo ""
    echo "网站访问地址："
    echo "  - 前台网站: http://localhost"
    echo "  - 后台管理: http://localhost:8080"
    echo "  - 管理员:   http://localhost:8081"
    echo "  - 代理商:   http://localhost:8082"
    echo "  - 游戏大厅: http://localhost:8083"
    echo "=========================================="
}

# 打印帮助
print_help() {
    echo ""
    echo "DDizhu 斗地主棋牌游戏平台 - 一键部署脚本 (WSL 版本)"
    echo ""
    echo "使用方法: ./deploy.sh [选项]"
    echo ""
    echo "选项："
    echo "  --force      强制重新部署，覆盖已存在的文件"
    echo "  --status     仅检查部署状态，不执行部署"
    echo "  --help       显示帮助信息"
    echo ""
    echo "示例："
    echo "  ./deploy.sh           # 执行部署（跳过已存在的组件）"
    echo "  ./deploy.sh --force   # 强制重新部署"
    echo "  ./deploy.sh --status  # 检查部署状态"
    echo ""
}

# 主函数
main() {
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --force)
                FORCE_MODE=true
                shift
                ;;
            --status)
                check_wsl
                check_deployment_status
                exit 0
                ;;
            --help|-h)
                print_help
                exit 0
                ;;
            *)
                print_error "未知选项: $1"
                print_help
                exit 1
                ;;
        esac
    done
    
    echo ""
    echo "=========================================="
    echo "  DDizhu 斗地主棋牌游戏平台 - 一键部署"
    echo "  (WSL 版本)"
    if [[ "$FORCE_MODE" == "true" ]]; then
        echo -e "  ${RED}强制模式已启用${NC}"
    fi
    echo "=========================================="
    echo ""
    
    check_wsl
    create_directories
    copy_files
    generate_db_script
    generate_iis_script
    generate_config_script
    generate_server_script
    
    # 显示部署状态
    check_deployment_status
    
    print_guide
}

# 执行主函数
main "$@"
