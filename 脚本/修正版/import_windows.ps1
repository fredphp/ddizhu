# =============================================
# 斗地主数据库导入脚本 (Windows PowerShell版)
# 使用方法: 在PowerShell中运行 .\import_windows.ps1
# 前提条件: Docker SQL Server容器已启动
# =============================================

$ErrorActionPreference = "Continue"

# 配置
$ContainerName = "sqlserver"
$SaPassword = "Admin@1234"
$ScriptRoot = "D:\game\doudizhu\cbddz\doudizhu\脚本\猫推领航版数据库脚本2016.7.20\平台脚本代码"
$FixedDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  斗地主数据库导入脚本" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Docker容器状态
Write-Host "检查SQL Server容器状态..." -ForegroundColor Yellow
$containerStatus = docker ps --filter "name=$ContainerName" --format "{{.Status}}" 2>$null
if (-not $containerStatus) {
    Write-Host "错误: 容器 '$ContainerName' 未运行" -ForegroundColor Red
    Write-Host "请先启动容器: docker start $ContainerName" -ForegroundColor Yellow
    exit 1
}
Write-Host "容器状态: $containerStatus" -ForegroundColor Green
Write-Host ""

# 函数: 在Docker容器内执行SQL
function Invoke-SqlInDocker {
    param(
        [string]$SqlFile,
        [string]$Description
    )
    
    if (-not (Test-Path $SqlFile)) {
        Write-Host "文件不存在: $SqlFile" -ForegroundColor Red
        return $false
    }
    
    Write-Host "执行: $Description" -ForegroundColor Yellow
    
    # 检测文件编码并转换
    $bytes = [System.IO.File]::ReadAllBytes($SqlFile)
    $isUtf16LE = ($bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE)
    
    $tempFile = Join-Path $env:TEMP "temp_script.sql"
    
    if ($isUtf16LE) {
        # UTF-16 LE 编码，转换为UTF-8
        $content = [System.IO.File]::ReadAllText($SqlFile, [System.Text.Encoding]::Unicode)
        [System.IO.File]::WriteAllText($tempFile, $content, [System.Text.Encoding]::UTF8)
    } else {
        Copy-Item $SqlFile $tempFile -Force
    }
    
    # 复制到容器并执行
    docker cp $tempFile "${ContainerName}:/tmp/script.sql" 2>$null
    docker exec $ContainerName /opt/mssql-tools18/bin/sqlcmd `
        -S localhost -U sa -P $SaPassword `
        -i /tmp/script.sql -C -b 2>&1 | Out-Null
    
    Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ 完成" -ForegroundColor Green
    } else {
        Write-Host "✗ 可能存在错误" -ForegroundColor Red
    }
    
    Write-Host ""
    return $true
}

# 函数: 执行目录下所有SQL文件
function Invoke-SqlDirectory {
    param(
        [string]$Directory,
        [string]$Description
    )
    
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "  $Description" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    
    $files = Get-ChildItem -Path $Directory -Filter "*.sql" | Sort-Object Name
    foreach ($file in $files) {
        Invoke-SqlInDocker -SqlFile $file.FullName -Description $file.Name
    }
}

# 步骤1: 创建数据库
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  步骤1: 创建数据库" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Invoke-SqlInDocker -SqlFile (Join-Path $FixedDir "0_创建数据库.sql") -Description "创建7个数据库"

# 步骤2: 创建表结构
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  步骤2: 创建表结构" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$dbScripts = @(
    @{File="2_1_用户库脚本.sql"; Desc="用户库表结构"},
    @{File="2_2_平台库脚本.sql"; Desc="平台库表结构"},
    @{File="2_3_金豆库脚本.sql"; Desc="金豆库表结构"},
    @{File="2_4_记录库脚本.sql"; Desc="记录库表结构"},
    @{File="2_5_积分库脚本.sql"; Desc="积分库表结构"},
    @{File="2_6_比赛库脚本.sql"; Desc="比赛库表结构"},
    @{File="2_7_练习库脚本.sql"; Desc="练习库表结构"}
)

foreach ($script in $dbScripts) {
    Invoke-SqlInDocker -SqlFile (Join-Path $ScriptRoot "数据库脚本\$($script.File)") -Description $script.Desc
}

# 步骤3: 插入基础数据
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  步骤3: 插入基础数据" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$dataScripts = @(
    "用户链接.sql", "财富链接.sql", "记录链接.sql", "平台链接.sql",
    "比赛链接.sql", "道具配置.sql", "系统配置.sql", "会员类型.sql",
    "签到配置.sql", "等级配置.sql", "类型配置.sql", "抽奖配置.sql",
    "抽奖参数.sql", "标识生成.sql"
)

foreach ($script in $dataScripts) {
    Invoke-SqlInDocker -SqlFile (Join-Path $ScriptRoot "数据脚本\$script") -Description $script
}

# 步骤4: 创建存储过程
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  步骤4: 创建存储过程" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$spDirs = @("用户数据库", "平台数据库", "金豆数据库", "积分数据库", "比赛数据库", "练习数据库")
foreach ($dir in $spDirs) {
    Invoke-SqlDirectory -Directory (Join-Path $ScriptRoot "存储过程\$dir") -Description "$dir 存储过程"
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "  数据库导入完成！" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "接下来请修改 Web.config 文件中的数据库连接字符串:" -ForegroundColor Yellow
Write-Host "Data Source=localhost,1433" -ForegroundColor White
Write-Host "User ID=sa" -ForegroundColor White
Write-Host "Password=Admin@1234" -ForegroundColor White
Write-Host ""
