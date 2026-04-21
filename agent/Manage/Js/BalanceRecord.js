//结算记录页面js文件
$(
    function()
    {    
     //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();   
        $(".tool .date").attr("readonly","readonly").focus(
            function()
            {
                SelectDate(this,'yyyy-MM-dd');
                $("#calendarClear").hide();
            }
        );
        //查询按钮点击处理事件
        $("#btnQuery").click(
            function()
            {
               var pattern = /^[1-9]\d{0,10}$/;
               var startDate = $("#txtStartDate").val();
               var endDate = $("#txtEndDate").val();  
               if(startDate>endDate)
               {
                   alert("查询起始时间不能大于截止时间！");
                   return false;
               } 
               return true;
            }
        );
       //点击“查看银行信息”处理事件
       $("#gvRecord .viewBankInfo").click(
            function()
            {
                var tr = $(this).parents("tr");
                var bankName = $.trim(tr.find(".bankName").val());
                var bankDetail = $.trim(tr.find(".bankDetail").val());
                var realName = $.trim(tr.find(".realName").val());
                var bankNum = $.trim(tr.find(".bankNum").val());
                var dom = "开户行："+bankName+"<br/>"
                        + "开户行详细地址："+bankDetail+"<br/>"
                        + "真实姓名："+realName+"<br/>"
                        + "银行卡号："+bankNum+"<br/>";
                tr.addClass("highlight");                        
                $(this).dialog(
                                    {   
                                        lock:true,
                                        title:"代理银行信息",
                                        window:top,
                                        content:dom,
                                        noText:"关闭",
                                        noFn:function()
                                        {
                                            tr.removeClass("highlight");
                                        }                                       
                                    }
                                );
            }
       );
       //点击“查看拒绝原因”处理事件
       $("#gvRecord .viewReason").click(
            function()
            {
                var tr = $(this).parents("tr");
                var reject = $.trim(tr.find(".rejectReason").val());
                tr.addClass("highlight");
                $(this).dialog(
                    {
                        lock:true,
                        title:"查看结算申请被拒绝原因",
                        window:top,
                        content:reject,
                        noText:"关闭",
                        noFn:function()
                        {
                            tr.removeClass("highlight");
                        }      
                    }
                );
            }
       );
    }
);