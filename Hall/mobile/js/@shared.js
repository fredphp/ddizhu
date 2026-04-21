if(history.pushState) History=history;

var param=location.search.substring(1).split('&'),data={},pay={alipay:[],wechat:[],banks:[]},gis={},now=new Date(),acc="",txt=$("<textarea></textarea>"),url=location.protocol.indexOf("http")?"/WS/Validate.ashx/Hall":"/WS/Validate.ashx/Hall";
for(var i=0,len=param.length;i<len;i++){var kv=param[i].split("=");data[kv[0]]=kv[1]}
$.support.cors=true;

$(window).on("popstate",function(e){updateContent(e.state)});
History.replaceState(location.search.substring(1),document.title,location.href);

$("dl").ready(function(){
  History.replaceState(null,document.title,location.pathname);
  if($("body>:first-child").is("dl")||(($("body>:first-child").is("button")||$("body>:first-child").is("header"))&&$("body>:nth-child(2)").is("dl"))) updateContent(location.search.substring(1));
  $("input[type=date]").val(function(){return this.name=="to"?getDate(new Date(Date.now()+864e5)):getDate(now)});
}).find(">dt:not(.null)").on("click",function() { $(this).addClass("active").siblings("dt").removeClass("active") }).find(">a").on("click",function(e) { var url=e.target.href; History.pushState(null,null,url); updateContent(url.slice(url.indexOf("?")+1)); return false });

function updateContent(o) {
  var ura=(o?o:location.search.substring(1)).split("/");
  var url=ura.pop()||ura.pop();
  if(!isNaN(url)){
    try{$('li[aid="'+url+'"]').get(0).click()}catch(e){}
    url=ura.pop()
  }else{
    if(url&&url.indexOf("=")>-1) url="Home"/*fix IE 8*/;
    var obj=$("dt."+(url||"Home")+"+dd");
    if($(obj).is(":has(>article)")) $(">article",obj).hide().siblings(":not(article)").show()
  }
  $("dt."+(url||"Home")).get(0).click()
}

$("dt.item+dd>a,dt.disp+dd>a,dt.list+dd>a").on("click",function(e){var url=e.target.href;History.pushState(null,null,url);updateContent(url.slice(url.indexOf("?")+1));return false});
$("dt.popw+dd>ul>li>a").on("click",function(e){if(this.href.indexOf("android")>0) return false;$("iframe").attr("src",href).show();return false});

try{$("dt.wheel").on("click",getWinners).find("+dd>#disc").rotate(Math.random()*360+"deg")}catch(e){}
try{$(".modal>.close").on('click',function(){$(".modal").hide("slow")})}catch(e){}
$(".msg>button").on("click",function(){$(this).parent().hide()});
$("dt.mobipay+dd input[name=payment]").on("change",function() {
  var val=this.value;
  var e=pay[val][0];
  $('dt.mobipay+dd>form label[for="dsp"]').html(["支付宝","微信"][["alipay","wechat"].indexOf(val)]+"名称：");
  $('dt.mobipay+dd>form select[name="acc"]').html("<option value='"+e.id+"' selected>"+e.name+"</option>");
  $("dt.mobipay+dd>form p.img>img").attr("src","http://img.ifeng7777.com"+e.code);
});

$("select[name=bnk]").on("change",function(){
  if(!this.selectedIndex){
    $("table.bank").hide();
    $("select[name=bnk]+a").hide();
    return;
  }
  var bnk=pay.banks[this.selectedIndex-1];
  var obj=$("table.bank").show().find(">tbody").get(0);
  $("select[name=bnk]+a").attr("href",bnk.url).show();
  $("input",obj.rows[0].cells[1]).val(bnk.name);
  $("input",obj.rows[1].cells[1]).val(bnk.card);
  $(obj.rows[2].cells[1]).html(bnk.addr);
});

//$(document).ajaxSuccess(function(){$("dt.wheel+dd>.list").marquee({dir:"up",step:2})});
var wrid;
function getWinners(){//活动中心-幸运大转盘
  if(wrid) clearTimeout(wrid);
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"roulette"},
    success:function(data){
      var obj=$("dt.wheel+dd>.list>ul").html("");
      $.each(data,function(i,e){obj.append("<li>"+e.c+" 恭喜玩家<b>"+e.a+"</b><br>在幸运抽奖中获得奖金<b>"+e.w+"</b>！</li>")});
      obj.parent().marquee({dir:"up",step:40});
    }
  });
  wrid=setTimeout(getWinners,60000);
}

