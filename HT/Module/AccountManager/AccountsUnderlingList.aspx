<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountsUnderlingList.aspx.cs" Inherits="MTEwin.Module.AccountManager.AccountsUnderlingList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>

    <script type="text/javascript">
        function GrantManager(opType) {
            var cid = "";
            var cids = GelTags("input");
            for (var i = 0; i < cids.length; i++) {
                if (cids[i].checked) {
                    if (cids[i].name == "cid")
                        cid += cids[i].value + ",";
                }
            }
            if (cid == "") {
                alert("未选中任何数据");
                return false;
            }
            //操作处理
            cid = cid.substring(0, cid.length - 1);
            switch (opType) {
                case "GrantTreasure":
                    openWindowOwn('GrantTreasure.aspx?param=' + cid, '_GrantTreasure', 600, 240);
                    break;
                case "GrantExperience":
                    openWindowOwn('GrantExperience.aspx?param=' + cid, '_GrantExperience', 600, 240);
                    break;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">   
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg" visible="false">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                普通查询：
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
                <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                <asp:Button ID="btnRefresh" runat="server" Text="刷新" CssClass="btn wd1" OnClick="btnRefresh_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr>
            <td height="39" class="titleOpBg">              
                <asp:Button ID="btnDongjie" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click" OnClientClick="return GrantManager('')" />
                <asp:Button ID="btnJiedong" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click" OnClientClick="return GrantManager('')" />
                <input class="btnLine" type="button" />
                <input id="btnGrantTreasure" type="button" value="赠送金币" class="btn wd2" onclick="GrantManager('GrantTreasure')" />               
               <%-- <input id="btnGrantExperience" type="button" value="赠送经验" class="btn wd2" onclick="GrantManager('GrantExperience')" />--%>
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
            <tr align="center" class="bold">
                <td class="listTitle1">
                    <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
                </td>
                <td class="listTitle2">
                    用户标识
                </td>
                <td class="listTitle2">
                    用户帐号
                </td>                
                <td class="listTitle">
                    性别
                </td>
                 <td class="listTitle2">
                    余额
                </td>
                <td class="listTitle2">
                    <%=BankMoneyName%>余额
                </td>
                 <td class="listTitle2">
                    幸运币
                </td>
                <td class="listTitle">
                    一级比例
                </td> 
                <td class="listTitle">
                    注册时间
                </td>
                <td class="listTitle">
                    注册地址
                </td>
                <td class="listTitle">
                    登录数
                </td>
                <td class="listTitle">
                    游戏/在线时长
                </td>
                <td class="listTitle">
                    最后登录时间
                </td>
                <td class="listTitle">
                    最后登录地址
                </td>
                <td class="listTitle">
                    状态
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("UserID").ToString()%>' />
                        </td>
                        <td>
                             
                            <%#string.Format( "<span class=\"{0}\">{1}</span>",(byte) Eval( "IsSpreader" ) == 1 ? "lan bold" : "", Eval( "UserID" ).ToString( ) )%>
                        </td>
                        <td title="<%# Eval( "Accounts" ).ToString()%>">
                        <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                        </td>                     
                        <td>
                            <%# Eval( "Gender" ).ToString()=="1"?"男":"女"%>
                        </td>
                          <td>
                            <%# GetScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# GetInsureScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                         <td>
                            <%#  Eval( "UserMedal" ).ToString()%>
                        </td>
                        <td>
                            <%#double.Parse( Eval( "SpreaderScale" ).ToString()).ToString("0%")%>
                        </td>                      
                      
                        <td>
                            <%# Eval( "RegisterDate" ).ToString()%>
                        </td>
                         <td title="<%# Game.Utils.IPQuery.GetAddressWithIP( Eval("RegisterIP").ToString())%>">
                            <%#Game.Utils.TextUtility.CutString( Game.Utils.IPQuery.GetAddressWithIP( Eval("RegisterIP").ToString()),0,6)%>
                        </td>
                        <td>
                            <%# Eval( "GameLogonTimes" ).ToString()%>
                        </td>
                        <td>
                            <%# Eval( "PlayTimeCount" ).ToString( ) + "/" + Eval( "OnLineTimeCount" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "LastLogonDate" ).ToString()%>
                        </td>
                      <td title="<%# Game.Utils.IPQuery.GetAddressWithIP( Eval("LastLogonIP").ToString())%>">
                            <%#Game.Utils.TextUtility.CutString( Game.Utils.IPQuery.GetAddressWithIP( Eval( "LastLogonIP" ).ToString( ) ), 0, 6 )%>
                        </td>
                        <td>
                            <%# GetNullityStatus((byte)Eval("Nullity"))%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("UserID").ToString()%>' />
                        </td>
                        <td>
                          
                            <%#string.Format( "<span class=\"{0}\">{1}</span>",(byte) Eval( "IsSpreader" ) == 1 ? "lan bold" : "", Eval( "UserID" ).ToString( ) )%>
                        </td>
                        <td title="<%# Eval( "Accounts" ).ToString()%>">
                            <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                        </td>                      
                        <td>
                            <%# Eval( "Gender" ).ToString()=="1"?"男":"女"%>
                        </td>
                          <td>
                            <%# GetScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# GetInsureScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%#  Eval( "UserMedal" ).ToString()%>
                        </td>
                        <td>
                            <%#double.Parse( Eval( "SpreaderScale" ).ToString()).ToString("0%")%>
                        </td>                      
                       
                        <td>
                            <%# Eval( "RegisterDate" ).ToString()%>
                        </td>
                         <td title="<%# Game.Utils.IPQuery.GetAddressWithIP( Eval("RegisterIP").ToString())%>">
                            <%#Game.Utils.TextUtility.CutString( Game.Utils.IPQuery.GetAddressWithIP( Eval("RegisterIP").ToString()),0,6)%>
                        </td>
                        <td>
                            <%# Eval( "GameLogonTimes" ).ToString()%>
                        </td>
                        <td>
                            <%# Eval( "PlayTimeCount" ).ToString( ) + "/" + Eval( "OnLineTimeCount" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "LastLogonDate" ).ToString()%>
                        </td>
                       <td title="<%# Game.Utils.IPQuery.GetAddressWithIP( Eval("LastLogonIP").ToString())%>">
                            <%#Game.Utils.TextUtility.CutString( Game.Utils.IPQuery.GetAddressWithIP( Eval( "LastLogonIP" ).ToString( ) ), 0, 6 )%>
                        </td>
                        <td>
                            <%# GetNullityStatus((byte)Eval("Nullity"))%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg">
                <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
            </td>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpNews" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="True">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
   <%-- <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
               
                <asp:Button ID="btnDongjie1" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click" OnClientClick="return GrantManager('')" />
                <asp:Button ID="btnJiedong1" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click" OnClientClick="return GrantManager('')" />
                <input class="btnLine" type="button" />
                <input id="btnGrantTreasure2" type="button" value="赠送金币" class="btn wd2" onclick="GrantManager('GrantTreasure')" />               
                <input id="btnGrantExperience2" type="button" value="赠送经验" class="btn wd2" onclick="GrantManager('GrantExperience')" />
            </td>
        </tr>
    </table>--%>
    </form>
</body>
</html>

