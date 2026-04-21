#!/bin/bash

#######################################################################
# DDizhu - Docker SQL Server 初始化脚本
# 用于配置连接 Docker 中运行的 SQL Server
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Docker SQL Server 配置
DB_SERVER="127.0.0.1"
DB_PORT="1433"
DB_USER="sa"
DB_PASSWORD="Admin@1234"

# 部署路径
INSTALL_DIR="/opt/ddizhu"
CONFIG_DIR="/opt/ddizhu/config"
WEB_DIR="/opt/ddizhu/www"

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

print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查 SQL Server 连接
check_sql_connection() {
    print_info "检查 SQL Server 连接..."
    
    # 使用 PowerShell 检查端口
    if command -v powershell.exe &> /dev/null; then
        local result=$(powershell.exe -Command "Test-NetConnection -ComputerName localhost -Port 1433 -InformationLevel Quiet -WarningAction SilentlyContinue" 2>/dev/null | tr -d '\r')
        if [[ "$result" == "True" ]]; then
            print_success "SQL Server 端口 1433 可访问"
            return 0
        fi
    fi
    
    # 使用 nc 检查
    if command -v nc &> /dev/null; then
        if nc -z localhost 1433 2>/dev/null; then
            print_success "SQL Server 端口 1433 可访问"
            return 0
        fi
    fi
    
    print_warning "无法检测 SQL Server 端口，请确保 Docker 容器正在运行"
    print_info "检查命令: docker ps | grep sqlserver"
    return 1
}

# 生成数据库创建脚本 (Docker 版本)
generate_db_script() {
    print_info "生成数据库创建脚本..."
    
    mkdir -p "$CONFIG_DIR"
    
    cat > "$CONFIG_DIR/create_databases.sql" << 'EOF'
-- DDizhu 数据库创建脚本
-- 适用于 Docker SQL Server
-- 使用 sqlcmd 执行: sqlcmd -S localhost -U sa -P 'Admin@1234' -i create_databases.sql

-- 创建数据库
CREATE DATABASE QPGameWeb;
GO
CREATE DATABASE QPPlatformDB;
GO
CREATE DATABASE QPAccountsDB;
GO
CREATE DATABASE QPTreasureDB;
GO
CREATE DATABASE QPRecordDB;
GO
CREATE DATABASE QPAgencyDB;
GO
CREATE DATABASE QPOtherWebDB;
GO
CREATE DATABASE QPGameMatchDB;
GO

-- 创建用户并授权
CREATE LOGIN gameuser WITH PASSWORD = 'GameUser@123456';
GO

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

PRINT '所有数据库创建完成！';
EOF
    
    print_success "数据库脚本已生成: $CONFIG_DIR/create_databases.sql"
}

# 执行数据库创建 (通过 Docker)
create_databases_via_docker() {
    print_info "通过 Docker 创建数据库..."
    
    # 检查 docker 命令
    if ! command -v docker &> /dev/null; then
        # 尝试使用 Windows Docker
        if command -v docker.exe &> /dev/null; then
            DOCKER_CMD="docker.exe"
        else
            print_warning "Docker 命令不可用"
            print_info "请手动执行以下命令创建数据库："
            echo ""
            echo "  docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Admin@1234' -Q \"CREATE DATABASE QPGameWeb\""
            echo "  docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Admin@1234' -i /path/to/create_databases.sql"
            echo ""
            return 1
        fi
    else
        DOCKER_CMD="docker"
    fi
    
    # 复制 SQL 文件到容器
    print_info "复制 SQL 文件到容器..."
    $DOCKER_CMD cp "$CONFIG_DIR/create_databases.sql" sqlserver:/tmp/ 2>/dev/null || {
        print_warning "无法复制文件到容器"
    }
    
    # 执行 SQL 脚本
    print_info "执行数据库创建脚本..."
    $DOCKER_CMD exec sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Admin@1234' -i /tmp/create_databases.sql 2>/dev/null && {
        print_success "数据库创建完成"
        return 0
    } || {
        print_warning "自动创建数据库失败，请手动执行"
        return 1
    }
}

# 更新所有配置文件
update_all_configs() {
    print_info "更新配置文件..."
    
    local connection_string="Data Source=$DB_SERVER,$DB_PORT; Initial Catalog={DB}; User ID=$DB_USER; Password=$DB_PASSWORD; Pooling=true"
    
    for dir in qiantai HT admin agent; do
        local config_file="$WEB_DIR/$dir/Web.config"
        
        if [[ -f "$config_file" ]]; then
            # 更新数据库连接字符串
            sed -i "s/Data Source=[^;]*;/Data Source=$DB_SERVER,$DB_PORT;/g" "$config_file"
            sed -i "s/User ID=[^;]*;/User ID=$DB_USER;/g" "$config_file"
            sed -i "s/Password=[^;]*;/Password=$DB_PASSWORD;/g" "$config_file"
            
            print_success "已更新: $config_file"
        else
            print_warning "文件不存在: $config_file"
        fi
    done
}

# 显示数据库状态
show_db_status() {
    print_info "数据库状态："
    echo ""
    
    for db in "${DATABASES[@]}"; do
        echo -e "  $db: ${YELLOW}待检查${NC}"
    done
    
    echo ""
    print_info "执行以下命令检查数据库："
    echo "  docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Admin@1234' -Q \"SELECT name FROM sys.databases\""
}

# 主流程
main() {
    echo ""
    echo "=========================================="
    echo "  DDizhu - Docker SQL Server 初始化"
    echo "=========================================="
    echo ""
    echo "SQL Server 配置："
    echo "  地址: $DB_SERVER:$DB_PORT"
    echo "  用户: $DB_USER"
    echo "  密码: $DB_PASSWORD"
    echo ""
    
    # 检查部署
    if [[ ! -d "$WEB_DIR" ]]; then
        print_error "项目未部署，请先运行: ./deploy.sh"
        exit 1
    fi
    
    # 检查 SQL Server 连接
    check_sql_connection || true
    
    # 生成数据库脚本
    generate_db_script
    
    # 创建数据库
    create_databases_via_docker || true
    
    # 更新配置
    update_all_configs
    
    # 显示状态
    show_db_status
    
    echo ""
    echo "=========================================="
    echo -e "${GREEN}初始化完成！${NC}"
    echo "=========================================="
    echo ""
    echo "下一步："
    echo "  1. 确认数据库已创建"
    echo "  2. 配置 IIS (参考 docs/deploy.md)"
    echo "  3. 启动服务: ./start.sh --all"
    echo ""
}

main "$@"