function getTime(s){var ts=new Date(null);ts.setSeconds(s);return ts.toJSON().substr(11,8)}

function getDate(o){var f=function(n){return n<10?'0'+n:n};return o.getFullYear()+"-"+f(o.getMonth()+1)+'-'+f(o.getDate())}

function getRecord(){//个人中心-游戏记录
  var obj=this.parentNode,did=$(obj).attr("draw")||0;
  obj=$(">table",obj);
  if($(obj).css("display")=="table"){$(obj).hide();return}
  $("ul.game table").hide();
  obj.show();

  obj=$(">tbody",obj);
  if(obj.html()) return;
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"game",uid:data.uid,pwd:data.pwd,from:$(this).find("input[name=from]").val(),to:$(this).find("input[name=to]").val(),did:did},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      $.each(data,function(i,e){$(obj).append('<tr><td>'+e.a+'</td><td>'+e.s+'</td><td>'+e.r+'</td><td>'+e.m+'</td></tr>')});
    }
  });
  return false;
}

function getRule(){//比赛中心
  $('div.rule').show();
  $('div.rank').hide();

  var mid=$(this.parentNode).attr('match');
  var tid=$(this.parentNode).attr('time');
  var obj=$('div.rule ul').html('<li style="color:#888">加载中</li>');
  obj.parent().height(obj.height()+85);
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"match",uid:data.uid,pwd:data.pwd,mid:mid,tid:tid},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}

      obj.html("");
      $.each(data,function(i,e){if(e.Reward) obj.append('<li style="margin-left:125px;padding:0;text-align:left">第'+e.Placing+'名： 奖金 <font>'+e.Reward+'</font></li>')});
      obj.parent().height(obj.height()+85);
    }
  });
}

function getRank(){//比赛中心
  $('div.rank').show();
  $('div.rule').hide();

  var mid=$(this.parentNode).attr('match');

  var obj=$('div.rank tbody').html('<tr><td colspan="5" style="color:#888">加载中</td></tr>');
  obj.parent().parent().height(obj.height()+85);

  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"match",uid:data.uid,pwd:data.pwd,mid:mid},
    success:function(data){
      obj.html("");
      if(data.s){obj.append('<tr><td colspan="5" style="color:#ff0000;font-weight:bold;font-size:14px;text-align:center;margin-top:20px">'+data.m+'</td></tr>');return false}

      $.each(data,function(i,e){if(e) obj.append("<tr><td>"+e.UserPlacing+"</td><td>"+e.Accounts+"</td><td>"+(e.UserReward?e.UserReward:"-")+"</td><td>"+e.WinScore+"</td><td>"+(e.UserReward?"已发放":"-")+"</td></tr>")});
      obj.parent().parent().height(obj.height()+85);
    }
  })
}

function getFee(){//兑换中心
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"withdraw",uid:data.uid,pwd:data.pwd,step:1},
    success:function(data){if(data.s){$(".msg").show().find(">div").html(data.m);return false};tax=data.tax;$('div[step="1"]>span:first-of-type').html(data.sum).next().html(data.tax*100+"%"); $('div[step="1"]>p.tips').html("温馨提示：一天只能兑换"+data.num+"次，最低兑换金额"+Number(data.min).toFixed(2)+"。<br>每笔需收取"+(data.tax*100)+"%服务费（每日首笔免收服务费）。")}
  });
}

function getInfo(){//支付中心
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{pay:"getinf",uid:data.uid,pwd:data.pwd},
    success:function(e){
      if(e.s) return;
      $('input[name="usr"]').val(e.a);
      $('input[name="reu"]').val(e.a);
      $("dt.transfer+dd>form label[for=sum]:last-of-type").html("*最低金额"+Number(e.q).toFixed(2));
      $("dt.netbank+dd>form label[for=sum]:last-of-type").html("最低金额"+Number(e.m).toFixed(2)+"，最高35000.00");
      $("dt.prepaid+dd>form label[for=sum]:last-of-type").html("*点卡充值比例为1:0.9");//比例 e.r
      $("dt.mobipay+dd>form p.msg").html("输入您要充值的金额<b>（最低"+Number(e.p).toFixed(2)+"且不能大于15,000.00）</b>，完成支付后请核对提交财务添加款项到您指定的帐户中。");
      $("select[name=bnk]").html('<option value="-1">=== 请选择银行 ===</option>');
      $.each(e.d,function(i,o){if(o.t=="支付宝") pay.alipay.push({name:o.c,id:o.i,code:o.e});if(o.t=="微信") pay.wechat.push({name:o.c,id:o.i,code:o.e});
        if(o.s==0){
          pay.banks.push({id:o.i,type:o.t,name:o.n,card:o.c,addr:o.a,url:o.u});
          if(!o.t.startsWith("支付宝")) $("select[name=bnk]").append($("<option></option>").attr("value",o.i).text(o.t));
        }
      });
    }
  });
}

