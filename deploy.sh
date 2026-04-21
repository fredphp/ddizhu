#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 一键部署脚本
# 支持普通 Linux 和 WSL 环境
# 使用方法：./deploy.sh [选项]
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置变量
DB_SERVER="127.0.0.1"
DB_PORT="1433"
DB_USER="sa"
DB_PASSWORD="Admin@1234"

# 部署路径 (使用用户目录，不需要 sudo)
INSTALL_DIR="$HOME/ddizhu-deploy/server"
WEB_DIR="$HOME/ddizhu-deploy/www"
LOG_DIR="$HOME/ddizhu-deploy/logs"
CONFIG_DIR="$HOME/ddizhu-deploy/config"

# 项目目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 强制模式
FORCE_MODE=false

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
print_skip() { echo -e "${CYAN}[SKIP]${NC} $1"; }

# 检测环境
detect_environment() {
    print_info "检测运行环境..."
    
    if [[ -f /proc/version ]] && grep -qi "microsoft" /proc/version 2>/dev/null; then
        echo "  环境: WSL (Windows Subsystem for Linux)"
        ENV_TYPE="wsl"
    else
        echo "  环境: Linux 服务器"
        ENV_TYPE="linux"
    fi
    
    print_success "环境检测完成"
}

# 检查 SQL Server 连接
check_sql_connection() {
    print_info "检查 SQL Server 连接 (Docker)..."
    
    # 使用 nc 检查端口
    if command -v nc &> /dev/null; then
        if nc -z localhost 1433 2>/dev/null; then
            print_success "SQL Server 端口 1433 可访问"
            return 0
        fi
    fi
    
    # 使用 /dev/tcp 检查
    if (echo > /dev/tcp/localhost/1433) 2>/dev/null; then
        print_success "SQL Server 端口 1433 可访问"
        return 0
    fi
    
    print_warning "SQL Server 端口不可访问"
    print_info "请确保 Docker 容器正在运行: docker ps | grep sqlserver"
    return 1
}

# 创建数据库 (通过 Docker)
create_databases() {
    print_info "创建数据库..."
    
    # 检查是否有 docker 命令
    local docker_cmd=""
    if command -v docker &> /dev/null; then
        docker_cmd="docker"
    elif command -v docker.exe &> /dev/null; then
        docker_cmd="docker.exe"
    fi
    
    if [[ -z "$docker_cmd" ]]; then
        print_warning "Docker 命令不可用"
        print_info "请手动执行数据库创建脚本"
        return 1
    fi
    
    # 检查容器状态
    if ! $docker_cmd ps 2>/dev/null | grep -q "sqlserver"; then
        print_warning "SQL Server 容器未运行"
        print_info "启动命令: docker start sqlserver"
        return 1
    fi
    
    # 创建数据库
    print_info "通过 Docker 创建数据库..."
    
    for db in "${DATABASES[@]}"; do
        print_info "创建数据库: $db"
        $docker_cmd exec sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$DB_PASSWORD" -Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '$db') CREATE DATABASE $db" 2>/dev/null && \
            print_success "已创建: $db" || \
            print_warning "跳过或失败: $db"
    done
    
    print_success "数据库创建完成"
}

# 创建目录结构
create_directories() {
    if [[ -d "$INSTALL_DIR" ]] && [[ "$FORCE_MODE" != "true" ]]; then
        print_skip "目录已存在，跳过创建"
        return
    fi
    
    print_info "创建目录结构..."
    
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$INSTALL_DIR/logs"
    mkdir -p "$WEB_DIR"
    mkdir -p "$WEB_DIR/qiantai"
    mkdir -p "$WEB_DIR/HT"
    mkdir -p "$WEB_DIR/admin"
    mkdir -p "$WEB_DIR/agent"
    mkdir -p "$WEB_DIR/Hall"
    mkdir -p "$LOG_DIR"
    mkdir -p "$CONFIG_DIR"
    
    print_success "目录创建完成"
    echo "  部署路径: $WEB_DIR"
    echo "  服务器路径: $INSTALL_DIR"
}

