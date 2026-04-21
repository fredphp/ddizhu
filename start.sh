#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 启动脚本 (WSL 版本)
# 项目运行在 WSL Linux 环境中
# 使用方法：./start.sh [选项]
# 选项：
#   --web      启动 Web 服务
#   --game     启动游戏服务器（需要 Wine）
#   --all      启动所有服务
#   --stop     停止所有服务
#   --status   查看服务状态
#   --logs     查看服务日志
#   --help     显示帮助信息
#######################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# WSL 路径配置
SERVER_DIR="/opt/ddizhu/server"
WEB_DIR="/opt/ddizhu/www"
LOG_DIR="/opt/ddizhu/logs"
CONFIG_DIR="/opt/ddizhu/config"
PID_DIR="/opt/ddizhu/pids"

# 进程文件
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

print_skip() {
    echo -e "${CYAN}[SKIP]${NC} $1"
}

# 创建必要的目录
init_dirs() {
    mkdir -p "$LOG_DIR" 2>/dev/null || true
    mkdir -p "$PID_DIR" 2>/dev/null || true
}

# 检查 Windows 进程是否运行
is_win_process_running() {
    local process_name=$1
    
    if command -v tasklist.exe &> /dev/null; then
        if tasklist.exe 2>/dev/null | grep -qi "$process_name"; then
            return 0
        fi
    fi
    return 1
}

# 启动游戏服务器 (需要 Wine 或在 Windows 中运行)
start_game_server() {
    print_info "启动游戏服务器..."
    
    if [[ ! -d "$SERVER_DIR" ]]; then
        print_error "服务器目录不存在: $SERVER_DIR"
        print_info "请先运行 ./deploy.sh 进行部署"
        return 1
    fi
    
    cd "$SERVER_DIR"
    
    # 检查服务器文件
    if [[ ! -f "Center.exe" ]] && [[ ! -f "GameServer.exe" ]]; then
        print_warning "服务器可执行文件不存在"
        print_info "游戏服务器是 Windows 程序，需要通过以下方式运行："
        echo ""
        echo "  方式一: 在 Windows 中直接运行"
        echo "    路径: \\\\wsl$\\<发行版名称>\\opt\\ddizhu\\server\\"
        echo ""
        echo "  方式二: 使用 Wine 运行 (需要先安装 Wine)"
        echo "    sudo apt install wine64"
        echo "    wine Center.exe"
        echo ""
        return 1
    fi
    
    # 检查 Wine
    if command -v wine &> /dev/null; then
        print_info "使用 Wine 启动服务器..."
        
        # Center
        if is_center_running; then
            print_skip "Center 已运行"
        else
            print_info "启动 Center..."
            wine Center.exe > "$LOG_DIR/center.log" 2>&1 &
            echo $! > "$CENTER_PID"
            sleep 3
            print_success "Center 启动完成"
        fi
        
        # Logon
        if is_logon_running; then
            print_skip "Logon 已运行"
        else
            print_info "启动 Logon..."
            wine MTSvrLogon.exe > "$LOG_DIR/logon.log" 2>&1 &
            echo $! > "$LOGON_PID"
            sleep 3
            print_success "Logon 启动完成"
        fi
        
        # GameServer
        if is_game_running; then
            print_skip "GameServer 已运行"
        else
            print_info "启动 GameServer..."
            wine GameServer.exe > "$LOG_DIR/game.log" 2>&1 &
            echo $! > "$GAME_PID"
            sleep 3
            print_success "GameServer 启动完成"
        fi
    else
        print_warning "Wine 未安装，无法在 WSL 中直接运行 Windows 程序"
        print_info "安装 Wine: sudo apt install wine64"
        echo ""
        
        # 尝试通过 Windows 启动
        if command -v cmd.exe &> /dev/null; then
            read -p "是否尝试在 Windows 中启动服务器？(y/N): " start_in_win
            if [[ "$start_in_win" =~ ^[Yy]$ ]]; then
                start_game_server_in_windows
            fi
        fi
    fi
}

# 在 Windows 中启动游戏服务器
start_game_server_in_windows() {
    print_info "在 Windows 中启动游戏服务器..."
    
    # 获取 WSL 路径对应的 Windows 路径
    local win_path=$(wslpath -w "$SERVER_DIR" 2>/dev/null)
    
    if [[ -n "$win_path" ]]; then
        print_info "服务器路径: $win_path"
        
        # 使用 cmd.exe 启动
        cmd.exe /c "start \"DDizhu Center\" /D \"$win_path\" Center.exe" 2>/dev/null &
        sleep 3
        
        cmd.exe /c "start \"DDizhu Logon\" /D \"$win_path\" MTSvrLogon.exe" 2>/dev/null &
        sleep 3
        
        cmd.exe /c "start \"DDizhu GameServer\" /D \"$win_path\" GameServer.exe" 2>/dev/null &
        sleep 3
        
        print_success "服务器已在 Windows 中启动"
    else
        print_error "无法获取 Windows 路径"
    fi
}