function getName(){//用户中心
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"getacc",uid:data.uid,pwd:data.pwd},
    success:function(e){
      if(e.s) return;
      acc=e.a;
    }
  });
}

function getReward(sid,cnt){//领取奖励
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"task",uid:data.uid,pwd:data.pwd,sid:sid,cnt:cnt},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      $(".msg").show().find(">div").html(data.m);
    }
  });
}

function getGifts(){//红包列表
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"luckymoney",uid:data.uid,pwd:data.pwd,lid:-1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("dt.disp+dd>ul").html(""),now=new Date(),list=$("dt.list+dd>ul").html("");
      $.each(data,function(i,e){
        if(e){
          e.ValidityStart=eval(("new "+e.ValidityStart).replace(/\//g,"")),e.ValidityEnd=eval(("new "+e.ValidityEnd).replace(/\//g,""));
          //e.ValidityStart=new Date(e.ValidityStart.getTime()+28800000),e.ValidityEnd=new Date(e.ValidityEnd.getTime()+28800000);
          if(e.recordtime) { e.recordtime=eval(("new "+e.recordtime).replace(/\//g,"")); e.recordtime=new Date(e.recordtime.getTime()+28800000); }
          var sta=e.id?"已领取":e.TotalUser==e.HaveUser?"抢完了":e.ValidityStart>now?"未到时间":e.ValidityEnd<now?"已结束":e.limittype==0?"可领取":"达成条件可领取";
          $(obj).append('<li class="hbl'+(e.dif?"":" new")+'"><img src="../images/lucky/new.png" /><b>'+e.theme+'</b><hr />总金额：<span>'+Number(e.TotalScore).toFixed(2)+'</span><button class="'+["outdated","exhausted","collected","yettocome","grabmoney","grabmoney"][["已结束","抢完了","已领取","未到时间","可领取","达成条件可领取"].indexOf(sta)]+'" rid="'+e.rid+'"></button><div><b>'+e.theme+'</b>金额：<span>'+Number(e.TotalScore).toFixed(2)+'</span><br />数量：<span>'+e.TotalUser+'</span><br />状态：<span>'+sta+'</span><br />时间：<span>'+getDate(e.ValidityStart)+'至'+getDate(e.ValidityEnd)+'</span><br />领取金额：<span>'+Number(e.GetScore).toFixed(2)+'</span><br />领取人数：<span>'+e.HaveUser+'</span></div></li>');
          if(sta=="未到时间") setTimeout(getGifts,e.ValidityStart.getTime()-now.getTime());
          if(e.id) $(list).append("<li><span>"+e.Accounts+"</span><span>"+e.theme+"</span><span>"+e.Score+"</span><span>"+e.recordtime.toJSON().replace("T"," ").substr(0,19)+"</span></li>");
        }});
      $("button[rid].grabmoney",obj).on("click",grabMoney);
    }
  });
}

function grabMoney(){//抢红包
  var obj=$(this).prop("disabled",true);
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"luckymoney",uid:data.uid,pwd:data.pwd,lid:$(this).attr("rid")||0},
    success:function(data){
      $(obj).prop("disabled",false);
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      else{$(".msg").show().find(">div").html(data.m),$(obj).removeClass("grabmoney").addClass("collected")}
    }
  });
}

$("dt.match+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"match",uid:data.uid,pwd:data.pwd,from:$("input[name=from]",this).val(),to:$("input[name=to]",this).val(),sta:$("select[name=status]",this).val()||-1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.match").html("");
      $.each(data,function(i,e){$(obj).append('<li match="'+e.mid+'" time="'+e.tid+'"><span>'+e.x.replace(" (比赛)","")+'</span><span>'+e.c+'</span><span>'+e.k+'</span><span>'+e.w+'</span><span>'+["未开始","比赛中","未奖励","已结束"][e.m]+'</span><span class="rule"><a href="#">规则</a></span><span class="rank"><a href="#">排名</a></span></li>')});
      $(".rule",obj).on("click",getRule).find(">a").on("click",function(){this.parentNode.click();return false});
      $(".rank",obj).on("click",getRank).find(">a").on("click",function(){this.parentNode.click();return false});
    }
  });
  return false;
});

