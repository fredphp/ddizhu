<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgencyApplyList.aspx.cs"
    Inherits="MTEwin.Module.AgencyManager.AgencyApplyList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <script type="text/javascript">
        $(function() {
            $(".setRoty").click(function() {
                $("#divQuery").show();
                $("#txtRoty").val($(this).attr("data-con"));
                $("#hidAgencyId").val($(this).attr("data-id"));
            });
            $("#content tr:even").attr("class","listBg");
        });
        function HideDiv() {
            document.getElementById('divQuery').style.display="none";
        }


        function GrantManager(a) {
            if(a*1==2) {
                openWindowOwn('AddAgencyScoreList.aspx?','_AddAgencyScoreList',900,640);
                return;
            }

            if(deleteop()) {
                var aid="";
                var aids=GelTags("input");
                for(var i=0;i<aids.length;i++) {
                    if(aids[i].checked) {
                        if(aids[i].name=="aid") aid+=aids[i].value+",";
                    }
                }
                if(aid=="") {
                    showError("未选中任何数据");
                    return;
                }
                //操作处理
                aid=aid.substring(0,aid.length-1);
                if(aid.indexOf(",")>0) {
                    showError("只能操作一条数据");
                    return;
                }

                openWindowOwn('AddAgencyscore.aspx?param='+aid,'_GrantTreasure',600,240);

            }
        }

        //验证
        function btnVerification() {
            var bool=true;
            if($("#list tr:not(:first) input[type=checkbox]:checked").length<1) {
                alert("请勾选需要审核的数据！");
                bool=false;
            }
            return bool;
        }
    </script>
    <style type="text/css">
        .querybox { width: 500px; background: #caebfc; font-size: 12px; line-height: 18px; text-align: left; border-left: 1px solid #066ba4; border-right: 1px solid #066ba4; border-bottom: 1px solid #066ba4; border-top: 1px solid #066ba4; z-index: 999; display: none; position: absolute; top: 150px; left: 200px; padding: 5px; filter: progid:DXImageTransform.Microsoft.DropShadow(color=#9a8559,offX=1,offY=1,positives=true); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 头部菜单 Start -->
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
            <tr>
                <td width="19" height="25" valign="top" class="Lpd10">
                    <div class="arr">
                    </div>
                </td>
                <td width="1232" height="25" valign="top" align="left">你当前位置：代理系统 - 代理申请记录
                </td>
            </tr>
        </table>
        <!-- 头部菜单 End -->
        <%--<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
                <td>&nbsp;
                输入真实姓名或代理账号:<asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入帐号或真实姓名"></asp:TextBox>
                    <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                    <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                </td>
            </tr>
        </table>--%>
        <%--        <div id="divQuery" class="querybox">

            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="listTdLeft" style="width: 50px;">抽水比例：
                    </td>
                    <td>
                        <input id="txtRoty" runat="server" name="txtRoty" type="text" class="text wd2" />%
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right" style="padding-bottom: 10px;">
                        <asp:Button ID="btnSet" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnSet_Click" />
                        <input type="button" value="关闭" class="btn wd1" onclick="HideDiv()" />
                    </td>
                </tr>
            </table>
        </div>--%>
        <div class="clear">
        </div>
        <%--        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
            <tr>
                <td height="39" class="titleOpBg">
                    <input type="button" value="新增" class="btn wd1" onclick="openWindowOwn('AddAgency.aspx','',850,600)" />
                </td>
            </tr>
        </table>--%>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
            <tr>
                <td height="39" class="titleOpBg">
                    <asp:Button runat="server" Text="审核" CssClass="btn wd1" OnClientClick="return btnVerification();" OnClick="btnSave_Click" />
                    <input type="button" value="刷新" class="btn wd1" onclick="location.href=location.href;" />
                </td>
            </tr>
        </table>
        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
                id="list">
                <tr align="center" class="bold">
                    <td class="listTitle">
                        <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" /></td>
                    <td class="listTitle2">代理账号</td>
                    <td class="listTitle2">申请域名</td>
                    <td class="listTitle2">真实姓名</td>
                    <td class="listTitle2">上级代理</td>
                    <td class="listTitle2">联系电话</td>
                    <td class="listTitle2">联系邮箱</td>
                    <td class="listTitle2">联系QQ</td>
                    <td class="listTitle1">申请状态</td>
                    <td class="listTitle2">申请时间</td>
                    <td class="listTitle2">申请理由</td>
                    <td class="listTitle2">操作备注</td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td style="width: 30px;">
                                <input id="ckbaid" runat="server" name='aid' type='checkbox' visible='<%#Eval("status").ToString()=="1"?false:true%>' value='<%# Eval("aid").ToString()%>' />
                            </td>
                            <td>
                                <%#  Eval("account").ToString()%>
                            </td>
                            <td>
                                <a href='#' style="color: #0000ff"><%#  Eval("domain2name").ToString()%></a>
                            </td>
                            <td>
                                <%#  Eval("name").ToString()%>
                            </td>
                            <td>
                                <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("pid") %>' style="color: #0000ff"><%#  GetAgencyLogonName(int.Parse(Eval("pid").ToString()))%></a>
                            </td>
                            <td>
                                <%#  Eval("phone").ToString()%>
                            </td>
                            <td>
                                <%#  Eval("mail").ToString()%>
                            </td>
                            <td>
                                <%#  Eval("QQ").ToString()%>
                            </td>
                            <td>
                                <a href='<%# GetStatus(Eval("status").ToString())!="申请中"?"javascrpt:;":"AddAgency.aspx?param=-1&ApplyID="+Eval("aid")%>' style='<%# GetStatus(Eval("status").ToString())!="申请中"?"": "color: #0000ff"%>'><%# GetStatus(Eval("status").ToString())%></a>
                            </td>
                            <td>
                                <%#  Eval("applydate").ToString()%>
                            </td>
                            <td>
                                <%#  Eval("reason").ToString()%>
                            </td>
                            <td>
                                <%#  Eval("remark").ToString()%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
            </table>
        </div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="listTitleBg">
                    <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a
                        class="l1" href="javascript:SelectAll(false);">无</a>
                </td>
                <td align="right" class="page">
                    <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                        AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="15" NextPageText="下页"
                        PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                        NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                        UrlPaging="false">
                    </gsp:AspNetPager>
                </td>
            </tr>
        </table>
        <input type="hidden" runat="server" id="hidAgencyId" />
    </form>
</body>
</html>
