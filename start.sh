#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 启动脚本
# 支持普通 Linux 和 WSL 环境
# 使用方法：./start.sh [选项]
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 路径配置 (使用用户目录)
SERVER_DIR="$HOME/ddizhu-deploy/server"
WEB_DIR="$HOME/ddizhu-deploy/www"
LOG_DIR="$HOME/ddizhu-deploy/logs"
CONFIG_DIR="$HOME/ddizhu-deploy/config"
PID_DIR="$HOME/ddizhu-deploy/pids"

# 数据库配置
DB_SERVER="127.0.0.1"
DB_PORT="1433"
DB_USER="sa"
DB_PASSWORD="Admin@1234"

print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_skip() { echo -e "${CYAN}[SKIP]${NC} $1"; }

# 创建目录
init_dirs() {
    mkdir -p "$LOG_DIR" "$PID_DIR" 2>/dev/null || true
}

# 检查 SQL Server 连接
check_sql() {
    print_info "检查 SQL Server 连接..."
    
    if nc -z localhost 1433 2>/dev/null; then
        print_success "SQL Server 可连接 (Docker)"
        return 0
    fi
    
    if (echo > /dev/tcp/localhost/1433) 2>/dev/null; then
        print_success "SQL Server 可连接 (Docker)"
        return 0
    fi
    
    print_warning "SQL Server 不可连接"
    print_info "请确保 Docker 容器运行: docker start sqlserver"
    return 1
}

# 启动 SQL Server 容器
start_sql_docker() {
    print_info "启动 SQL Server 容器..."
    
    if command -v docker &> /dev/null; then
        if docker ps -a 2>/dev/null | grep -q "sqlserver"; then
            if docker ps 2>/dev/null | grep -q "sqlserver"; then
                print_skip "SQL Server 容器已运行"
            else
                docker start sqlserver 2>/dev/null && print_success "SQL Server 容器已启动"
            fi
        else
            print_warning "SQL Server 容器不存在"
            print_info "创建命令: docker run -e \"ACCEPT_EULA=Y\" -e \"SA_PASSWORD=Admin@1234\" -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest"
        fi
    fi
}

# 检查部署
check_deployment() {
    if [[ ! -d "$WEB_DIR" ]]; then
        print_error "项目未部署"
        print_info "请先运行: ./deploy.sh"
        return 1
    fi
    return 0
}

# 显示服务状态
show_status() {
    echo ""
    echo "=========================================="
    echo "  DDizhu 服务状态"
    echo "=========================================="
    echo ""
    
    # SQL Server
    echo -e "${CYAN}[SQL Server]${NC}"
    if nc -z localhost 1433 2>/dev/null; then
        echo -e "  状态: ${GREEN}可连接${NC}"
        
        # 检查 Docker 容器
        if command -v docker &> /dev/null && docker ps 2>/dev/null | grep -q "sqlserver"; then
            echo -e "  容器: ${GREEN}运行中${NC}"
        fi
    else
        echo -e "  状态: ${RED}不可连接${NC}"
    fi
    
    # 数据库状态
    echo ""
    echo -e "${CYAN}[数据库]${NC}"
    if command -v docker &> /dev/null && docker ps 2>/dev/null | grep -q "sqlserver"; then
        local dbs=$(docker exec sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$DB_PASSWORD" -Q "SET NOCOUNT ON; SELECT name FROM sys.databases WHERE name LIKE 'QP%'" -h -1 2>/dev/null | tr -d ' ')
        if [[ -n "$dbs" ]]; then
            echo "$dbs" | while read db; do
                [[ -n "$db" ]] && echo -e "  $db: ${GREEN}已创建${NC}"
            done
        else
            echo -e "  ${YELLOW}未检测到数据库${NC}"
        fi
    fi
    
    # Web 文件
    echo ""
    echo -e "${CYAN}[Web 文件]${NC}"
    for dir in qiantai HT admin agent Hall; do
        if [[ -d "$WEB_DIR/$dir" ]]; then
            echo -e "  $dir: ${GREEN}已部署${NC}"
        else
            echo -e "  $dir: ${RED}未部署${NC}"
        fi
    done
    
    # 磁盘空间
    echo ""
    echo -e "${CYAN}[磁盘空间]${NC}"
    df -h "$HOME" 2>/dev/null | tail -1 | awk '{print "  可用: " $4 " / 总计: " $2}'
    
    echo ""
    echo "=========================================="
    echo ""
    echo "部署路径："
    echo "  Web: $WEB_DIR"
    echo "  配置: $CONFIG_DIR"
    echo ""
    echo "数据库连接信息："
    echo "  地址: $DB_SERVER:$DB_PORT"
    echo "  用户: $DB_USER"
    echo ""
    echo "=========================================="
}

# 显示日志
show_logs() {
    echo ""
    echo "日志目录: $LOG_DIR"
    echo ""
    
    if [[ -d "$LOG_DIR" ]]; then
        for log in "$LOG_DIR"/*.log; do
            if [[ -f "$log" ]]; then
                echo "--- $(basename $log) ---"
                tail -20 "$log" 2>/dev/null
                echo ""
            fi
        done
    fi
}

# 打印帮助
print_help() {
    echo ""
    echo "DDizhu 斗地主棋牌游戏平台 - 启动脚本"
    echo ""
    echo "使用方法: ./start.sh [选项]"
    echo ""
    echo "选项："
    echo "  --all        启动所有服务（默认）"
    echo "  --sql        仅启动 SQL Server"
    echo "  --status     查看服务状态"
    echo "  --logs       查看日志"
    echo "  --help       显示帮助"
    echo ""
    echo "说明："
    echo "  本项目需要 Docker SQL Server 运行"
    echo "  Web 服务需要单独配置 (Nginx/Apache 或 IIS)"
    echo ""
}

# 主函数
main() {
    init_dirs
    
    local action=${1:---all}
    
    case "$action" in
        --all)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 启动服务"
            echo "=========================================="
            echo ""
            check_deployment || exit 1
            start_sql_docker
            check_sql || true
            show_status
            ;;
        --sql)
            start_sql_docker
            check_sql
            ;;
        --status)
            show_status
            ;;
        --logs)
            show_logs
            ;;
        --help|-h)
            print_help
            ;;
        *)
            print_error "未知选项: $action"
            print_help
            exit 1
            ;;
    esac
}

main "$@"
