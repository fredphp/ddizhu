#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 一键部署脚本 (WSL 版本)
# 适用系统：Windows WSL (Windows Subsystem for Linux)
# 说明：项目运行在 WSL Linux 环境中，文件部署在 WSL 文件系统
# 使用方法：./deploy.sh [选项]
# 选项：
#   --force         强制重新部署，覆盖已存在的文件
#   --install-sql   在 Windows 中安装 SQL Server Express
#   --status        仅检查部署状态
#   --check-db      检查数据库状态
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

# WSL 内部路径 (不占用 Windows C 盘)
INSTALL_DIR="/opt/ddizhu/server"
WEB_DIR="/opt/ddizhu/www"
LOG_DIR="/opt/ddizhu/logs"
CONFIG_DIR="/opt/ddizhu/config"

# 项目目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 强制模式
FORCE_MODE=false
INSTALL_SQL=false

# 数据库列表
DATABASES=(
    "QPGameWeb"
    "QPPlatformDB"
    "QPAccountsDB"
    "QPTreasureDB"
    "QPRecordDB"
    "QPAgencyDB"
    "QPOtherWebDB"
    "QPGameMatchDB"
)

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
    if command -v powershell.exe &> /dev/null; then
        print_success "Windows 互操作性已启用"
    else
        print_warning "Windows 互操作性未启用，部分功能可能受限"
    fi
}

