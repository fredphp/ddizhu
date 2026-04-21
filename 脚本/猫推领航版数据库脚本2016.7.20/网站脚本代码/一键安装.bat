@echo off

TITLE 数据库 自动安装中...请注意：安装过程中请勿关闭

md D:\数据库

set SERVER=127.0.0.1,1433
set USER=sa
set PASS=Admin@1234

set rootPath=1.数据库脚本\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%1.数据库删除.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%1_1_网站库脚本.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%1_2_后台库脚本.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%2_1_网站库脚本.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%2_2_后台库脚本.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%3_1_代理库脚本.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%3_2_代理库脚本.sql"

set rootPath=2.数据脚本\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%充值服务.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%后台数据.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%实卡类型.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%推广数据.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%泡点设置.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%独立页面.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%站点配置.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%系统广告.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%网站链接.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%网站数据.sql"

set rootPath=3.存储过程\作业脚本\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%每日统计(作业).sql"

set db=-S 127.0.0.1,1433 -U sa -P Admin@1234

set rootPath=3.存储过程\公共过程\
sqlcmd %db% -d QPAccountsDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPGameMatchDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPGameScoreDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPNativeWebDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPPlatformDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPPlatformManagerDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPRecordDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPTreasureDB -i "%rootPath%分页过程.sql"
sqlcmd %db% -d QPAgencyDB -i "%rootPath%分页过程.sql"

sqlcmd %db% -d QPAccountsDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPGameMatchDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPGameScoreDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPNativeWebDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPPlatformDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPPlatformManagerDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPRecordDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPTreasureDB -i "%rootPath%切字符串.sql"
sqlcmd %db% -d QPAgencyDB -i "%rootPath%切字符串.sql"

set rootPath=3.存储过程\前台脚本\本地数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%推荐游戏.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%购买奖品.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%清理日志.sql"

set rootPath=3.存储过程\前台脚本\比赛数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%比赛排行.sql"

set rootPath=3.存储过程\前台脚本\用户数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%修改密码.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%修改资料.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%固定机器.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%奖牌兑换.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%每日签到.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%用户全局信息.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%用户名检测.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%用户注册.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%用户登录.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%获取用户信息.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%账户保护.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%重置密码.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%魅力兑换.sql" 
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%安全中心.sql" 

set rootPath=3.存储过程\前台脚本\积分数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%负分清零.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%逃率清零.sql"

set rootPath=3.存储过程\前台脚本\网站数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%更新浏览.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%比赛报名.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%获取新闻.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%购买奖品.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%问题反馈.sql"

set rootPath=3.存储过程\前台脚本\金豆数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%在线充值.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%在线订单.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%实卡充值.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%推广中心.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%推广信息.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%苹果充值.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%金豆取款.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%金豆存款.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%金豆转账.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%代理充值.sql"

set rootPath=3.存储过程\后台脚本\帐号库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%插入限制IP.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%插入限制机器码.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%更新用户.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%注册IP统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%注册机器码统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%添加用户.sql"

set rootPath=3.存储过程\后台脚本\平台库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%在线统计.sql"

set rootPath=3.存储过程\后台脚本\数据分析\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%充值统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%其他统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%活跃统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%用户统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%金豆分布.sql"

set rootPath=3.存储过程\后台脚本\权限库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%权限加载.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%用户表操作.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%管理员登录.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%菜单加载.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%清理日志.sql"

set rootPath=3.存储过程\后台脚本\比赛库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%比赛排名.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%比赛管理.sql"

set rootPath=3.存储过程\后台脚本\积分库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%清零积分.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%清零逃率.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%赠送积分.sql"

set rootPath=3.存储过程\后台脚本\网站库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%删商品类.sql"

set rootPath=3.存储过程\后台脚本\记录库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%统计平台每天财富增减值.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%赠送会员.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%赠送经验.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%赠送金豆.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%赠送靓号.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%每日统计.sql" 
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%清理日志.sql" 

set rootPath=3.存储过程\后台脚本\金豆库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%分页获取房间输赢.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%财富游戏用户在线查询.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%根据年月来统计代理充值情况.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%抽奖记录时长.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%抽奖设置.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%增删道具.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%实卡入库.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%实卡统计.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%数据汇总.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%新增实卡.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%游戏记录.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%统计记录.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%赠送金豆.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%转账税收.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%玩家赢取金豆提醒.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%后台充值提醒.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%账户提款.sql"

set rootPath=3.存储过程\代理脚本\代理数据库\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%代理抽水比例.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%代理设置.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%代理提款.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%代理转账.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%发放有效会员奖励.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%记录查询.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%添加代理.sql"
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%分页过程.sql"

set rootPath=4.创建作业\
sqlcmd -S %SERVER% -U %USER% -P %PASS% -i"%rootPath%MT数据库作业创建.sql"
pause

COLOR 0A
CLS
@echo off
CLS
echo ------------------------------
echo.
echo. 数据库建立完成
echo.
echo ------------------------------

pause
