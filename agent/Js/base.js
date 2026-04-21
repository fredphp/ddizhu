/*
文件名：base.js
功能说明：全站通用的全局变量及公用方法
创建者：刘建忠
创建日期：2010-09-26
*/
//引入jquery库文件
document.write("<script type='text/javascript' src='/Lib/jquery-1.4.1.min.js'></script>");
//全局配置
var GlobalSetting = {
    //站点名称
    SiteName: "代理后台",
    //管理后台名称
    ManageName: "代理后台",
    //版权信息
    CopyRight: "Copyright @2010-2012  All Rights Reserved."
};
//错误提示信息
var ErrorInfo = {
    //ajax超时错误
    Ajax_TimeOut: "服务器忙，数据通信超时！"
};
//成功提示信息    
var SuccessInfo = {
    RegisterSuccess: "注册成功！"
};
//如果页面没有标题，则使用全局设置中的标题
if (document.title == "") {
    document.title = GlobalSetting.SiteName;
}
//如果页面有标题，则页面标题等于原标题+"-"+全局配置标题
else {
    document.title = document.title + "-" + GlobalSetting.SiteName;
}
//设为首页
function addFav() {
    if (document.all) {
        window.external.addFavorite("http://" + PathInfo, "");
    } else if (window.sidebar) {
    window.sidebar.addPanel("", "http://" + PathInfo, "");
    }
}
//添加收藏夹
function setHome() {
    if (document.all) {
        document.body.style.behavior = "url(#default#homepage)";
        document.body.setHomePage("http://" + PathInfo);
    } else if (window.sidebar) {
        if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            } catch (e) {
                alert("抱歉，此操作被浏览器拒绝！\n\n请在浏览器地址栏输入“about:config”并回车然后将[signed.applets.codebase_principal_support]设置为'true'");
            }
        } else {
            var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefBranch);
            prefs.setCharPref("browser.startup.homepage", "http://" + PathInfo);
        }
    }
}
//全局公用函数
var GlobalFunc = {
    //将指定秒数格式化为当天时间
    FormatTime:function (seconds)
    {
        //得到小时数，用Math.floor实现整除
        var hours = Math.floor(seconds / 3600);
        //得到分钟数
        var minute = Math.floor((seconds - hours * 3600)/60);
        //得到秒数
        seconds = seconds % 60; 
        //时分秒，不足两位的补0
        if(hours<10)
            hours="0"+hours.toString();
        if(minute<10)
            minute="0"+minute.toString();
        if(seconds<10)
            seconds="0"+seconds.toString(); 
        //格式化成HH:mm:ss的形式                    
        var strTime = hours+ ":" + minute + ":" + seconds;
        return strTime;
    },
    //隐藏遮罩层
    HideLoading:function()
    {
        $(window.top.document).find("#loading").hide();
    }
}