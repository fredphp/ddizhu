$(
    function()
    {
       //设置管理后台名称，设置从base.js的全局设置中读取
        $("#mainHeader").html(GlobalSetting.ManageName);
        //设置版权信息，设置从base.js的全局设置中读取
        $("#mainFooter").html(GlobalSetting.CopyRight);
        $("body").layout({ applyDefaultStyles: true });        
        //默认情况下仅显示第一个子菜单的菜单项，其余的全部隐藏
        $("#nav ul:gt(0)").hide(); 
        //点击子菜单菜单项处理事件
        $("#nav .submenu").click(
            function()
            {
                var submenu = $(this).parent().find("ul"); 
                //得到当前子菜单的显示或或隐藏状态
                var dis = submenu.css("display");
                //隐藏所有的子菜单项
                $("#nav ul").hide();
                //当前子菜单原来为显示，则隐藏
                if(dis == "block")
                   submenu.hide();
                //原来为隐藏，则显示
                else
                   submenu.show();
                return false;
            }
        );
          //点击左侧导航菜单时弹出遮罩层
        $("#nav .item").click(
            function()
            {
                $("#loading").show();
            }
        );
    }
);