# 检查并安装依赖
check_dependencies() {
    print_info "检查系统依赖..."
    
    local need_install=()
    
    # 检查 mono (用于运行 .NET)
    if ! command -v mono &> /dev/null; then
        need_install+=("mono-complete")
    fi
    
    # 检查 nginx (用于 Web 服务)
    if ! command -v nginx &> /dev/null; then
        need_install+=("nginx")
    fi
    
    # 检查其他工具
    if ! command -v unzip &> /dev/null; then
        need_install+=("unzip")
    fi
    
    if ! command -v curl &> /dev/null; then
        need_install+=("curl")
    fi
    
    if [[ ${#need_install[@]} -gt 0 ]]; then
        print_info "需要安装以下依赖: ${need_install[*]}"
        read -p "是否立即安装？(y/N): " install_deps
        
        if [[ "$install_deps" =~ ^[Yy]$ ]]; then
            sudo apt update
            sudo apt install -y "${need_install[@]}"
            print_success "依赖安装完成"
        else
            print_warning "部分功能可能无法正常使用"
        fi
    else
        print_success "系统依赖已满足"
    fi
}

# 检查 SQL Server 是否已安装 (在 Windows 中)
check_sql_server() {
    print_info "检查 SQL Server 安装状态..."
    
    if command -v powershell.exe &> /dev/null; then
        # 检查 SQL Server 服务
        local sql_service=$(powershell.exe -Command "Get-Service -Name 'MSSQL*' -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty Name" 2>/dev/null | tr -d '\r')
        
        if [[ -n "$sql_service" ]]; then
            print_success "SQL Server 已安装: $sql_service"
            
            # 检查服务状态
            local service_status=$(powershell.exe -Command "(Get-Service -Name '$sql_service').Status" 2>/dev/null | tr -d '\r')
            if [[ "$service_status" == "Running" ]]; then
                print_success "SQL Server 服务正在运行"
            else
                print_warning "SQL Server 服务状态: $service_status"
                print_info "尝试启动 SQL Server 服务..."
                powershell.exe -Command "Start-Service -Name '$sql_service'" 2>/dev/null || true
            fi
            
            # 检查端口
            local port_check=$(powershell.exe -Command "Test-NetConnection -ComputerName localhost -Port 1433 -InformationLevel Quiet -WarningAction SilentlyContinue" 2>/dev/null | tr -d '\r')
            if [[ "$port_check" == "True" ]]; then
                print_success "SQL Server 端口 1433 可访问"
            else
                print_warning "SQL Server 端口 1433 不可访问"
            fi
            
            return 0
        fi
    fi
    
    print_warning "SQL Server 未安装"
    return 1
}

# 安装 SQL Server Express (在 Windows 中)
install_sql_server() {
    print_info "准备在 Windows 中安装 SQL Server Express..."
    
    if command -v powershell.exe &> /dev/null; then
        # 检查是否已安装 Chocolatey
        local choco_installed=$(powershell.exe -Command "Get-Command choco -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name" 2>/dev/null | tr -d '\r')
        
        if [[ "$choco_installed" != "choco" ]]; then
            print_info "安装 Chocolatey 包管理器..."
            powershell.exe -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" 2>/dev/null
            
            if [[ $? -ne 0 ]]; then
                print_error "Chocolatey 安装失败"
                print_info "请手动安装 SQL Server Express: https://www.microsoft.com/zh-cn/sql-server/sql-server-downloads"
                return 1
            fi
            print_success "Chocolatey 安装完成"
        else
            print_success "Chocolatey 已安装"
        fi
        
        # 使用 Chocolatey 安装 SQL Server Express
        print_info "正在安装 SQL Server Express (这可能需要几分钟)..."
        print_info "请耐心等待，不要关闭窗口..."
        
        powershell.exe -Command "choco install sql-server-express -y --params='/Quiet /NoRestart /InstanceName=SQLEXPRESS'" 2>/dev/null
        
        if [[ $? -eq 0 ]]; then
            print_success "SQL Server Express 安装完成"
            
            # 安装 SQL Server Management Studio (可选)
            print_info "安装 SQL Server Management Studio..."
            powershell.exe -Command "choco install sql-server-management-studio -y" 2>/dev/null || print_warning "SSMS 安装跳过"
            
            # 启动服务
            print_info "启动 SQL Server 服务..."
            powershell.exe -Command "Start-Service -Name 'MSSQL\$SQLEXPRESS'" 2>/dev/null || true
            
            print_success "SQL Server Express 安装完成"
            return 0
        else
            print_error "SQL Server Express 安装失败"
            print_info "请手动下载安装: https://www.microsoft.com/zh-cn/sql-server/sql-server-downloads"
            return 1
        fi
    else
        print_error "PowerShell 不可用，无法自动安装"
        print_info "请手动安装 SQL Server Express: https://www.microsoft.com/zh-cn/sql-server/sql-server-downloads"
        return 1
    fi
}

# 检查数据库是否存在
check_databases() {
    print_info "检查数据库状态..."
    
    if ! check_sql_server; then
        return 1
    fi
    
    local existing_count=0
    local missing_count=0
    
    echo ""
    echo -e "${CYAN}[数据库状态]${NC}"
    
    for db in "${DATABASES[@]}"; do
        local exists=$(powershell.exe -Command "
            try {
                \$conn = New-Object System.Data.SqlClient.SqlConnection
                \$conn.ConnectionString = 'Server=localhost;Database=master;Integrated Security=True;'
                \$conn.Open()
                \$cmd = \$conn.CreateCommand()
                \$cmd.CommandText = \"SELECT name FROM sys.databases WHERE name = '$db'\"
                \$result = \$cmd.ExecuteScalar()
                \$conn.Close()
                if (\$result) { 'EXISTS' } else { 'MISSING' }
            } catch { 'ERROR' }
        " 2>/dev/null | tr -d '\r')
        
        if [[ "$exists" == "EXISTS" ]]; then
            echo -e "  $db: ${GREEN}已存在${NC}"
            ((existing_count++))
        else
            echo -e "  $db: ${RED}不存在${NC}"
            ((missing_count++))
        fi
    done
    
    echo ""
    print_info "已存在: $existing_count 个, 缺失: $missing_count 个"
    
    return 0
}

# 检查目录是否已存在
check_directories_exist() {
    [[ -d "$INSTALL_DIR" && -d "$WEB_DIR/qiantai" && -d "$WEB_DIR/HT" && -d "$WEB_DIR/admin" && -d "$WEB_DIR/agent" && -d "$WEB_DIR/Hall" ]]
}

# 检查文件是否已复制
check_files_copied() {
    local has_files=true
    [[ -f "$WEB_DIR/qiantai/Web.config" ]] || has_files=false
    [[ -f "$WEB_DIR/HT/Web.config" ]] || has_files=false
    [[ -f "$WEB_DIR/agent/Web.config" ]] || has_files=false
    $has_files
}

# 检查脚本是否已生成
check_scripts_generated() {
    [[ -f "$CONFIG_DIR/create_database.sql" ]]
}

# 创建目录结构
create_directories() {
    if check_directories_exist && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "目录已存在，跳过创建"
        return
    fi
    
    print_info "创建目录结构..."
    
    sudo mkdir -p "$INSTALL_DIR"
    sudo mkdir -p "$INSTALL_DIR/logs"
    sudo mkdir -p "$WEB_DIR"
    sudo mkdir -p "$WEB_DIR/qiantai"
    sudo mkdir -p "$WEB_DIR/HT"
    sudo mkdir -p "$WEB_DIR/admin"
    sudo mkdir -p "$WEB_DIR/agent"
    sudo mkdir -p "$WEB_DIR/Hall"
    sudo mkdir -p "$LOG_DIR"
    sudo mkdir -p "$CONFIG_DIR"
    
    # 设置权限
    sudo chown -R $USER:$USER /opt/ddizhu
    
    print_success "目录创建完成"
    print_info "部署路径: $WEB_DIR"
    print_info "服务器路径: $INSTALL_DIR"
    print_info "配置路径: $CONFIG_DIR"
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
    if [[ -f "$CONFIG_DIR/create_database.sql" ]] && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "数据库脚本已存在，跳过生成"
        return
    fi
    
    print_info "生成数据库脚本..."
    
    cat > "$CONFIG_DIR/create_database.sql" << 'EOF'
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

-- 授权
DECLARE @db_name NVARCHAR(100)
DECLARE @sql NVARCHAR(MAX)

DECLARE db_cursor CURSOR FOR
SELECT name FROM sys.databases WHERE name IN ('QPGameWeb','QPPlatformDB','QPAccountsDB','QPTreasureDB','QPRecordDB','QPAgencyDB','QPOtherWebDB','QPGameMatchDB')

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @db_name

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = 'USE [' + @db_name + ']; IF NOT EXISTS (SELECT name FROM sysusers WHERE name = ''gameuser'') BEGIN CREATE USER gameuser FOR LOGIN gameuser; ALTER ROLE db_owner ADD MEMBER gameuser; END'
    EXEC sp_executesql @sql
    FETCH NEXT FROM db_cursor INTO @db_name
END

CLOSE db_cursor
DEALLOCATE db_cursor
GO

PRINT '数据库脚本执行完成！';
EOF
    
    print_success "数据库脚本已生成: $CONFIG_DIR/create_database.sql"
}

# 生成配置更新脚本
generate_config_update_script() {
    print_info "生成配置更新脚本..."
    
    cat > "$CONFIG_DIR/update_config.sh" << 'SCRIPT_EOF'
#!/bin/bash

# 配置更新脚本
# 用于更新数据库连接字符串

CONFIG_DIR="/opt/ddizhu/config"
LOG_FILE="/opt/ddizhu/logs/config_update.log"

echo "配置更新工具"
echo "============="

read -p "请输入数据库服务器地址 (默认: 127.0.0.1): " db_server
db_server=${db_server:-127.0.0.1}

read -p "请输入数据库端口 (默认: 1433): " db_port
db_port=${db_port:-1433}

read -p "请输入数据库用户名 (默认: sa): " db_user
db_user=${db_user:-sa}

read -s -p "请输入数据库密码: " db_password
echo ""

# 更新配置文件
for dir in qiantai HT admin agent; do
    config_file="/opt/ddizhu/www/$dir/Web.config"
    if [[ -f "$config_file" ]]; then
        sed -i "s/Data Source=[^;]*;/Data Source=$db_server,$db_port;/g" "$config_file"
        sed -i "s/User ID=[^;]*;/User ID=$db_user;/g" "$config_file"
        sed -i "s/Password=[^;]*;/Password=$db_password;/g" "$config_file"
        echo "已更新: $config_file"
    fi
done

echo "配置更新完成！"
SCRIPT_EOF
    
    chmod +x "$CONFIG_DIR/update_config.sh"
    print_success "配置更新脚本已生成: $CONFIG_DIR/update_config.sh"
}

# 生成 Windows IIS 配置脚本
generate_iis_script() {
    print_info "生成 Windows IIS 配置脚本..."
    
    cat > "$CONFIG_DIR/configure_iis.ps1" << 'EOF'
# DDizhu IIS 配置脚本
# 请以管理员身份在 Windows PowerShell 中运行
# 注意：网站目录指向 WSL 文件系统

param(
    [string]$WslDistro = "Ubuntu",
    [string]$WslPath = "/opt/ddizhu/www"
)

Write-Host "配置 IIS 站点..." -ForegroundColor Green

# 获取 WSL 路径对应的 Windows 路径
$wslWindowsPath = wsl -d $WslDistro -- wslpath -w $WslPath 2>$null
if (-not $wslWindowsPath) {
    Write-Host "无法获取 WSL 路径，请确保 WSL 已安装并运行" -ForegroundColor Red
    exit 1
}

Write-Host "WSL 路径: $WslPath -> Windows 路径: $wslWindowsPath" -ForegroundColor Cyan

# 创建应用程序池
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

# 创建网站
$sites = @(
    @{Name="DDizhu_Web"; Path="qiantai"; Port=80},
    @{Name="DDizhu_HT"; Path="HT"; Port=8080},
    @{Name="DDizhu_Admin"; Path="admin"; Port=8081},
    @{Name="DDizhu_Agent"; Path="agent"; Port=8082},
    @{Name="DDizhu_Hall"; Path="Hall"; Port=8083}
)

foreach ($site in $sites) {
    $physicalPath = Join-Path $wslWindowsPath $site.Path
    if (Get-Website -Name $site.Name -ErrorAction SilentlyContinue) {
        Write-Host "网站已存在: $($site.Name)" -ForegroundColor DarkGray
    } else {
        New-Website -Name $site.Name -PhysicalPath $physicalPath -ApplicationPool $site.Name -Port $site.Port
        Write-Host "创建网站: $($site.Name) (端口: $($site.Port))" -ForegroundColor Cyan
    }
}

# 启动 IIS
Start-Service w3svc -ErrorAction SilentlyContinue

Write-Host "IIS 配置完成！" -ForegroundColor Green
Write-Host ""
Write-Host "网站访问地址：" -ForegroundColor Yellow
Write-Host "  - 前台网站: http://localhost"
Write-Host "  - 后台管理: http://localhost:8080"
Write-Host "  - 管理员:   http://localhost:8081"
Write-Host "  - 代理商:   http://localhost:8082"
Write-Host "  - 游戏大厅: http://localhost:8083"
EOF
    
    print_success "IIS 配置脚本已生成: $CONFIG_DIR/configure_iis.ps1"
}

# 检查部署状态
check_deployment_status() {
    echo ""
    echo "=========================================="
    echo "  部署状态检查"
    echo "=========================================="
    echo ""
    
    # 检查 SQL Server
    echo -e "${CYAN}[SQL Server 状态]${NC}"
    if command -v powershell.exe &> /dev/null; then
        local sql_service=$(powershell.exe -Command "Get-Service -Name 'MSSQL*' -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty Name" 2>/dev/null | tr -d '\r')
        if [[ -n "$sql_service" ]]; then
            local sql_status=$(powershell.exe -Command "(Get-Service -Name '$sql_service').Status" 2>/dev/null | tr -d '\r')
            if [[ "$sql_status" == "Running" ]]; then
                echo -e "  SQL Server: ${GREEN}已安装并运行${NC} ($sql_service)"
            else
                echo -e "  SQL Server: ${YELLOW}已安装但未运行${NC} ($sql_service)"
            fi
        else
            echo -e "  SQL Server: ${RED}未安装${NC}"
        fi
    else
        echo -e "  SQL Server: ${YELLOW}无法检测${NC}"
    fi
    
    # 检查目录
    echo ""
    echo -e "${CYAN}[目录状态]${NC}"
    if [[ -d "$INSTALL_DIR" ]]; then
        echo -e "  服务器目录: ${GREEN}$INSTALL_DIR${NC}"
    else
        echo -e "  服务器目录: ${RED}未创建${NC}"
    fi
    
    if [[ -d "$WEB_DIR" ]]; then
        echo -e "  Web目录: ${GREEN}$WEB_DIR${NC}"
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
    echo -e "${CYAN}[配置脚本]${NC}"
    for script in create_database.sql configure_iis.ps1 update_config.sh; do
        if [[ -f "$CONFIG_DIR/$script" ]]; then
            echo -e "  $script: ${GREEN}已生成${NC}"
        else
            echo -e "  $script: ${RED}未生成${NC}"
        fi
    done
    
    # 磁盘空间
    echo ""
    echo -e "${CYAN}[磁盘空间]${NC}"
    df -h /opt 2>/dev/null | tail -1 | awk '{print "  可用空间: " $4}'
    
    echo ""
    echo "=========================================="
}

# 打印部署指南
print_guide() {
    echo ""
    echo "=========================================="
    echo -e "${GREEN}部署完成！${NC}"
    echo "=========================================="
    echo ""
    echo -e "${YELLOW}后续步骤：${NC}"
    echo ""
    echo "1. 创建数据库："
    echo "   方式一: 在 Windows 中打开 SQL Server Management Studio"
    echo "           连接到 localhost，执行: $CONFIG_DIR/create_database.sql"
    echo ""
    echo "   方式二: 如果安装了 mssql-tools"
    echo "           sqlcmd -S localhost -U sa -P '密码' -i $CONFIG_DIR/create_database.sql"
    echo ""
    echo "2. 更新数据库配置："
    echo "   $CONFIG_DIR/update_config.sh"
    echo ""
    echo "3. 配置 IIS (在 Windows PowerShell 管理员中运行)："
    echo "   wsl -e cat $CONFIG_DIR/configure_iis.ps1 | Out-File -FilePath C:\temp\configure_iis.ps1"
    echo "   powershell -ExecutionPolicy Bypass -File C:\temp\configure_iis.ps1"
    echo ""
    echo "4. 启动服务："
    echo "   ./start.sh --all"
    echo ""
    echo "=========================================="
    echo ""
    echo "部署路径说明："
    echo "  - Web文件: $WEB_DIR"
    echo "  - 服务器: $INSTALL_DIR"
    echo "  - 配置: $CONFIG_DIR"
    echo "  - 日志: $LOG_DIR"
    echo ""
    echo "网站访问地址（配置IIS后）："
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
    echo "  --force         强制重新部署，覆盖已存在的文件"
    echo "  --install-sql   在 Windows 中安装 SQL Server Express"
    echo "  --status        仅检查部署状态"
    echo "  --check-db      检查数据库状态"
    echo "  --help          显示帮助信息"
    echo ""
    echo "示例："
    echo "  ./deploy.sh              # 执行部署"
    echo "  ./deploy.sh --force      # 强制重新部署"
    echo "  ./deploy.sh --install-sql # 安装 SQL Server"
    echo "  ./deploy.sh --status     # 检查部署状态"
    echo ""
    echo "部署路径："
    echo "  Web文件: /opt/ddizhu/www"
    echo "  服务器:  /opt/ddizhu/server"
    echo "  配置:    /opt/ddizhu/config"
    echo ""
    echo "所需数据库 (8个)："
    echo "  QPGameWeb, QPPlatformDB, QPAccountsDB, QPTreasureDB"
    echo "  QPRecordDB, QPAgencyDB, QPOtherWebDB, QPGameMatchDB"
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
            --install-sql)
                INSTALL_SQL=true
                shift
                ;;
            --status)
                check_wsl
                check_deployment_status
                exit 0
                ;;
            --check-db)
                check_wsl
                check_databases
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
    echo "  (WSL Linux 环境)"
    if [[ "$FORCE_MODE" == "true" ]]; then
        echo -e "  ${RED}强制模式已启用${NC}"
    fi
    if [[ "$INSTALL_SQL" == "true" ]]; then
        echo -e "  ${YELLOW}将安装 SQL Server Express${NC}"
    fi
    echo "=========================================="
    echo ""
    
    check_wsl
    check_dependencies
    
    # 处理 SQL Server 安装
    if [[ "$INSTALL_SQL" == "true" ]]; then
        if check_sql_server; then
            print_skip "SQL Server 已安装，跳过"
        else
            install_sql_server
        fi
    else
        check_sql_server || true
    fi
    
    # 检查数据库状态
    check_databases || true
    
    create_directories
    copy_files
    generate_db_script
    generate_config_update_script
    generate_iis_script
    
    check_deployment_status
    print_guide
}

# 执行主函数
main "$@"
