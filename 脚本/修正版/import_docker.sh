#!/bin/bash
# =============================================
# 斗地主数据库导入脚本 (Docker版)
# 适用于: Docker SQL Server容器
# 使用方法: chmod +x import_docker.sh && ./import_docker.sh
# =============================================

# Docker容器名称
CONTAINER_NAME="sqlserver"
SQL_USER="sa"
SQL_PASS="Admin@1234"

# 脚本根目录
SCRIPT_DIR="/home/z/ddizhu/脚本/猫推领航版数据库脚本2016.7.20/平台脚本代码"
FIXED_DIR="/home/z/ddizhu/脚本/修正版"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "  斗地主数据库导入脚本 (Docker版)"
echo "=========================================="
echo ""

# 检查Docker容器是否运行
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo -e "${RED}错误: Docker容器 '$CONTAINER_NAME' 未运行${NC}"
    echo "请先启动SQL Server容器:"
    echo "  docker start $CONTAINER_NAME"
    exit 1
fi

# 在容器内创建临时目录
docker exec $CONTAINER_NAME mkdir -p /tmp/sql_scripts 2>/dev/null

# 函数: 复制并执行SQL文件
run_sql_in_docker() {
    local sql_file="$1"
    local description="$2"
    
    if [ -f "$sql_file" ]; then
        echo -e "${YELLOW}执行: $description${NC}"
        
        # 处理UTF-16编码文件
        local temp_file="/tmp/temp_$(basename $sql_file)"
        if file "$sql_file" | grep -q "UTF-16LE\|UTF-16"; then
            iconv -f UTF-16LE -t UTF-8 "$sql_file" > "$temp_file" 2>/dev/null || cp "$sql_file" "$temp_file"
        else
            cp "$sql_file" "$temp_file"
        fi
        
        # 复制到容器
        docker cp "$temp_file" $CONTAINER_NAME:/tmp/sql_scripts/script.sql
        
        # 在容器内执行
        docker exec $CONTAINER_NAME /opt/mssql-tools18/bin/sqlcmd \
            -S localhost -U "$SQL_USER" -P "$SQL_PASS" \
            -i /tmp/sql_scripts/script.sql -C -b 2>&1
        
        rm -f "$temp_file"
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ 完成${NC}"
        else
            echo -e "${RED}✗ 可能存在错误${NC}"
        fi
        echo ""
    fi
}

# 函数: 执行目录下所有SQL文件
run_sql_dir_in_docker() {
    local dir="$1"
    local description="$2"
    
    echo "=========================================="
    echo "  $description"
    echo "=========================================="
    
    for sql_file in "$dir"/*.sql; do
        if [ -f "$sql_file" ]; then
            filename=$(basename "$sql_file")
            run_sql_in_docker "$sql_file" "$filename"
        fi
    done
}

# 步骤1: 创建数据库
echo ""
echo "=========================================="
echo "  步骤1: 创建数据库"
echo "=========================================="
run_sql_in_docker "$FIXED_DIR/0_创建数据库.sql" "创建7个数据库"

# 步骤2: 创建表结构
echo ""
echo "=========================================="
echo "  步骤2: 创建表结构"
echo "=========================================="

run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_1_用户库脚本.sql" "用户库表结构"
run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_2_平台库脚本.sql" "平台库表结构"
run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_3_金豆库脚本.sql" "金豆库表结构"
run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_4_记录库脚本.sql" "记录库表结构"
run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_5_积分库脚本.sql" "积分库表结构"
run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_6_比赛库脚本.sql" "比赛库表结构"
run_sql_in_docker "$SCRIPT_DIR/数据库脚本/2_7_练习库脚本.sql" "练习库表结构"

# 步骤3: 插入基础数据
echo ""
echo "=========================================="
echo "  步骤3: 插入基础数据"
echo "=========================================="

run_sql_in_docker "$SCRIPT_DIR/数据脚本/用户链接.sql" "用户链接服务器"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/财富链接.sql" "财富链接服务器"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/记录链接.sql" "记录链接服务器"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/平台链接.sql" "平台链接服务器"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/比赛链接.sql" "比赛链接服务器"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/道具配置.sql" "道具配置"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/系统配置.sql" "系统配置"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/会员类型.sql" "会员类型"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/签到配置.sql" "签到配置"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/等级配置.sql" "等级配置"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/类型配置.sql" "类型配置"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/抽奖配置.sql" "抽奖配置"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/抽奖参数.sql" "抽奖参数"
run_sql_in_docker "$SCRIPT_DIR/数据脚本/标识生成.sql" "标识生成"

# 步骤4: 创建存储过程
echo ""
echo "=========================================="
echo "  步骤4: 创建存储过程"
echo "=========================================="

run_sql_dir_in_docker "$SCRIPT_DIR/存储过程/用户数据库" "用户数据库存储过程"
run_sql_dir_in_docker "$SCRIPT_DIR/存储过程/平台数据库" "平台数据库存储过程"
run_sql_dir_in_docker "$SCRIPT_DIR/存储过程/金豆数据库" "金豆数据库存储过程"
run_sql_dir_in_docker "$SCRIPT_DIR/存储过程/积分数据库" "积分数据库存储过程"
run_sql_dir_in_docker "$SCRIPT_DIR/存储过程/比赛数据库" "比赛数据库存储过程"
run_sql_dir_in_docker "$SCRIPT_DIR/存储过程/练习数据库" "练习数据库存储过程"

# 清理
docker exec $CONTAINER_NAME rm -rf /tmp/sql_scripts 2>/dev/null

echo ""
echo "=========================================="
echo -e "${GREEN}  数据库导入完成！${NC}"
echo "=========================================="