# 检查进程状态
is_center_running() {
    if [[ -f "$CENTER_PID" ]]; then
        local pid=$(cat "$CENTER_PID")
        if ps -p "$pid" > /dev/null 2>&1; then
            return 0
        fi
    fi
    return 1
}

is_logon_running() {
    if [[ -f "$LOGON_PID" ]]; then
        local pid=$(cat "$LOGON_PID")
        if ps -p "$pid" > /dev/null 2>&1; then
            return 0
        fi
    fi
    return 1
}

is_game_running() {
    if [[ -f "$GAME_PID" ]]; then
        local pid=$(cat "$GAME_PID")
        if ps -p "$pid" > /dev/null 2>&1; then
            return 0
        fi
    fi
    return 1
}

# 启动 Web 服务 (IIS 在 Windows 中)
start_web_server() {
    print_info "启动 Web 服务..."
    
    if command -v powershell.exe &> /dev/null; then
        # 检查 IIS 服务状态
        local status=$(powershell.exe -Command "(Get-Service w3svc -ErrorAction SilentlyContinue).Status" 2>/dev/null | tr -d '\r')
        
        if [[ "$status" == "Running" ]]; then
            print_skip "IIS 服务已在运行中"
        elif [[ "$status" == "Stopped" ]]; then
            print_info "启动 IIS 服务..."
            powershell.exe -Command "Start-Service w3svc" 2>/dev/null
            sleep 2
            print_success "IIS 服务已启动"
        else
            print_warning "无法检测 IIS 状态"
            print_info "请确保 IIS 已安装并配置"
        fi
    else
        print_warning "PowerShell 不可用"
        print_info "请在 Windows 中手动启动 IIS: net start w3svc"
    fi
}

# 停止游戏服务器
stop_game_server() {
    print_info "停止游戏服务器..."
    
    local stopped=false
    
    # 停止 Wine 进程
    if is_game_running; then
        local pid=$(cat "$GAME_PID")
        kill "$pid" 2>/dev/null || true
        rm -f "$GAME_PID"
        print_success "GameServer 已停止"
        stopped=true
    fi
    
    if is_logon_running; then
        local pid=$(cat "$LOGON_PID")
        kill "$pid" 2>/dev/null || true
        rm -f "$LOGON_PID"
        print_success "Logon 已停止"
        stopped=true
    fi
    
    if is_center_running; then
        local pid=$(cat "$CENTER_PID")
        kill "$pid" 2>/dev/null || true
        rm -f "$CENTER_PID"
        print_success "Center 已停止"
        stopped=true
    fi
    
    # 停止 Windows 进程
    if command -v taskkill.exe &> /dev/null; then
        if is_win_process_running "GameServer.exe"; then
            taskkill.exe //IM GameServer.exe //F 2>/dev/null || true
            print_success "GameServer (Windows) 已停止"
            stopped=true
        fi
        
        if is_win_process_running "MTSvrLogon.exe"; then
            taskkill.exe //IM MTSvrLogon.exe //F 2>/dev/null || true
            print_success "Logon (Windows) 已停止"
            stopped=true
        fi
        
        if is_win_process_running "Center.exe"; then
            taskkill.exe //IM Center.exe //F 2>/dev/null || true
            print_success "Center (Windows) 已停止"
            stopped=true
        fi
    fi
    
    if [[ "$stopped" != "true" ]]; then
        print_info "没有运行中的游戏服务器"
    fi
}

# 停止 Web 服务
stop_web_server() {
    print_info "停止 Web 服务..."
    
    if command -v powershell.exe &> /dev/null; then
        local status=$(powershell.exe -Command "(Get-Service w3svc -ErrorAction SilentlyContinue).Status" 2>/dev/null | tr -d '\r')
        
        if [[ "$status" == "Running" ]]; then
            powershell.exe -Command "Stop-Service w3svc" 2>/dev/null
            print_success "IIS 服务已停止"
        else
            print_skip "IIS 服务未运行"
        fi
    else
        print_warning "PowerShell 不可用"
        print_info "请在 Windows 中手动停止 IIS: net stop w3svc"
    fi
}

