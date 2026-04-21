#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 一键启动脚本
# 适用系统：Windows (通过 Git Bash 或 WSL 运行)
# 使用方法：./start.sh [选项]
# 选项：
#   --web      仅启动 Web 服务
#   --game     仅启动游戏服务器
#   --all      启动所有服务（默认）
#   --stop     停止所有服务
#   --status   查看服务状态
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置变量
SERVER_DIR="/c/GameServer/server"
WEB_DIR="/c/www/ddizhu"
LOG_DIR="/c/GameServer/logs"

# 进程文件
PID_DIR="/c/GameServer/pids"
CENTER_PID="$PID_DIR/center.pid"
LOGON_PID="$PID_DIR/logon.pid"
GAME_PID="$PID_DIR/game.pid"

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

# 创建必要的目录
init_dirs() {
    mkdir -p "$LOG_DIR"
    mkdir -p "$PID_DIR"
}

# 检查进程是否运行
is_running() {
    local pid_file=$1
    if [[ -f "$pid_file" ]]; then
        local pid=$(cat "$pid_file")
        if ps -p "$pid" > /dev/null 2>&1; then
            return 0
        fi
    fi
    return 1
}

# 启动游戏服务器
start_game_server() {
    print_info "启动游戏服务器..."
    
    if [[ ! -d "$SERVER_DIR" ]]; then
        print_error "服务器目录不存在: $SERVER_DIR"
        return 1
    fi
    
    cd "$SERVER_DIR"
    
    # 检查并启动中心服务器
    if is_running "$CENTER_PID"; then
        print_warning "中心服务器已在运行中"
    else
        if [[ -f "Center.exe" ]]; then
            print_info "启动中心服务器..."
            ./Center.exe > "$LOG_DIR/center.log" 2>&1 &
            echo $! > "$CENTER_PID"
            sleep 3
            print_success "中心服务器启动完成 (PID: $(cat $CENTER_PID))"
        else
            print_warning "Center.exe 不存在，跳过"
        fi
    fi
    
    # 检查并启动登录服务器
    if is_running "$LOGON_PID"; then
        print_warning "登录服务器已在运行中"
    else
        if [[ -f "MTSvrLogon.exe" ]]; then
            print_info "启动登录服务器..."
            ./MTSvrLogon.exe > "$LOG_DIR/logon.log" 2>&1 &
            echo $! > "$LOGON_PID"
            sleep 3
            print_success "登录服务器启动完成 (PID: $(cat $LOGON_PID))"
        else
            print_warning "MTSvrLogon.exe 不存在，跳过"
        fi
    fi
    
    # 检查并启动游戏服务器
    if is_running "$GAME_PID"; then
        print_warning "游戏服务器已在运行中"
    else
        if [[ -f "GameServer.exe" ]]; then
            print_info "启动游戏服务器..."
            ./GameServer.exe > "$LOG_DIR/game.log" 2>&1 &
            echo $! > "$GAME_PID"
            sleep 3
            print_success "游戏服务器启动完成 (PID: $(cat $GAME_PID))"
        else
            print_warning "GameServer.exe 不存在，跳过"
        fi
    fi
}

# 启动 Web 服务
start_web_server() {
    print_info "启动 Web 服务..."
    
    # 检查 IIS 服务状态
    if command -v net &> /dev/null; then
        print_info "检查 IIS 服务..."
        net start w3svc 2>/dev/null || print_warning "IIS 服务可能未安装或已启动"
        print_success "Web 服务已就绪"
    else
        print_warning "无法启动 IIS，请手动启动"
    fi
}

# 停止游戏服务器
stop_game_server() {
    print_info "停止游戏服务器..."
    
    # 停止游戏服务器
    if is_running "$GAME_PID"; then
        local pid=$(cat "$GAME_PID")
        print_info "停止游戏服务器 (PID: $pid)..."
        taskkill //PID $pid //F 2>/dev/null || kill $pid 2>/dev/null || true
        rm -f "$GAME_PID"
        print_success "游戏服务器已停止"
    else
        print_warning "游戏服务器未运行"
    fi
    
    # 停止登录服务器
    if is_running "$LOGON_PID"; then
        local pid=$(cat "$LOGON_PID")
        print_info "停止登录服务器 (PID: $pid)..."
        taskkill //PID $pid //F 2>/dev/null || kill $pid 2>/dev/null || true
        rm -f "$LOGON_PID"
        print_success "登录服务器已停止"
    else
        print_warning "登录服务器未运行"
    fi
    
    # 停止中心服务器
    if is_running "$CENTER_PID"; then
        local pid=$(cat "$CENTER_PID")
        print_info "停止中心服务器 (PID: $pid)..."
        taskkill //PID $pid //F 2>/dev/null || kill $pid 2>/dev/null || true
        rm -f "$CENTER_PID"
        print_success "中心服务器已停止"
    else
        print_warning "中心服务器未运行"
    fi
}

