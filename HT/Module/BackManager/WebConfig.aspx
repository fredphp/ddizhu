<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebConfig.aspx.cs" Inherits="MTEwin.Module.BackManager.WebConfig" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 4%;
        }
        .auto-style2 {
            background-color: #c2cfd5;
            border-bottom: 1px solid #99a7ae;
            height: 30px;
            white-space: nowrap;
            padding: 0px 5px;
            width: 7%;
        }
        .auto-style3 {
            background-color: #c2cfd5;
            border-bottom: 1px solid #99a7ae;
            height: 30px;
            white-space: nowrap;
            padding: 0px 5px;
            width: 15%;
        }
        .auto-style4 {
            background-color: #c2cfd5;
            border-bottom: 1px solid #99a7ae;
            height: 30px;
            white-space: nowrap;
            padding: 0px 5px;
            width: 10%;
        }
        .auto-style5 {
            background-color: #c2cfd5;
            border-bottom: 1px solid #99a7ae;
            height: 30px;
            white-space: nowrap;
            padding: 0px 5px;
            width: 14%;
        }
        .auto-style6 {
            background-color: #c2cfd5;
            border-bottom: 1px solid #99a7ae;
            height: 30px;
            white-space: nowrap;
            padding: 0px 5px;
            width: 13%;
        }
        .auto-style7 {
            width: 15%;
        }
        .auto-style8 {
            width: 10%;
        }
        .auto-style9 {
            width: 14%;
        }
        .auto-style10 {
            width: 13%;
        }
        .auto-style11 {
            background-color: #c2cfd5;
            border-bottom: 1px solid #99a7ae;
            height: 30px;
            white-space: nowrap;
            padding: 0px 5px;
            width: 54px;
        }
        .edit,.new{display:none}
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
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：后台系统 - 管理员管理
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td height="28">
                <ul>
                    <li class="tab2" onclick="Redirect('BaseRoleList.aspx')">角色管理</li>
	                <li class="tab2" onclick="Redirect('BaseUserList.aspx')">用户管理</li>
                    <li class="tab1">网站配置</li>
                </ul>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="$('.new').css('display','table-row')" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" />
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
            <tr align="center" class="bold">
                <td class="auto-style1">
                </td>
                <td class="auto-style2">
                </td>
                <td class="auto-style2">
                    key
                </td>
                <td class="auto-style11">
                    value
                </td>
                <td class="auto-style3">
                    description
                </td>
            </tr>
            <tr align="center" class="list edit">
                <td>
                    <input name="e_id" readonly />
                </td>
                <td>
                    <asp:Button ID="btnUpdate" runat="server" Text="更新" OnClick="btnUpdate_Click" OnClientClick="update()" />
                </td>
                <td>
                    <input name="e_key" readonly />
                </td>
                <td>
                    <input name="e_value" />
                </td>
                <td>
                    <input name="e_description" />
                </td>
            </tr>
            <asp:Repeater ID="rptConfig" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <button type="button" onclick="del(<%# Eval("id") %>)">删除</button>
                        </td>
                        <td>
                            <button type="button" onclick="edit(<%# Eval("id")+",'"+Eval("key")+"','"+Eval("value")+"','"+Eval("description")+"'" %>)">修改</button>
                        </td>
                        <td>
                            <%# Eval("key")%>
                        </td>
                        <td>
                            <%# Eval("value")%>
                        </td>
                        <td>
                            <%# Eval("description")%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <button type="button" onclick="del(<%# Eval("id") %>)">删除</button>
                        </td>
                        <td>
                            <button type="button" onclick="edit(<%# Eval("id")+",'"+Eval("key")+"','"+Eval("value")+"','"+Eval("description")+"'" %>)">修改</button>
                        </td>
                        <td>
                            <%# Eval("key")%>
                        </td>
                        <td>
                            <%# Eval("value")%>
                        </td>
                        <td>
                            <%# Eval("description")%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
            <tr align="center" class="list new">
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="btnInsert" runat="server" Text="保存" OnClick="btnInsert_Click" OnClientClick="insert()" />
                </td>
                <td>
                    <input name="n_key" />
                </td>
                <td>
                    <input name="n_value" />
                </td>
                <td>
                    <input name="n_description" />
                </td>
            </tr>
        </table>
        <asp:HiddenField runat="server" ID="id" />
        <asp:HiddenField runat="server" ID="key" />
        <asp:HiddenField runat="server" ID="value" />
        <asp:HiddenField runat="server" ID="description" />
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg">
                <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
            </td>
            <td align="right" class="page">
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="Redirect('(WebConfig)BaseUserInfo.aspx?cmd=add')" />
                <input class="btnLine" type="button" />
                <asp:Button ID="Button1" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
            </td>
        </tr>
    </table>
    </form>
    <script src="/scripts/jquery-1.4.2.min.js"></script>
    <script>
        function edit(id,key,value,description) {
            var obj=$(".edit").css("display","table-row");
            $("input[name=e_id]",obj).val(id);
            $("input[name=e_key]",obj).val(key);
            $("input[name=e_value]",obj).val(value);
            $("input[name=e_description]",obj).val(description);
        }
        function del(id) {
            $("#<%=this.id.ClientID%>").val(id);
            $("#<%=this.btnDelete.ClientID%>").click();
        }
        function update() {
            var obj=$(".edit").hide();
            $("#<%=this.id.ClientID%>").val($("input[name=e_id]",obj).val());
            $("#<%=this.value.ClientID%>").val($("input[name=e_value]",obj).val());
            $("#<%=this.description.ClientID%>").val($("input[name=e_description]",obj).val());
        }
        function insert() {
            var obj=$(".new").hide();
            $("#<%=this.key.ClientID%>").val($("input[name=n_key]",obj).val());
            $("#<%=this.value.ClientID%>").val($("input[name=n_value]",obj).val());
            $("#<%=this.description.ClientID%>").val($("input[name=n_description]",obj).val());
        }
    </script>
</body>
</html>