$("dt.lucky+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"lucky",uid:data.uid,pwd:data.pwd,from:$(this).find("input[name=from]").val(),to:$(this).find("input[name=to]").val(),sta:$(this).find("select[name=status]").val()||-1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.lucky").html("");
      $.each(data,function(i,e){$(obj).append('<li><span class="slvzr-first-of-type">'+e.x+'</span><span>'+e.c+'</span><span>'+e.k+'</span><span>'+["未中奖","幸运奖"][e.w]+'</span><span>'+e.n+'</span><span>'+e.m+'</span><span>'+e.b+'</span></li>')});
    }
  });
  return false;
});

$("dt.game+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"game",uid:data.uid,pwd:data.pwd,from:$(this).find("input[name=from]").val(),to:$(this).find("input[name=to]").val(),kid:$(this).find("select[name=game]").val()||-1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.game").html(""),count=0,ts=0,amount=0;
      $.each(data,function(i,e){
        if(e.d){
          ts+=e.l,count++,amount+=(Math.abs(e.b)||0)+(e.r||0),gis[e.d]=e.o,e.x=eval(("new "+e.x).replace(/\//g,"")),e.c=eval(("new "+e.c).replace(/\//g,""));
          e.x=new Date(e.x.getTime()+28800000),e.c=new Date(e.c.getTime()+28800000);
          $(obj).append('<li draw="'+e.d+'"><span class="slvzr-first-of-type">'+e.x.toJSON().replace("T"," ").substr(0,19)+'&nbsp;<a href="">记录</a></span><span>'+e.c.toJSON().replace("T"," ").substr(0,19)+'</span><span>'+getTime(e.l)+'</span><span>'+e.s+'</span><span><a href="javascript:void(0)" onclick="showdrawinfo('+e.d+')">详情</a></span><table><thead><tr><th>用户名</th><th>输赢金额</th><th>税收</th><th>幸运币</th></tr></thead><tbody></tbody></table></li>')
        }
      });
      $(">li>span:first-child",obj).on("click",getRecord).on("click",function(){this.parentNode.click();return false});
      $("dt.game+dd>form .info").html("总局数："+count+"，总时长："+getTime(ts)+"，总流水："+amount.toFixed(2));
    }
  });
  return false;
});

$("dt.paid+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"paid",uid:data.uid,pwd:data.pwd,from:$(this).find("input[name=from]").val(),to:$(this).find("input[name=to]").val()},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.paid").html(""),sum=0;
      $.each(data,function(i,e){sum+=e.w;$(obj).append('<li><span class="slvzr-first-of-type">'+e.x+'</span><span>'+e.c+'</span><span>'+e.k+'</span><span>'+e.w+'</span><span>'+e.m+'</span></li>') });
      $("dt.paid+dd>form>.total").html("符合条件的充值记录总额为"+Number(sum).toFixed(2));
    }
  });
  return false;
});

$("dt.draw+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"draw",uid:data.uid,pwd:data.pwd,from:$(this).find("input[name=from]").val(),to:$(this).find("input[name=to]").val(),sta:$(this).find("select[name=status]").val()||-1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.draw").html("");
      $.each(data,function(i,e){$(obj).append('<li><span class="slvzr-first-of-type">'+e.x+'</span><span>'+e.c+'</span><span>'+e.k+'</span><span>'+["其它","银行"][e.w]+'</span><span>'+e.m+'</span><span>'+["申请中","已处理","拒绝","已提现"][e.n]+'</span><span title="'+e.b+'">'+e.b+'</span></li>') });
    }
  });
  return false;
});

$("dt.rank+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"rank",uid:data.uid,pwd:data.pwd},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.rank").html("");
      $.each(data,function(i,e){$(obj).append('<li uid="'+e.i+'"><span class="slvzr-first-of-type">'+(i+1)+'</span><span>'+e.n+'</span><span>'+e.s+'</span></li>')});
    }
  });
  return false;
});

