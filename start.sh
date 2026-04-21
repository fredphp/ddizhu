#!/bin/bash

#######################################################################
# DDizhu 斗地主棋牌游戏平台 - 一键启动脚本 (WSL 版本)
# 适用系统：Windows WSL (Windows Subsystem for Linux)
# 使用方法：./start.sh [选项]
# 选项：
#   --web      仅启动 Web 服务
#   --game     仅启动游戏服务器
#   --all      启动所有服务（默认）
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
SERVER_DIR="/mnt/c/GameServer"
WEB_DIR="/mnt/c/www/ddizhu"
LOG_DIR="/mnt/c/GameServer/logs"
PID_DIR="/mnt/c/GameServer/pids"

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

# 检查进程是否运行 (通过 PID 文件)
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
        print_info "Windows 路径: C:\\GameServer"
        print_info "请先运行 ./deploy.sh 进行部署"
        return 1
    fi
    
    cd "$SERVER_DIR"
    
    local started_count=0
    local skipped_count=0
    
    # 检查并启动中心服务器
    if is_win_process_running "Center.exe"; then
        print_skip "中心服务器已在运行中"
        ((skipped_count++))
    else
        if [[ -f "Center.exe" ]]; then
            print_info "启动中心服务器..."
            if command -v cmd.exe &> /dev/null; then
                cmd.exe /c "start \"Center Server\" C:\\GameServer\\Center.exe" 2>/dev/null
            else
                ./Center.exe &
            fi
            sleep 3
            print_success "中心服务器启动完成"
            ((started_count++))
        else
            print_warning "Center.exe 不存在，跳过"
        fi
    fi
    
    # 检查并启动登录服务器
    if is_win_process_running "MTSvrLogon.exe"; then
        print_skip "登录服务器已在运行中"
        ((skipped_count++))
    else
        if [[ -f "MTSvrLogon.exe" ]]; then
            print_info "启动登录服务器..."
            if command -v cmd.exe &> /dev/null; then
                cmd.exe /c "start \"Logon Server\" C:\\GameServer\\MTSvrLogon.exe" 2>/dev/null
            else
                ./MTSvrLogon.exe &
            fi
            sleep 3
            print_success "登录服务器启动完成"
            ((started_count++))
        else
            print_warning "MTSvrLogon.exe 不存在，跳过"
        fi
    fi
    
    # 检查并启动游戏服务器
    if is_win_process_running "GameServer.exe"; then
        print_skip "游戏服务器已在运行中"
        ((skipped_count++))
    else
        if [[ -f "GameServer.exe" ]]; then
            print_info "启动游戏服务器..."
            if command -v cmd.exe &> /dev/null; then
                cmd.exe /c "start \"Game Server\" C:\\GameServer\\GameServer.exe" 2>/dev/null
            else
                ./GameServer.exe &
            fi
            sleep 3
            print_success "游戏服务器启动完成"
            ((started_count++))
        else
            print_warning "GameServer.exe 不存在，跳过"
        fi
    fi
    
    echo ""
    if [[ $started_count -gt 0 ]]; then
        print_success "启动了 $started_count 个服务"
    fi
    if [[ $skipped_count -gt 0 ]]; then
        print_info "跳过了 $skipped_count 个已运行的服务"
    fi
}

# 启动 Web 服务 (IIS)
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
            print_warning "无法检测 IIS 服务状态"
            print_info "尝试启动 IIS 服务..."
            powershell.exe -Command "Start-Service w3svc" 2>/dev/null || {
                print_error "IIS 服务启动失败，请检查是否已安装 IIS"
            }
        fi
    else
        print_warning "PowerShell 不可用"
        print_info "请手动启动 IIS: 在 Windows 中运行 'net start w3svc'"
    fi
}

