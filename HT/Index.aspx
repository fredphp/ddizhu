<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="MTEwin.Index" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="scripts/JQuery.js"></script>
  <script type="text/javascript" src="scripts/common.js"></script>
  <script type="text/javascript" src="scripts/comm.js"></script>
  <title>网站管理后台</title>

  <script type="text/javascript">
    $(function() {
      $.ajaxSetup({ global: false });
      GetTime();
      CheckMatchTime();
      //takeGold();
      //setInterval("takeGold()", 14400000);
    });

    function GetTime() {
      $.ajax({
        contentType: "application/json",
        url: "WS/WSMatchManager.asmx/GetMatchTime",
        data: "",
        type: "POST",
        dataType: "json",
        success: function(json) {
          var json=eval("("+json.d+")");
          if(json.success=="success") {
            matchtime=json.msg;
            $('#hidematchTimes').val(json.msg);
          }
        },
        error: function(json) {
        }
      });

      setTimeout("GetTime()",600000);
    }

    function CheckMatchTime() {
      var timestr=$('#hidematchTimes').val();
      var time=timestr.split(',');
      var mydate=new Date();
      var timeNow=mydate.toLocaleString();
      for(var i=0;i<time.length;i++) {
        if(dateToInt(time[i])<=getDateTimeNow()) {
          // startEndMatch();

          var timestr1="";
          delete time[i];
          for(var j=0;j<time.length;j++) {
            if(time[j]!=null)
              timestr1+=time[j]+",";
          }
          $('#hidematchTimes').val(timestr1);
        }
      }
      setTimeout("CheckMatchTime()",60000);
    }

    function getDateTimeNow() {
      var timee=new Date();
      var hh=timee.getHours();
      var mm=timee.getMinutes();
      var ss=timee.getSeconds();
      var yy=timee.getFullYear();
      var MM=timee.getMonth()+1;
      var rr=timee.getDate();
      return yy+"1"+MM+"1"+rr+"1"+hh+"1"+mm+"1"+ss;
    }

    function dateToInt(time123) {
      var time=time123;
      time=time.replace('/','1');
      time=time.replace('/','1');
      time=time.replace(' ','1');
      time=time.replace(':','1');
      time=time.replace(':','1');
      return time;
    }

//        function startEndMatch() {
//            $.ajax({
//                contentType: "application/json",
//                url: "WS/WSMatchManager.asmx/StartMatch",
//                data: "",
//                type: "POST",
//                dataType: "json",
//                success: function (json) {
//                },
//                error: function (json) {
//                }
//            });
//        }

        //function takeGold() {
        //    $.ajax({
        //        contentType: "application/json",
        //        url: "WS/Agency.asmx/TakeGold",
        //        data: "",
        //        type: "POST",
        //        dataType: "json",
        //        success: function (json) {
        //        },
        //        error: function (json) {
        //        }
        //    });
        //}
  </script>
</head>
<body class="warper">
  <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <tbody>
      <tr>
        <td class="topIndex">
          <div class="logo left">
            <img src="Images/logo.jpg" />
          </div>
          <div class="left hui f12 Tmg20 lh Lmg10">
            <div>
              欢迎您,<a class="f" href="javascript:openWindow('Module/BackManager/BaseUserUpdate.aspx?param=<%=userExt.UserID %>',500, 354)"
                class="white12"><span class="cheng"><%=userExt.Accounts %></span></a>【<%=roleName%>】
            </div>
            <div>
              <a href="Index.aspx" class="f">后台首页</a> | <a href="LoginOut.aspx" class="f">安全退出</a>
            </div>
          </div>
          <%--<div class="right hui f12 Tmg7 lh Rpd10" ><a href="#" class="f">后台首页</a> | <a href="#" class="f">前台首页</a> | <a href="#" class="f">论坛首页</a></div>--%>
        </td>
      </tr>
      <tr>
        <td>
          <div class="sidebar_a">
            <iframe src="Left.aspx" frameborder="0" style="width: 173px; height: 100%; visibility: inherit"></iframe>
          </div>
          <div class="sidebar_b">
            <iframe name="frm_main_content" id="frm_main_content" height="100%" src="Right.aspx"
              frameborder="no" width="100%"></iframe>
          </div>
        </td>
      </tr>
      <tr>
        <td style="height: 1px">
          <div id="msgBoxDIV" style="position: absolute; width: 100%; padding-top: 4px; display: none; height: 24px; top: 55px; text-align: center;">
            <span class="msg"></span>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
  <input type="hidden" id="hidematchTimes" value="" />
</body>
</html>