$("dt.transfer+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{pay:"transfer",uid:data.uid,pwd:data.pwd,usr:$("input[name=usr]",this).val(),reu:$("input[name=reu]",this).val(),sum:$("input[name=sum]",this).val()||0,bid:$("select[name=bnk]",this).val()||0,tid:$("input[name=typ]:checked",this).val()||0,dsp:$("input[name=dsp]",this).val()||""},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      $(".msg").show().find(">div").html(data.m);
    }
  });
  return false;
});

$("dt.netbank+dd>form,dt.cashier+dd>form").on("submit",function() {
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{pay:"netbank",uid:data.uid,pwd:data.pwd,usr:$("input[name=usr]",this).val(),reu:$("input[name=reu]",this).val(),sum:$("input[name=sum]",this).val()||0,bid:$("input[name=bank]:checked",this).val()||""},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return}
      //open().document.write('<title>充值数据处理中...</title><form method="post" action="/Paid?'+data.v+'"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form><script>document.forms[0].submit()</script>');
      //$('<form method="post" action="/Paid?'+data.v+'"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form>').submit();

      $("iframe").show().contents().find("html").html('充值数据处理中...');
      $('<form method="post" action="/Paid?'+data.v+'" target="pay"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form>').submit();
    },
  });
  return false;
});

$("dt.prepaid+dd>form").on("submit",function(){
  var obj=$("input[type=submit]",this).get(0);
  obj.disabled=true;
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{pay:"prepaid",uid:data.uid,pwd:data.pwd,usr:$("input[name=usr]",this).val(),reu:$("input[name=reu]",this).val(),sum:$("input[name=sum]",this).val()||0,cid:$("input[name=card]:checked",this).val()||"",sno:$("input[name=sno]",this).val()||"",psw:$("input[name=psw]",this).val()||""},
    success:function(data){
      $(".msg").show().find(">div").html(data.m);
      obj.disabled=false;
    }
  });
  return false;
});

$("dt.mobipay+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{pay:"mobipay",uid:data.uid,pwd:data.pwd,usr:$("input[name=usr]",this).val(),reu:$("input[name=reu]",this).val(),sum:$("input[name=sum]",this).val()||0,pid:$("input[name=payment]:checked",this).val()||"",aid:$("select[name=acc]",this).val()||"",dsp:$("input[name=dsp]",this).val()||""},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      $(".msg").show().find(">div").html(data.m);
    }
  });
  return false;
});

$("dt.qrpay+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{pay:"qrpay",uid:data.uid,pwd:data.pwd,usr:$("input[name=usr]",this).val(),reu:$("input[name=reu]",this).val(),sum:$("input[name=sum]",this).val()||0,pid:$("input[name=payment]:checked",this).val()||""},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      //open().document.write('<title>充值数据处理中...</title><form method="post" action="/pay.aspx?'+data.v+'"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form><script>document.forms[0].submit()</script>');
      $("iframe").show().contents().find("html").html('充值数据处理中...');
      //if(/^https:\/\/qr\.alipay\.com/i.test(data.u)) { location.href=data.u; return false }
      //location.href="/pay.aspx?"+data.v+"&url="+data.u+"&ref="+data.r;
      $('<form method="post" action="/Paid?'+data.v+'" target="pay"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form>').submit();


      //if(data.u.startsWith("weixin://")||data.u.startsWith("https://qr.alipay.com")) open(url.replace("Hall","QRCode")+"?"+encodeURI(data.u)).document.title="充值数据处理中...";//.document.write("<title>充值数据处理中...</title><meta%20http-equiv=\"refresh\"%20content=\"0;url="++"\"/>");
      //$("iframe").show().contents().find("html").html('充值数据处理中...');
      //if(/Android/i.test(navigator.userAgent))
      //$('<form method="post" action="/pay.aspx?'+data.v+'" target="pay"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form>').submit();
      //try { } catch(e) { }
    }
  });
  return false;
});

$("dt.wapay+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:"/WS/Validate.ashx/Paid",
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{uid:data.uid,pwd:data.pwd,usr:$("input[name=usr]",this).val(),sum:$("input[name=sum]",this).val()||0,pid:$("input[name=payment]:checked",this).val()||""},
    success:function(e){
      if(e.s){$(".msg").show().find(">div").html(data.m);return false}

      $("iframe").show().contents().find("html").html('充值数据处理中...');
      $('<form method="post" action="/Paid?'+data.v+'" target="pay"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form>').submit();


      //location.href=data.u;
      //$('<form method="post" action="/pay.aspx?'+data.v+'"><input name="url" type="hidden" value="'+data.u+'"><input name="ref" type="hidden" value="'+data.r+'"></form>').submit();
      var oid=e.n;
      console.log("for Test:");
      $.ajax({
        contentType:"application/json;charset=utf-8",
        url:"/WS/Validate.ashx/Check",
        type:"POST",
        crossDomain:true,
        dataType:"json",
        data:{uid:data.uid,pwd:data.pwd,oid:oid},
        success:function(e){console.log("succ:"),console.log(e)},
        error:function(e){console.log("error:"),console.log(e)}
      });
    }
  });
  return false;
});

