//直接下级代理管理页面js文件
$(
    function()
    {
        $(".divAgentList").hide();
        //页面加载时隐藏遮罩层
        $("#divHidShow").hide();
       GlobalFunc.HideLoading();    
        //点击代理列表中的"修改"按钮处理事件
        $("#result .edit").click(
            function()
            {
                $("#btnAdd").hide();
                $("#btnEdit").show();
                $("#edit legend").html("修改代理信息");
            }
        );
        $("#closediv").click(function () {
            $(".divAgentList").hide();
            $("#divHidShow").hide();
        });
        //点击“推广的代理”按钮时处理事件
        $("#gvAgentList .nodeAgent").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "IndirectAgentList.aspx?super="+agentAccount;
                window.location = desUrl;
            }
        );
        //点击“推广的玩家”按钮时处理事件
        $("#gvAgentList .nodePlayer").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Player/IndirectPlayerList.aspx?super="+agentAccount;
                window.location = desUrl;
            }
        );  
        //点击“金币变化”按钮时处理事件
        $("#gvAgentList .scoreChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodeAgentScoreChangeRecord.aspx?agent="+encodeURI(agentAccount);
                window.location = desUrl;
            }            
        );
              
        $("#gvAgentList .delete").click(
            function()
            {
                //得到要删除的代理账号
                var agentAccount = $(this).parents("tr").children("td:eq(1)").html();
                return confirm("确认要删除代理账号【"+agentAccount+"】吗？");
            }        
        );
        $(".tool .hide").click(
            function()
            {
                $(this).parents("fieldset").hide();
            }
        );
        //点击为下级代理充值时弹出为下级代理充值层
        $("div.chargeIn").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                //保存代理编号，账号
                $("#hideAgentID").val(agentID);
                 $("#hiddenAccount").val(agentAccount);
                //保存代理账号
                $(".agentAccount").html(agentAccount);
                //隐藏所有的操作层
               // $(".operate").hide();
                //显示为下级代理充值层
                $(".divAgentList").show();
                $("#divHidShow").show();
                $("#tdAgentAccount").val(agentAccount);
                //$(".divAgentList").fadeIn();
                //openWindowOwn('AgencyRecharge.aspx?param=' + cid, '_GrantTreasure', 600, 240);
            }
        );
     
        function openWindowOwn(url, name, width, height) {
            var left = (window.screen.availWidth - width) / 2;
            var top = (window.screen.availHeight - height) / 2
            var openthiswin = window.open(url, name, 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,left=' + left + ',top=' + top + ',width=' + width + ',height=' + height);
            if (openthiswin != null) openthiswin.focus();
        }
        //点击为下级代理退款时弹出下级代理退款层
        $("#gvAgentList .cashIn").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                var agentScore = row.children("td:eq(2)").html();
                //保存代理编号，账号
                $("#hideAgentID").val(agentID);
                 $("#hiddenAccount").val(agentAccount);
                //保存代理账号
                $("#cash .agentAccount").html(agentAccount);
                $("#cash .agentScore").html(agentScore);
                //隐藏所有的操作层
                $(".operate").hide();
                //显示为下级代理退款层
                $("#cash").fadeIn();     
            }
        );
        //点击修改下级代理密码时弹出重设下级代理密码层
        $("#gvAgentList .changePwd").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                //保存代理编号，账号
                $("#hideAgentID").val(agentID);
                 $("#hiddenAccount").val(agentAccount);
                //保存代理账号
                $("#changePwd .agentAccount").html(agentAccount);
                //隐藏所有的操作层
                $(".operate").hide();
                //显示为下级代理退款层
                $("#changePwd").fadeIn(); 
                //将焦点放置到用户新密码中
                $("#txtNewPwd").focus();
             }              
        );
        //点击修改下级代理抽水比例时弹出重设下级代理抽水比例层
         $("#gvAgentList .changeRevenue").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();    
                var agentRevenue = row.children("td:eq(3)").html();
                $("#txtNewRevenue").val(agentRevenue.replace('%',''));            
                //保存代理编号，账号
                $("#hideAgentID").val(agentID);
                 $("#hiddenAccount").val(agentAccount);
                //保存代理账号
                $("#changeRevenue .agentAccount").html(agentAccount);
                //隐藏所有的操作层
                $(".operate").hide();
                //显示为下级代理退款层
                $("#changeRevenue").fadeIn(); 
             }              
        );
        
        //点击重设密码按钮时校验数据
        $("#btnChangePwd").click(
            function()
            {
                var pwd = $("#txtNewPwd").val();
                var pwdCon = $("#txtNewPwdCon").val();
                if(pwd == "" || pwdCon == "")
                {
                    alert("新密码及确认密码不能为空！");
                    return false;
                }
                if(pwd != pwdCon)
                {
                    alert("两次输入的密码必须一致！");
                    return false;                    
                }
                return true;
            }
        );
        //点击修改抽水比例按钮时校验数据
        $("#btnSaveRevenue").click(function()
        {
            var revenue = $.trim($("#txtNewRevenue").val());
            var pattern = /^[1-9]\d*|[1-9]\d*.\d*|0.\d*[1-9]\d*|0?.0+|0$/;            
            if(revenue == "")
            {
                alert("请设置抽水比例！");
                return false;
            }
            if(!pattern.test(revenue) || parseFloat(revenue)<0 )
            {               
                alert("抽水比例格式不合法！");
                return false;
            }
            return true;            
        }
        );
        
        //点击退款按钮时校验数据
        $("#btnCashIn").click(
            function()
            {
                var agentScore = parseFloat($.trim($("#cash .agentScore").html()));
                var cashIn = $.trim($("#txtCash").val());
                var pattern = /^[1-9]\d*|0$/;
                if(cashIn == "")
                {
                    alert("请输入退款金额！");
                    return false;
                }                
                if(!pattern.test(cashIn) || parseFloat(cashIn)<0 || parseFloat(cashIn)>agentScore)
                {
                    alert("退款金额不正确，应为0和代理资产资产之间的正整数！");
                    return false;
                }
                return true;
            }
        );
        //点击新增下级代理按钮时校验数据
        $("#btnAdd").click(
            function()
            {
                var account = $.trim($("#txtAgentAccount").val());
                var pwd = $("#txtPassword").val();
                var pwdCon = $("#txtPasswordCon").val();
                var score = $.trim($("#txtScore").val());
                var revenue = $.trim($("#txtRevenue").val());                
                var patternAccount = /^\w{4,20}$/;
                var patternPwd = /^\w{4,20}$/;
                var patternScore = /^[1-9]\d*|0$/;
                var patternRevenue = /^[1-9]\d*|[1-9]\d*.\d*|0.\d*[1-9]\d*|0?.0+|0$/;               
                if(!patternAccount.test(account))
                {
                    alert("代理账号长度必须在4至20位之间，只能包含字母，数字和下划线！");
                    return false;
                }
                if(!patternPwd.test(pwd))
                {
                    alert("代理密码长度必须在4-20位之间，只能包含字母，数字和下划线！");
                    return false;
                }
                if(pwdCon!=pwd)
                {
                    alert("两次输入的密码不一致！");
                    return false;
                }
                if(!patternRevenue.test(revenue) || parseFloat(revenue)<0 )
                {
                    alert("抽水比例格式不合法！");
                    return false;
                }
                return true;
            }
        );
    }

);

//点击为代理充值按钮时校验数据
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

//点击为代理充值按钮时校验数据
function doChargeIn() {
    var contentSel;
    var myScore = parseFloat($("#lblMyScore").html());
    var chargeIn = $.trim($("#txtCharge").val());
    var pattern = /^[1-9]\d*$/;
    if (chargeIn == "") {
        alert("请输入充值金额！");
        return false;
    }
    if (!pattern.test(chargeIn) || parseFloat(chargeIn) < 0 || parseFloat(chargeIn) > myScore) {
        alert("充值金额不正确，应为0和您的资产之间的正整数！");
        return false;
    }
    return true;
}