# 停止 Web 服务
stop_web_server() {
    print_info "停止 Web 服务..."
    
    if command -v net &> /dev/null; then
        net stop w3svc 2>/dev/null || print_warning "IIS 服务停止失败或未运行"
        print_success "Web 服务已停止"
    else
        print_warning "请手动停止 IIS 服务"
    fi
}

# 查看服务状态
show_status() {
    echo ""
    echo "=========================================="
    echo "  DDizhu 服务状态"
    echo "=========================================="
    echo ""
    
    echo -e "${CYAN}[游戏服务器]${NC}"
    
    # 中心服务器
    if is_running "$CENTER_PID"; then
        echo -e "  中心服务器: ${GREEN}运行中${NC} (PID: $(cat $CENTER_PID))"
    else
        echo -e "  中心服务器: ${RED}未运行${NC}"
    fi
    
    # 登录服务器
    if is_running "$LOGON_PID"; then
        echo -e "  登录服务器: ${GREEN}运行中${NC} (PID: $(cat $LOGON_PID))"
    else
        echo -e "  登录服务器: ${RED}未运行${NC}"
    fi
    
    # 游戏服务器
    if is_running "$GAME_PID"; then
        echo -e "  游戏服务器: ${GREEN}运行中${NC} (PID: $(cat $GAME_PID))"
    else
        echo -e "  游戏服务器: ${RED}未运行${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}[Web 服务]${NC}"
    
    # IIS 状态
    if command -v sc &> /dev/null; then
        if sc query w3svc | grep -q "RUNNING"; then
            echo -e "  IIS 服务: ${GREEN}运行中${NC}"
        else
            echo -e "  IIS 服务: ${RED}未运行${NC}"
        fi
    else
        echo -e "  IIS 服务: ${YELLOW}无法检测${NC}"
    fi
    
    echo ""
    echo "=========================================="
    echo ""
    echo "访问地址："
    echo "  - 前台网站: http://localhost"
    echo "  - 后台管理: http://localhost:8080"
    echo "  - 管理员:   http://localhost:8081"
    echo "  - 代理商:   http://localhost:8082"
    echo "  - 游戏大厅: http://localhost:8083"
    echo "=========================================="
}

# 查看日志
show_logs() {
    echo ""
    echo "=========================================="
    echo "  服务日志"
    echo "=========================================="
    echo ""
    
    if [[ -d "$LOG_DIR" ]]; then
        echo "日志目录: $LOG_DIR"
        echo ""
        for log in "$LOG_DIR"/*.log; do
            if [[ -f "$log" ]]; then
                echo "--- $(basename $log) (最后20行) ---"
                tail -20 "$log"
                echo ""
            fi
        done
    else
        print_warning "日志目录不存在"
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
    echo "  --web        仅启动 Web 服务"
    echo "  --game       仅启动游戏服务器"
    echo "  --stop       停止所有服务"
    echo "  --status     查看服务状态"
    echo "  --logs       查看服务日志"
    echo "  --help       显示帮助信息"
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
            echo "  DDizhu - 启动所有服务"
            echo "=========================================="
            echo ""
            start_web_server
            start_game_server
            echo ""
            print_success "所有服务启动完成！"
            show_status
            ;;
        --web)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 启动 Web 服务"
            echo "=========================================="
            echo ""
            start_web_server
            ;;
        --game)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 启动游戏服务器"
            echo "=========================================="
            echo ""
            start_game_server
            ;;
        --stop)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 停止所有服务"
            echo "=========================================="
            echo ""
            stop_game_server
            stop_web_server
            print_success "所有服务已停止"
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

# 执行主函数
main "$@"