$(".start>button").on("click",function() {
  $("#disc").animate({ rotate: 100*30-15+360*10 },8000,function() { $(this).rotate(100*30-15+"deg") });
  if(!data.uid){$(".msg").show().find(">div").html("运行环境错误！");return}
  var obj=this;
  obj.disabled=true;
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"roulette",uid:data.uid,pwd:data.pwd},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);obj.disabled=false}
      else{
        setTimeout(function(e){e.disabled=false;$(".msg").show().find(">div").html(data.m);if(data.r<12) getWinners()},8000,obj)
        $("#disc").animate({rotate:data.r*30-15+360*10},8000,function(){$(this).rotate(data.r*30-15+"deg")});
     }
    }
  });
});

$("dt.task").on("click",function(){
  if($("ul.task").html()&&Date.now()-now.getTime()<15000) return;
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"task",uid:data.uid,pwd:data.pwd,from:$("input[name=from]",this).val(),to:$("input[name=to]",this).val(),sta:$("input[name=status]",this).val()||-1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.task").html("");
      $.each(data,function(i,e){
        var t=e.t>e.r&&e.u>=e.c*(e.r+1);
        $(obj).append("<li><span class='slvzr-first-of-type'>"+e.n+"</span><span>"+e.c+"</span><span>"+e.s+"</span><span>"+(e.u||0)+"</span><span>"+(e.r>0?e.r+"次":"未领取")+"</span><span style='cursor:pointer' onclick='"+(t?"getReward("+e.i+","+e.c+")":"return")+"'>"+(t?"领取":"未达到")+"</span></li>");
      });
      now=new Date();
    }
  });
  return false;
});

$("dt.inquire").on("click",function() {
  if($("ul.inquire").html()&&Date.now()-now.getTime()<15000) return;
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"withdraw",uid:data.uid,pwd:data.pwd,step:0},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      var obj=$("ul.inquire").html("");
      $.each(data,function(i,e) {
        e.c=eval(("new "+e.c).replace(/\//g,""));
        $(obj).append("<li><span class='slvzr-first-of-type'>"+getDate(e.c)+"</span><span>"+"银行转账"+"</span><span>"+e.o+"</span><span>"+e.b+"</span><span>"+e.a+"</span><span>"+["其它","银行"][e.t]+"</span><span>"+["申请中","已处理","拒绝","已提现"][e.s]+"</span></li>");
      });
      now=Date();
    }
  });
  return false;
});

$("dt.convert+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"withdraw",uid:data.uid,pwd:data.pwd,sum:$("input[name=sum]",this).val()||0,way:$("input[name=way]",this).val()||"",acc:$("input[name=acc]",this).val()||"",rea:$("input[name=rea]",this).val()||"",bnk:$("input[name=bnk]",this).val()||"",usr:$("input[name=usr]",this).val()||"",loc:$("input[name=loc]",this).val()||"",pas:$("input[name=pwd]",this).val()||"",ips:$("input[name=ips]",this).val()||""},
    success:function(data){
      if(data.s){
        if(data.s==7){$(".modal").show();return false;}
        $(".msg").show().find(">div").html(data.m);
        return false;
      }
      step=3;
      toggle();
      $(".nav>.step2").hide();
      $(".modal").hide();
    }
  });
  return false;
});

$(".info>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"withdraw",uid:data.uid,pwd:data.pwd,qqnum:$("input[name=qqnum]",this).val()||"",email:$("input[name=email]",this).val()||"",phone:$("input[name=phone]",this).val()||""},
    success:function(data){
      if(data.s){
        $(".msg").show().find(">div").html(data.m);
        if(data.s==7) $(this).parent().show();
        return false;
      }
      $(this).parent().hide();
    }
  });
  return false;
});

