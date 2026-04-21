<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ControlList.aspx.cs" Inherits="MTEwin.Module.WebManager.ControlList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title></title>
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>
  <script type="text/javascript" src="../../scripts/jquery.js"></script>
  <script type="text/javascript" src="../../scripts/comm.js"></script>
  <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>

  <style type="text/css">
    .hide { display: none; }

    .querybox { width: 500px; background: #caebfc; font-size: 12px; line-height: 18px; text-align: left; border-left: 1px solid #066ba4; border-right: 1px solid #066ba4; border-bottom: 1px solid #066ba4; border-top: 1px solid #066ba4; z-index: 999; display: none; position: absolute; top: 150px; left: 200px; padding: 5px; filter: progid:DXImageTransform.Microsoft.DropShadow(color=#9a8559,offX=1,offY=1,positives=true); }

    .tishiaz { position: fixed; left: 0px; top: 0px; z-index: 999999; width: 100%; height: 100%; display: none; }

    .tishiaz_box { cursor: move; max-width: 500px; margin: 0 auto; background-color: #e9e9e9; padding: 20px; line-height: 30px; border-radius: 5px; position: relative; top: 10%; -moz-user-select: none; -webkit-user-select: none; -ms-user-select: none; -khtml-user-select: none; user-select: none; }

    .tishiaz_box > a { position: absolute; right: 10px; top: 10px; }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <div class="tishiaz">
      <div class="tishiaz_box">
        <a id="close1" href="javascript:;">
          <img src="/images/xxx.jpg" alt="close" /></a>
        <table id="table1" style="width: 100%;" cellspacing="0" cellpadding="2" border="1">
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：系统设置 - 控制查询
        </td>
      </tr>
    </table>

    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td style="padding-left: 20px;">房间名称:
                <asp:DropDownList ID="ddlServerID" runat="server">
                </asp:DropDownList>
          <asp:DropDownList ID="DropDownList1" Visible="false" runat="server">
            <asp:ListItem Value="1">库存值修改</asp:ListItem>
            <asp:ListItem Value="2">牌型概率修改</asp:ListItem>
            <asp:ListItem Value="3">库存概率修改</asp:ListItem>
            <asp:ListItem Value="4">区域控修改</asp:ListItem>
            <asp:ListItem Value="5">单控修改</asp:ListItem>
          </asp:DropDownList>
          &nbsp;&nbsp; 普通查询：
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
          <asp:CheckBoxList ID="ckbServerID" runat="server" RepeatDirection="Horizontal" RepeatColumns="6">
          </asp:CheckBoxList>
          <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
          <asp:DropDownList ID="ddlSearch" runat="server">
            <asp:ListItem Value="1">超控帐号</asp:ListItem>
            <asp:ListItem Value="2">超控标识</asp:ListItem>
          </asp:DropDownList>
          <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
            style="cursor: pointer; vertical-align: middle" />
          至
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                      src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                      style="cursor: pointer; vertical-align: middle" />
          <asp:Button ID="btnQuery" runat="server" Text="查询" OnClick="btnQuery_Click" CssClass="btn wd1" />
          <input type="button" value="刷新" class="btn wd1" onclick="location.href=location.href" />
        </td>
      </tr>
    </table>
    <div class="clear"></div>

    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <%--<td class="listTitle" style="width:26px;">
                    <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
                </td>--%>
          <td class="listTitle2">超控标识
          </td>
          <td class="listTitle2">超控帐号
          </td>
          <td class="listTitle2">房间名称
          </td>
          <td class="listTitle2">操作时间
          </td>
          <td class="listTitle2">修改项
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <%--<td style="width: 30px;">
                            <input name='cid' type='checkbox' value='' />
                        </td>--%>
              <td>
                <%#Eval("UserID") %>   
              </td>
              <td>
                <%#Eval("NickName") %>
              </td>
              <td>
                <%#GetGameRoomName(Convert.ToInt32(Eval("ServerID"))) %>
              </td>
              <td>
                <%#Eval("InsertTime") %>
              </td>
              <td>
                <%#Eval("Discription") %>
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
          <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
        </td>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpPage" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="15" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
<script type="text/javascript">
  $(function() { $("#content tr:even").attr("class","listBg"); })
</script>

<!--DIV拖动事件-->
<script type="text/javascript">
  var needMove;
  var bool=false,
    pageX=0,
    pageY=0,
    //需要拖动的目标DIV  
    element=$(".tishiaz_box"),
    eWidth=element.width(),
    eHeight=element.height(),
    //在该DIV的范围内拖动  
    pElement=$(".tishiaz"),
    pWidth=pElement.width(),
    pHeight=pElement.height();
  element.mousedown(function(event) {
    needMove=true;
    var position=element.position();
    pageX=event.pageX-position.left; //鼠标和DIV的相对坐标  
    pageY=event.pageY-position.top;
    //element.css('cursor', 'move');
  });
  element.mouseup(function(event) {
    needMove=false;
  });
  element.mousemove(function(event) {
    if(!needMove) { return; }

    //鼠标在页面的坐标 - 鼠标和DIV的相对坐标 = DIV在页面的坐标          
    var ePageX=event.pageX;
    var ePageY=event.pageY;

    var x=ePageX-pageX;
    var y=ePageY-pageY;
    if(ePageX<=eWidth/2||ePageX>=pWidth-eWidth/2) return;
    if(ePageY<eHeight/2||ePageY>=pHeight-eHeight/2) return;
    element.css("left",x);
    element.css("top",y);
  });
</script>
