//直接下级玩家管理页面js文件
$(
    function()
    {   //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();
        //点击每个分组框上的“隐藏”链接时隐藏该分组框
        $(".tool .hide").click(
            function()
            {
                $(this).parents("fieldset").hide();
            }
        );
        
        //玩家详细资料
        $("#gvPlayer .playInfo").click(function(){
            //得到操作的行
            var row = $(this).parents("tr");                
            var playerID = row.children("td:eq(0)").html();
            //得到要转向的url地址，传递相关参数
            var desUrl = "../Player/PlayerInfoDetail.aspx?playerID="+escape(playerID);
            window.location = desUrl;
        })
        
        //点击新增玩家按钮时弹出新增游戏玩家层
        $("#btnAdd").click(
            function()
            {
                $(".operate").hide();
                $("#txtUserAccount").val("");
                $("#txtRealName").val("");
                $("#txtScore").val("0");
                $("#add").fadeIn();
            }
        );
        //点击“金币变化”按钮时处理事件
        $("#gvPlayer .scoreChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var account = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodePlayerScoreChangeRecord.aspx?player="+escape(account);
                window.location = desUrl;
            }            
        );
        //点击“银行金币变化”按钮时处理事件
        $("#gvPlayer .insureScoreChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var account = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodePlayerInsureScoreChangeRecord.aspx?player="+escape(account);
                window.location = desUrl;
            }
        );
     
        //点击为玩家充值时弹出为玩家充值层
        $("#gvPlayer .chargeIn").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的玩家ID与玩家账号
                var userID = row.children("td:eq(0)").html();
                var account = row.children("td:eq(1)").html();
                //保存玩家编号
                $("#hideUserID").val(userID);
                //保存玩家账号
                $("#hideUserAccount").val(account);
                //保存玩家账号
                $("#charge .account").html(account);
                //隐藏所有的操作层
                $(".operate").hide();
                //显示为玩家充值层
                $("#charge").fadeIn();                
            }
        );
    }
);

function doChargeIn()
{



   var contentSel; 
                var myScore = parseFloat($("#lblMyScore").html());
                var chargeIn = $.trim($("#txtCharge").val());
                var pattern = /^[1-9]\d*$/;
                if(chargeIn == "")
                {
                    alert("请输入充值金额！");
                    return false;
                }                
                if(!pattern.test(chargeIn) || parseFloat(chargeIn)<0 || parseFloat(chargeIn)>myScore)
                {
                    alert("充值金额不正确，应为0和您的资产之间的正整数！");
                    return false;
                }
                   __doPostBack('lbtnChargeIn','');
//                            else
//                {
//                                
//                   
//                 //                    
//                 $.ajax({
//                    url:"../../Service/GetReasonTypeList.ashx", 
//                    data:{TypeID:1},
//                    type:"POST",
//                    success:function(data){
//                        var json=JQueryExtend.EvalJSON(data);
//                        if(json[0].TotalCount>0)
//                        {
//                             var contentSel = "<div style='width:300px; float:left'><font>修改金币的原因为:<br><select id='selReason' style=' width:200px'>";
//                            for(var i=0;i<json.length;i++)
//                            {
//                                contentSel += "<option id='"+json[i].Desc+"'>"+json[i].Desc+"</option>";
//                            }
//                             contentSel += "</select></div>";

//                    art.dialog({
//                        title:'提示',                        
//                        content:contentSel,
//                        width: "300px",
//                        height: "70px",
//                        icon: 'succeed'  
//                    },
//                    function(){
//                        $("#hideRemark").val($("#selReason").val());
//                        //金币操作
//                       __doPostBack('lbtnChargeIn','');

//                    },
//                    function(){
//                    }
//                     );
//        
//                        }
//                        else
//                        {     
//                            alert("获取修改金币原因列表失败");        
//                        }
//                    }
//                  });
//               }
                return true;
}