$("dt.statistics+dd>form").on("submit",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"spread",uid:data.uid,pwd:data.pwd,sum:$("input[name=sum]",this).val()||0},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      $(".msg").show().find(">div").html(data.m);
    }
  });
  return false;
});

$('input[type=radio][name="date"]').on("change",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{req:"spread",uid:data.uid,pwd:data.pwd,int:["today","preday","thisweek","lastweek"].indexOf(this.value)},
    success:function(data){
      var obj=$("table.statistics>tbody").get(0);
      $.each(data.s,function(i,e){$(obj.rows[i.substring(5)-1].cells[2]).html(e*100+"%")});
      var revs=0,revTotals=0;
      if(data.r.length>0) $.each(data.r,function(i,e){revs+=e.rev;revTotals+=e.revTotal;$(obj.rows[i].cells[1]).html(e.revTotal);$(obj.rows[i].cells[3]).html(e.rev)});
      $("ul.total>li").eq(0).html("<span>贡献小结：</span> "+revs).next().html("<span>获益小结：</span> "+revTotals).next().html("<span>总抽水：</span> "+data.a).next().html("<span>已提取：</span> "+data.g).next().html("<span>待提取：</span> "+(data.a-data.g));
    }
  });
  return false;
});

$(".copy").on("click",function(){
  var succeed=false;
  if(window.clipboardData)
    try{
      clipboardData.clearData();
      clipboardData.setData("Text",$("input.url").val());
      succeed=true;
    }catch(e){}
  if(!succeed){
    var tmp=$("input.url").get(0);
    tmp.focus();
    tmp.setSelectionRange(0,tmp.value.length);
    try{succeed=document.execCommand("copy")}catch(e){}
  }
  if(succeed) $(".msg").show().find(">div").html("已经成功复制到剪帖板上！");
});

$(".card,.name").on("click",function() {
  var succeed=false;
  if(window.clipboardData)
    try {
      clipboardData.clearData();
      clipboardData.setData("Text",this.val());
      succeed=true;
    } catch(e) { }
  if(!succeed) {
    this.focus();
    this.setSelectionRange(0,this.value.length);
    try { succeed=document.execCommand("copy") } catch(e) { }
  }
  if(succeed) $(".msg").show().find(">div").html("已经成功复制到剪帖板上！");
});


function buyItem(e){
  if($(".modal").is(":hidden")) $(".modal").show();
  else
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"mall",uid:data.uid,pwd:data.pwd,aid:$(e.target.parentNode).attr("aid"),qty:1},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      if(data.g) $("header b").html(data.g);
      //itms=data.i;
      listItem(2);
    }
  });
}

var itms,mems;
function listItem(type){
  if(type==2){
    var obj=$("ul.item").html("");
    $.each(itms,function(i,e){
      //$(obj).append('<li aid="'+e.AwardID+'"><a><p>'+e.AwardName+'</p><div><img src="'+e.SmallImage.replace("/Upload","http://222.187.239.134:802")+'"/></div><p>限价: '+e.Price+'<img src="images/mall/ingot.png"></p></a></li>');
      $(obj).append('<li aid="'+e.AwardID+'"><a href="./detail.html?item/78"><h3>'+e.AwardName+'</h3><img src="'+e.SmallImage.replace("/Upload","http://images.alwgame.com")+'"><b>'+e.Price+'</b></a><button></button></li>');
      //$(obj).append('<li><a href="./detail.html?item/78"><h3>40寸飞利浦电视</h3><img src="http://images.alwgame.com/match/78.jpg"><b>400</b></a><button></button></li>');
    });
    $("button",obj).on("click",buyItem);
  }else{
    var obj=$("ul.member").html("");
    $.each(mems,function(i,e){
      $(obj).append('<li mid="'+e.AwardID+'"><img src="'+e.SmallImage+'"/><p class="p"><b>'+e.MemberName+'</b><i>'+e.Price+'游戏币/月(会员折扣90%)</i></p><a>购&nbsp;买</a></li>');
    });
  }
}

//加载实物购买数据
$("#sw").on("click",function(){
  if(itms) listItem(2);
  else $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"mall",uid:data.uid,pwd:data.pwd,sid:2},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      if(data.g) $("header b").html(data.g);
      itms=data.i;
      listItem(2);
    }
  });
});