# 复制文件
copy_files() {
    print_info "复制项目文件..."
    
    local dirs=("qiantai" "HT" "admin" "agent" "Hall" "server")
    local count=0
    
    for dir in "${dirs[@]}"; do
        if [[ -d "$SCRIPT_DIR/$dir" ]]; then
            if [[ "$dir" == "server" ]]; then
                cp -r "$SCRIPT_DIR/$dir"/* "$INSTALL_DIR/" 2>/dev/null || true
            else
                cp -r "$SCRIPT_DIR/$dir"/* "$WEB_DIR/$dir/" 2>/dev/null || true
            fi
            print_success "已复制: $dir"
            ((count++))
        fi
    done
    
    print_success "文件复制完成 ($count 个目录)"
}

# 更新配置文件
update_configs() {
    print_info "更新数据库配置..."
    
    local connection_prefix="Data Source=$DB_SERVER,$DB_PORT"
    
    for dir in qiantai HT admin agent; do
        local config_file="$WEB_DIR/$dir/Web.config"
        
        if [[ -f "$config_file" ]]; then
            sed -i "s/Data Source=[^;]*;/Data Source=$DB_SERVER,$DB_PORT;/g" "$config_file"
            sed -i "s/User ID=[^;]*;/User ID=$DB_USER;/g" "$config_file"
            sed -i "s/Password=[^;]*;/Password=$DB_PASSWORD;/g" "$config_file"
            print_success "已更新: $dir/Web.config"
        fi
    done
}

# 生成启动脚本
generate_start_script() {
    print_info "生成启动脚本..."
    
    cat > "$CONFIG_DIR/start_services.sh" << 'EOF'
#!/bin/bash
# DDizhu 服务启动脚本

echo "启动 DDizhu 服务..."
echo "数据库: $DB_SERVER:$DB_PORT"

# 检查 SQL Server
if command -v docker &> /dev/null; then
    if docker ps | grep -q "sqlserver"; then
        echo "[OK] SQL Server 容器运行中"
    else
        echo "[WARN] SQL Server 容器未运行"
        echo "启动命令: docker start sqlserver"
    fi
fi

# 显示访问信息
echo ""
echo "=========================================="
echo "  服务已准备就绪"
echo "=========================================="
echo ""
echo "数据库配置："
echo "  地址: 127.0.0.1:1433"
echo "  用户: sa"
echo ""
echo "Web 文件位置："
echo "  /opt/ddizhu/www/"
echo ""
echo "=========================================="
EOF
    
    chmod +x "$CONFIG_DIR/start_services.sh"
    print_success "启动脚本已生成"
}

# 检查部署状态
check_status() {
    echo ""
    echo "=========================================="
    echo "  部署状态"
    echo "=========================================="
    echo ""
    
    # SQL Server
    echo -e "${CYAN}[SQL Server]${NC}"
    if nc -z localhost 1433 2>/dev/null; then
        echo -e "  状态: ${GREEN}可连接${NC}"
    else
        echo -e "  状态: ${RED}不可连接${NC}"
    fi
    
    # 目录
    echo ""
    echo -e "${CYAN}[目录]${NC}"
    for dir in "$INSTALL_DIR" "$WEB_DIR" "$CONFIG_DIR" "$LOG_DIR"; do
        if [[ -d "$dir" ]]; then
            echo -e "  $dir: ${GREEN}已创建${NC}"
        else
            echo -e "  $dir: ${RED}未创建${NC}"
        fi
    done
    
    # Web 文件
    echo ""
    echo -e "${CYAN}[Web 文件]${NC}"
    for dir in qiantai HT admin agent Hall; do
        if [[ -f "$WEB_DIR/$dir/Web.config" ]]; then
            echo -e "  $dir: ${GREEN}已部署${NC}"
        else
            echo -e "  $dir: ${RED}未部署${NC}"
        fi
    done
    
    echo ""
    echo "=========================================="
}

# 打印帮助
print_help() {
    echo ""
    echo "DDizhu 斗地主棋牌游戏平台 - 部署脚本"
    echo ""
    echo "使用方法: ./deploy.sh [选项]"
    echo ""
    echo "选项："
    echo "  --force     强制重新部署"
    echo "  --status    检查部署状态"
    echo "  --help      显示帮助"
    echo ""
    echo "SQL Server 配置 (Docker)："
    echo "  地址: 127.0.0.1:1433"
    echo "  用户: sa"
    echo "  密码: Admin@1234"
    echo ""
}

# 主函数
main() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --force) FORCE_MODE=true; shift ;;
            --status) check_status; exit 0 ;;
            --help|-h) print_help; exit 0 ;;
            *) print_error "未知选项: $1"; exit 1 ;;
        esac
    done
    
    echo ""
    echo "=========================================="
    echo "  DDizhu 斗地主棋牌游戏平台 - 一键部署"
    echo "=========================================="
    echo ""
    
    detect_environment
    check_sql_connection || true
    
    create_directories
    copy_files
    update_configs
    generate_start_script
    create_databases || true
    
    check_status
    
    echo ""
    echo "=========================================="
    echo -e "${GREEN}部署完成！${NC}"
    echo "=========================================="
    echo ""
    echo "数据库配置："
    echo "  地址: $DB_SERVER:$DB_PORT"
    echo "  用户: $DB_USER"
    echo "  密码: $DB_PASSWORD"
    echo ""
    echo "部署路径："
    echo "  Web: $WEB_DIR"
    echo "  服务器: $INSTALL_DIR"
    echo "  配置: $CONFIG_DIR"
    echo ""
    echo "下一步："
    echo "  查看状态: ./deploy.sh --status"
    echo ""
}

main "$@"