# 查看服务状态
show_status() {
    echo ""
    echo "=========================================="
    echo "  DDizhu 服务状态 (WSL)"
    echo "=========================================="
    echo ""
    
    # 游戏服务器状态
    echo -e "${CYAN}[游戏服务器]${NC}"
    
    if is_center_running; then
        echo -e "  Center: ${GREEN}运行中${NC} (PID: $(cat $CENTER_PID))"
    else
        if is_win_process_running "Center.exe"; then
            echo -e "  Center: ${GREEN}运行中 (Windows)${NC}"
        else
            echo -e "  Center: ${RED}未运行${NC}"
        fi
    fi
    
    if is_logon_running; then
        echo -e "  Logon: ${GREEN}运行中${NC} (PID: $(cat $LOGON_PID))"
    else
        if is_win_process_running "MTSvrLogon.exe"; then
            echo -e "  Logon: ${GREEN}运行中 (Windows)${NC}"
        else
            echo -e "  Logon: ${RED}未运行${NC}"
        fi
    fi
    
    if is_game_running; then
        echo -e "  GameServer: ${GREEN}运行中${NC} (PID: $(cat $GAME_PID))"
    else
        if is_win_process_running "GameServer.exe"; then
            echo -e "  GameServer: ${GREEN}运行中 (Windows)${NC}"
        else
            echo -e "  GameServer: ${RED}未运行${NC}"
        fi
    fi
    
    echo ""
    echo -e "${CYAN}[Web 服务]${NC}"
    
    if command -v powershell.exe &> /dev/null; then
        local status=$(powershell.exe -Command "(Get-Service w3svc -ErrorAction SilentlyContinue).Status" 2>/dev/null | tr -d '\r')
        
        if [[ "$status" == "Running" ]]; then
            echo -e "  IIS 服务: ${GREEN}运行中${NC}"
        elif [[ "$status" == "Stopped" ]]; then
            echo -e "  IIS 服务: ${RED}已停止${NC}"
        else
            echo -e "  IIS 服务: ${YELLOW}未知状态${NC}"
        fi
    else
        echo -e "  IIS 服务: ${YELLOW}无法检测${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}[数据库连接]${NC}"
    
    if command -v powershell.exe &> /dev/null; then
        local sql_status=$(powershell.exe -Command "Test-NetConnection -ComputerName localhost -Port 1433 -InformationLevel Quiet -WarningAction SilentlyContinue" 2>/dev/null | tr -d '\r')
        if [[ "$sql_status" == "True" ]]; then
            echo -e "  SQL Server (1433): ${GREEN}可连接${NC}"
        else
            echo -e "  SQL Server (1433): ${RED}无法连接${NC}"
        fi
    else
        echo -e "  SQL Server: ${YELLOW}无法检测${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}[磁盘空间]${NC}"
    df -h /opt 2>/dev/null | tail -1 | awk '{print "  可用: " $4 " / 总计: " $2}'
    
    echo ""
    echo "=========================================="
    echo ""
    echo "部署路径："
    echo "  Web: $WEB_DIR"
    echo "  服务器: $SERVER_DIR"
    echo "  日志: $LOG_DIR"
    echo ""
    echo "访问地址（配置 IIS 后）："
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
        
        local found_logs=false
        for log in "$LOG_DIR"/*.log; do
            if [[ -f "$log" ]]; then
                found_logs=true
                echo "--- $(basename $log) (最后20行) ---"
                tail -20 "$log" 2>/dev/null || echo "无法读取日志"
                echo ""
            fi
        done
        
        if [[ "$found_logs" != "true" ]]; then
            print_warning "日志目录中没有日志文件"
        fi
    else
        print_warning "日志目录不存在: $LOG_DIR"
    fi
}

# 打印帮助
print_help() {
    echo ""
    echo "DDizhu 斗地主棋牌游戏平台 - 启动脚本 (WSL 版本)"
    echo ""
    echo "使用方法: ./start.sh [选项]"
    echo ""
    echo "选项："
    echo "  --all        启动所有服务（默认）"
    echo "  --web        仅启动 Web 服务 (IIS)"
    echo "  --game       仅启动游戏服务器"
    echo "  --stop       停止所有服务"
    echo "  --status     查看服务状态"
    echo "  --logs       查看服务日志"
    echo "  --help       显示帮助信息"
    echo ""
    echo "说明："
    echo "  - 游戏服务器是 Windows 程序，可通过 Wine 或在 Windows 中运行"
    echo "  - Web 服务需要配置 Windows IIS"
    echo "  - 部署路径: /opt/ddizhu/"
    echo ""
    echo "示例："
    echo "  ./start.sh           # 启动所有服务"
    echo "  ./start.sh --status  # 查看服务状态"
    echo "  ./start.sh --stop    # 停止所有服务"
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
            echo "  DDizhu - 启动所有服务 (WSL)"
            echo "=========================================="
            echo ""
            start_web_server
            start_game_server
            echo ""
            show_status
            ;;
        --web)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 启动 Web 服务 (WSL)"
            echo "=========================================="
            echo ""
            start_web_server
            ;;
        --game)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 启动游戏服务器 (WSL)"
            echo "=========================================="
            echo ""
            start_game_server
            ;;
        --stop)
            echo ""
            echo "=========================================="
            echo "  DDizhu - 停止所有服务 (WSL)"
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