//加载会员购买数据
$("#hy").on("click",function(){
  if(mems) listItem(-1);
  else $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data:{act:"mall",uid:data.uid,pwd:data.pwd,sid:10000000},
    success:function(data){
      if(data.s){$(".msg").show().find(">div").html(data.m);return false}
      if(data.g) $("header b").html(data.g);
      mems=data.i;
      listItem(-1);
    }
  });
});


/*
//加载实物购买数据
$("#sw").on("click",function() {
  $.ajax({
    contentType: "application/json;charset=utf-8",
    url: url,
    type: "POST",
    crossDomain: true,
    dataType: "json",
    data: { act: "shop",uid: data.uid,pwd: data.pwd,stnid: "2" },
    success: function(data) {
      var swDiv=$(".sw");
      swDiv.html("");
      $.each(data,function(i,e) {
        if(e.AwardID)
          swDiv.append('<a onclick="mallAlert('+e.AwardID+')" id="AwardID'+e.AwardID+'" data-n="'+e.AwardName+'" data-p="'+e.Price+'" ><p>'+e.AwardName+'</p><div class="img"><img src="'+e.SmallImage.replace("/Upload","http://222.187.239.134:802")+'"/></div><p>限价: '+e.Price+' <img src="images/mall/tb.png"></p></a>')
      });
      var ss=swDiv

    }
  });
});
//*/
//跳转到实物购买
function mallAlert(AwardID) {
  var mallAlert=$("#AwardID"+AwardID);
  var AwardName=mallAlert.attr("data-n");
  var Price=mallAlert.attr("data-p");
  setCookie("AwardID",AwardID,1);
  setCookie("AwardName",AwardName,1);
  setCookie("Price",Price,1);
  window.location.href="mall-alert.html";
}



//加载订单数据
$("#dd").on("click",function(){
  $.ajax({
    contentType:"application/json;charset=utf-8",
    url:url,
    type:"POST",
    crossDomain:true,
    dataType:"json",
    data: { act: "shopOrder",uid: data.uid,pwd: data.pwd,userId: data.uid },
    success: function(data) {
      var swDiv=$(".dd");
      swDiv.html("");
      $.each(data,function(i,e) {
        if(e.OrderID) {
          var orderStatusStr="";
          switch(e.OrderStatus) {
            case 0:
              orderStatusStr="新订单";
              break;
            case 1:
              orderStatusStr="已发货";
              break;
            case 2:
              orderStatusStr="已收货";
              break;
            case 3:
              orderStatusStr="申请退货";
              break;
            case 4:
              orderStatusStr="同意退货";
              break;
            case 5:
              orderStatusStr="拒绝退货";
              break;
            case 6:
              orderStatusStr="退货成功并且已退款";
              break;
          }
          swDiv.append('<tr><td>'+e.TotalAmount+'</td> <td>'+e.BuyDate+'</td> <td>'+e.AwardName+'</td> <td>'+orderStatusStr+'</td></tr>')
        }
      });
    }
  });
});

//提交实物购买订单
$("#swSubmit").on("submit",function() {
  var strAwardID=$("input[name=AwardID]",this).attr("data-v");
  var strCounts=$("input[name=span]",this).attr("data-v");
  var strCompellation=$("input[name=realName]",this).val();
  var strMobilePhone=$("input[name=mobile]",this).val();
  var strQq=$("input[name=qq]",this).val();
  var strProvince=$("select[name=province]",this).val();
  var strCity=$("select[name=city]",this).val();
  var strArea=$("select[name=area]",this).val();
  var strDwellingPlace="";
  var strCitypostalCode=$("input[name=postalCode]",this).val();

  $.ajax({
    contentType: "application/json;charset=utf-8",
    url: url,
    type: "POST",
    crossDomain: true,
    dataType: "json",
    data: { act: "shop",uid: data.uid,pwd: data.pwd,userId: uid,awardID: strAwardID,counts: strCounts,compellation: strCompellation,mobilePhone: strMobilePhone,qq: strQq,province: strProvince,city: strCity,area: strArea,dwellingPlace: strDwellingPlace,postalCode: strCitypostalCode },
    success: function(data) {
      alert(data.m);
    }
  });
});

//提交会员购买订单
function BuyHY(awardId) {
  $.ajax({
    contentType: "application/json;charset=utf-8",
    url: url,
    type: "POST",
    crossDomain: true,
    dataType: "json",
    data: { act: "BuyMember",uid: data.uid,pwd: data.pwd,userId: data.uid,awardID: awardId,counts: "1" },
    success: function(data) {
      alert(data.m);
    }
  });
}