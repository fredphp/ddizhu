#!/bin/bash
# =============================================
# 斗地主数据库导入脚本
# 适用于: Docker SQL Server (localhost:1433)
# 使用方法: chmod +x import_all.sh && ./import_all.sh
# =============================================

# 数据库连接信息
SQL_SERVER="localhost,1433"
SQL_USER="sa"
SQL_PASS="Admin@1234"

# 脚本根目录
SCRIPT_DIR="/home/z/ddizhu/脚本/猫推领航版数据库脚本2016.7.20/平台脚本代码"
FIXED_DIR="/home/z/ddizhu/脚本/修正版"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  斗地主数据库导入脚本"
echo "=========================================="
echo ""

# 检查sqlcmd是否安装
if ! command -v sqlcmd &> /dev/null; then
    echo -e "${RED}错误: sqlcmd 未安装${NC}"
    echo "请安装 Microsoft ODBC Tools:"
    echo "  Ubuntu/Debian: sudo apt-get install mssql-tools unixodbc-dev"
    echo "  或使用 Docker 容器执行"
    exit 1
fi

# 函数: 执行SQL文件
run_sql() {
    local sql_file="$1"
    local description="$2"
    
    if [ -f "$sql_file" ]; then
        echo -e "${YELLOW}执行: $description${NC}"
        echo "文件: $sql_file"
        
        # 尝试检测文件编码并转换
        if file "$sql_file" | grep -q "UTF-16LE\|UTF-16"; then
            # UTF-16编码文件，转换后执行
            iconv -f UTF-16LE -t UTF-8 "$sql_file" | sqlcmd -S "$SQL_SERVER" -U "$SQL_USER" -P "$SQL_PASS" -C -b -r1 2>&1
        else
            sqlcmd -S "$SQL_SERVER" -U "$SQL_USER" -P "$SQL_PASS" -i "$sql_file" -C -b -r1 2>&1
        fi
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ 完成${NC}"
        else
            echo -e "${RED}✗ 失败${NC}"
        fi
        echo ""
    else
        echo -e "${RED}文件不存在: $sql_file${NC}"
    fi
}

# 函数: 执行目录下所有SQL文件
run_sql_dir() {
    local dir="$1"
    local description="$2"
    
    echo "=========================================="
    echo "  $description"
    echo "=========================================="
    
    for sql_file in "$dir"/*.sql; do
        if [ -f "$sql_file" ]; then
            filename=$(basename "$sql_file")
            run_sql "$sql_file" "$filename"
        fi
    done
}

# 步骤1: 创建数据库
echo ""
echo "=========================================="
echo "  步骤1: 创建数据库"
echo "=========================================="
run_sql "$FIXED_DIR/0_创建数据库.sql" "创建7个数据库"

# 步骤2: 创建表结构
echo ""
echo "=========================================="
echo "  步骤2: 创建表结构"
echo "=========================================="

# 用户库表结构
run_sql "$SCRIPT_DIR/数据库脚本/2_1_用户库脚本.sql" "用户库表结构"

# 平台库表结构  
run_sql "$SCRIPT_DIR/数据库脚本/2_2_平台库脚本.sql" "平台库表结构"

# 金豆库表结构
run_sql "$SCRIPT_DIR/数据库脚本/2_3_金豆库脚本.sql" "金豆库表结构"

# 记录库表结构
run_sql "$SCRIPT_DIR/数据库脚本/2_4_记录库脚本.sql" "记录库表结构"

# 积分库表结构
run_sql "$SCRIPT_DIR/数据库脚本/2_5_积分库脚本.sql" "积分库表结构"

# 比赛库表结构
run_sql "$SCRIPT_DIR/数据库脚本/2_6_比赛库脚本.sql" "比赛库表结构"

# 练习库表结构
run_sql "$SCRIPT_DIR/数据库脚本/2_7_练习库脚本.sql" "练习库表结构"

# 步骤3: 插入基础数据
echo ""
echo "=========================================="
echo "  步骤3: 插入基础数据"
echo "=========================================="

run_sql "$SCRIPT_DIR/数据脚本/用户链接.sql" "用户链接服务器"
run_sql "$SCRIPT_DIR/数据脚本/财富链接.sql" "财富链接服务器"
run_sql "$SCRIPT_DIR/数据脚本/记录链接.sql" "记录链接服务器"
run_sql "$SCRIPT_DIR/数据脚本/平台链接.sql" "平台链接服务器"
run_sql "$SCRIPT_DIR/数据脚本/比赛链接.sql" "比赛链接服务器"
run_sql "$SCRIPT_DIR/数据脚本/道具配置.sql" "道具配置"
run_sql "$SCRIPT_DIR/数据脚本/系统配置.sql" "系统配置"
run_sql "$SCRIPT_DIR/数据脚本/会员类型.sql" "会员类型"
run_sql "$SCRIPT_DIR/数据脚本/签到配置.sql" "签到配置"
run_sql "$SCRIPT_DIR/数据脚本/等级配置.sql" "等级配置"
run_sql "$SCRIPT_DIR/数据脚本/类型配置.sql" "类型配置"
run_sql "$SCRIPT_DIR/数据脚本/抽奖配置.sql" "抽奖配置"
run_sql "$SCRIPT_DIR/数据脚本/抽奖参数.sql" "抽奖参数"
run_sql "$SCRIPT_DIR/数据脚本/标识生成.sql" "标识生成"

# 步骤4: 创建存储过程
echo ""
echo "=========================================="
echo "  步骤4: 创建存储过程"
echo "=========================================="

run_sql_dir "$SCRIPT_DIR/存储过程/用户数据库" "用户数据库存储过程"
run_sql_dir "$SCRIPT_DIR/存储过程/平台数据库" "平台数据库存储过程"
run_sql_dir "$SCRIPT_DIR/存储过程/金豆数据库" "金豆数据库存储过程"
run_sql_dir "$SCRIPT_DIR/存储过程/积分数据库" "积分数据库存储过程"
run_sql_dir "$SCRIPT_DIR/存储过程/比赛数据库" "比赛数据库存储过程"
run_sql_dir "$SCRIPT_DIR/存储过程/练习数据库" "练习数据库存储过程"

echo ""
echo "=========================================="
echo -e "${GREEN}  数据库导入完成！${NC}"
echo "=========================================="
echo ""
echo "接下来请修改 Web.config 文件中的数据库连接字符串:"
echo ""
echo "Data Source=localhost,1433"
echo "User ID=sa"
echo "Password=Admin@1234"
echo ""