# 停止游戏服务器
stop_game_server() {
    print_info "停止游戏服务器..."
    
    if command -v taskkill.exe &> /dev/null; then
        local stopped_count=0
        
        # 停止游戏服务器
        if is_win_process_running "GameServer.exe"; then
            print_info "停止 GameServer.exe..."
            taskkill.exe //IM GameServer.exe //F 2>/dev/null || true
            print_success "游戏服务器已停止"
            ((stopped_count++))
        else
            print_skip "游戏服务器未运行"
        fi
        
        # 停止登录服务器
        if is_win_process_running "MTSvrLogon.exe"; then
            print_info "停止 MTSvrLogon.exe..."
            taskkill.exe //IM MTSvrLogon.exe //F 2>/dev/null || true
            print_success "登录服务器已停止"
            ((stopped_count++))
        else
            print_skip "登录服务器未运行"
        fi
        
        # 停止中心服务器
        if is_win_process_running "Center.exe"; then
            print_info "停止 Center.exe..."
            taskkill.exe //IM Center.exe //F 2>/dev/null || true
            print_success "中心服务器已停止"
            ((stopped_count++))
        else
            print_skip "中心服务器未运行"
        fi
        
        if [[ $stopped_count -eq 0 ]]; then
            print_info "没有运行中的游戏服务器"
        fi
    else
        print_warning "taskkill 命令不可用"
        print_info "请手动停止游戏服务器"
    fi
    
    # 清理 PID 文件
    rm -f "$CENTER_PID" "$LOGON_PID" "$GAME_PID" 2>/dev/null || true
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
        print_info "请手动停止 IIS: 在 Windows 中运行 'net stop w3svc'"
    fi
}

# 查看服务状态
show_status() {
    echo ""
    echo "=========================================="
    echo "  DDizhu 服务状态 (WSL)"
    echo "=========================================="
    echo ""
    
    echo -e "${CYAN}[游戏服务器]${NC}"
    
    # 检查 Windows 进程
    if command -v tasklist.exe &> /dev/null; then
        # 中心服务器
        if is_win_process_running "Center.exe"; then
            echo -e "  中心服务器: ${GREEN}运行中${NC}"
        else
            echo -e "  中心服务器: ${RED}未运行${NC}"
        fi
        
        # 登录服务器
        if is_win_process_running "MTSvrLogon.exe"; then
            echo -e "  登录服务器: ${GREEN}运行中${NC}"
        else
            echo -e "  登录服务器: ${RED}未运行${NC}"
        fi
        
        # 游戏服务器
        if is_win_process_running "GameServer.exe"; then
            echo -e "  游戏服务器: ${GREEN}运行中${NC}"
        else
            echo -e "  游戏服务器: ${RED}未运行${NC}"
        fi
    else
        echo -e "  无法检测进程状态 (tasklist 不可用)"
    fi
    
    echo ""
    echo -e "${CYAN}[Web 服务]${NC}"
    
    # IIS 状态
    if command -v powershell.exe &> /dev/null; then
        local status=$(powershell.exe -Command "(Get-Service w3svc -ErrorAction SilentlyContinue).Status" 2>/dev/null | tr -d '\r')
        
        if [[ "$status" == "Running" ]]; then
            echo -e "  IIS 服务: ${GREEN}运行中${NC}"
        elif [[ "$status" == "Stopped" ]]; then
            echo -e "  IIS 服务: ${RED}已停止${NC}"
        else
            echo -e "  IIS 服务: ${YELLOW}未知状态${NC}"
        fi
        
        # 检查网站状态
        echo ""
        echo -e "${CYAN}[网站状态]${NC}"
        local sites=("DDizhu_Web:80" "DDizhu_HT:8080" "DDizhu_Admin:8081" "DDizhu_Agent:8082" "DDizhu_Hall:8083")
        for site_info in "${sites[@]}"; do
            local site_name="${site_info%%:*}"
            local site_port="${site_info##*:}"
            local site_state=$(powershell.exe -Command "(Get-Website -Name '$site_name' -ErrorAction SilentlyContinue).State" 2>/dev/null | tr -d '\r')
            
            if [[ "$site_state" == "Started" ]]; then
                echo -e "  $site_name (:$site_port): ${GREEN}已启动${NC}"
            elif [[ -n "$site_state" ]]; then
                echo -e "  $site_name (:$site_port): ${YELLOW}$site_state${NC}"
            else
                echo -e "  $site_name (:$site_port): ${RED}未配置${NC}"
            fi
        done
    else
        echo -e "  IIS 服务: ${YELLOW}无法检测${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}[数据库连接]${NC}"
    
    # 检查 SQL Server 端口
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
        echo "日志目录: C:\\GameServer\\logs"
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
        print_warning "日志目录不存在: C:\\GameServer\\logs"
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
    echo "特性："
    echo "  - 自动跳过已运行的服务，不会重复启动"
    echo "  - 智能检测服务状态"
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
            print_success "启动完成！"
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
