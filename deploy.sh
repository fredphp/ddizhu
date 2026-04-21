#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 一键部署脚本
# 适用系统：Windows (通过 Git Bash 或 WSL 运行)
# 使用方法：./deploy.sh
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置变量（请根据实际情况修改）
DB_SERVER="127.0.0.1"
DB_PORT="1433"
DB_USER="gameuser"
DB_PASSWORD="YourStrongPassword123!"

# 安装目录
INSTALL_DIR="/c/GameServer"
WEB_DIR="/c/www/ddizhu"

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

# 检查是否以管理员身份运行
check_admin() {
    print_info "检查管理员权限..."
    if [[ $EUID -ne 0 ]]; then
        print_warning "建议以管理员身份运行此脚本"
    fi
}

# 创建目录结构
create_directories() {
    print_info "创建目录结构..."
    
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$WEB_DIR"
    mkdir -p "$WEB_DIR/qiantai"
    mkdir -p "$WEB_DIR/HT"
    mkdir -p "$WEB_DIR/admin"
    mkdir -p "$WEB_DIR/agent"
    mkdir -p "$WEB_DIR/Hall"
    mkdir -p "$WEB_DIR/logs"
    
    print_success "目录创建完成"
}

# 复制文件
copy_files() {
    print_info "复制项目文件..."
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # 复制 Web 文件
    if [[ -d "$SCRIPT_DIR/qiantai" ]]; then
        cp -r "$SCRIPT_DIR/qiantai"/* "$WEB_DIR/qiantai/" 2>/dev/null || true
    fi
    
    if [[ -d "$SCRIPT_DIR/HT" ]]; then
        cp -r "$SCRIPT_DIR/HT"/* "$WEB_DIR/HT/" 2>/dev/null || true
    fi
    
    if [[ -d "$SCRIPT_DIR/admin" ]]; then
        cp -r "$SCRIPT_DIR/admin"/* "$WEB_DIR/admin/" 2>/dev/null || true
    fi
    
    if [[ -d "$SCRIPT_DIR/agent" ]]; then
        cp -r "$SCRIPT_DIR/agent"/* "$WEB_DIR/agent/" 2>/dev/null || true
    fi
    
    if [[ -d "$SCRIPT_DIR/Hall" ]]; then
        cp -r "$SCRIPT_DIR/Hall"/* "$WEB_DIR/Hall/" 2>/dev/null || true
    fi
    
    print_success "文件复制完成"
}

# 生成数据库创建脚本
generate_db_script() {
    print_info "生成数据库脚本..."
    
    cat > "$INSTALL_DIR/create_database.sql" << 'EOF'
-- DDizhu 数据库创建脚本
-- 请在 SQL Server Management Studio 中执行

-- 创建数据库
CREATE DATABASE QPGameWeb;
CREATE DATABASE QPPlatformDB;
CREATE DATABASE QPAccountsDB;
CREATE DATABASE QPTreasureDB;
CREATE DATABASE QPRecordDB;
CREATE DATABASE QPAgencyDB;
CREATE DATABASE QPOtherWebDB;
CREATE DATABASE QPGameMatchDB;
GO

-- 创建用户
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

PRINT '数据库创建完成！';
EOF
    
    print_success "数据库脚本已生成: $INSTALL_DIR/create_database.sql"
}

# 生成 IIS 配置脚本
generate_iis_script() {
    print_info "生成 IIS 配置脚本..."
    
    cat > "$INSTALL_DIR/configure_iis.ps1" << 'EOF'
# DDizhu IIS 配置脚本
# 请以管理员身份运行 PowerShell 执行此脚本

param(
    [string]$WebPath = "C:\www\ddizhu"
)

Write-Host "配置 IIS 站点..." -ForegroundColor Green

# 创建应用程序池
$appPools = @(
    @{Name="DDizhu_Web"; Version="v4.0"},
    @{Name="DDizhu_HT"; Version="v4.0"},
    @{Name="DDizhu_Admin"; Version="v4.0"},
    @{Name="DDizhu_Agent"; Version="v2.0"},
    @{Name="DDizhu_Hall"; Version="v4.0"}
)

foreach ($pool in $appPools) {
    if (-not (Get-WebAppPool -Name $pool.Name -ErrorAction SilentlyContinue)) {
        New-WebAppPool -Name $pool.Name -Force
        Set-ItemProperty "IIS:\AppPools\$($pool.Name)" -Name "managedRuntimeVersion" -Value $pool.Version
        Write-Host "创建应用程序池: $($pool.Name)" -ForegroundColor Cyan
    }
}

# 创建网站
$sites = @(
    @{Name="DDizhu_Web"; Path="qiantai"; Port=80},
    @{Name="DDizhu_HT"; Path="HT"; Port=8080},
    @{Name="DDizhu_Admin"; Path="admin"; Port=8081},
    @{Name="DDizhu_Agent"; Path="agent"; Port=8082},
    @{Name="DDizhu_Hall"; Path="Hall"; Port=8083}
)

foreach ($site in $sites) {
    $physicalPath = Join-Path $WebPath $site.Path
    if (-not (Get-Website -Name $site.Name -ErrorAction SilentlyContinue)) {
        New-Website -Name $site.Name -PhysicalPath $physicalPath -ApplicationPool $site.Name -Port $site.Port
        Write-Host "创建网站: $($site.Name) (端口: $($site.Port))" -ForegroundColor Cyan
    }
}

# 设置权限
Write-Host "设置目录权限..." -ForegroundColor Green
icacls "$WebPath" /grant "IIS_IUSRS:(OI)(CI)F" /T
icacls "$WebPath" /grant "IUSR:(OI)(CI)F" /T

Write-Host "IIS 配置完成！" -ForegroundColor Green
EOF
    
    print_success "IIS 配置脚本已生成: $INSTALL_DIR/configure_iis.ps1"
}

# 生成配置文件更新脚本
generate_config_script() {
    print_info "生成配置更新脚本..."
    
    cat > "$INSTALL_DIR/update_config.ps1" << 'EOF'
# 配置文件更新脚本
# 请以管理员身份运行

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
    @{File="qiantai/Web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB")},
    @{File="HT/Web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB", "QPOtherWebDB", "QPGameMatchDB")},
    @{File="agent/Web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB")},
    @{File="admin/web.config"; DBs=@("QPGameWeb", "QPPlatformDB", "QPAccountsDB", "QPTreasureDB", "QPRecordDB", "QPAgencyDB")}
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
        
        Set-Content -Path $filePath -Value $content
        Write-Host "已更新: $($config.File)" -ForegroundColor Cyan
    }
}

Write-Host "配置文件更新完成！" -ForegroundColor Green
EOF
    
    print_success "配置更新脚本已生成: $INSTALL_DIR/update_config.ps1"
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
    echo "1. 执行数据库脚本："
    echo "   - 打开 SQL Server Management Studio"
    echo "   - 连接到数据库服务器"
    echo "   - 打开并执行: $INSTALL_DIR/create_database.sql"
    echo ""
    echo "2. 配置 IIS (以管理员身份运行 PowerShell)："
    echo "   powershell -ExecutionPolicy Bypass -File \"$INSTALL_DIR/configure_iis.ps1\""
    echo ""
    echo "3. 更新数据库配置 (以管理员身份运行 PowerShell)："
    echo "   powershell -ExecutionPolicy Bypass -File \"$INSTALL_DIR/update_config.ps1\" -DbServer 127.0.0.1 -DbUser gameuser -DbPassword YourPassword"
    echo ""
    echo "4. 启动游戏服务器："
    echo "   cd $INSTALL_DIR/server"
    echo "   ./start.sh"
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

# 主函数
main() {
    echo ""
    echo "=========================================="
    echo "  DDizhu 斗地主棋牌游戏平台 - 一键部署"
    echo "=========================================="
    echo ""
    
    check_admin
    create_directories
    copy_files
    generate_db_script
    generate_iis_script
    generate_config_script
    print_guide
}

# 执行主函数
main "$@"
