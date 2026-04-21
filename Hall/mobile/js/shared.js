if (history.pushState) History = history;

var param = location.search.substring(1).split('&'),
    data = {},
    pay = {
        alipay: [],
        wechat: [],
        banks: []
    },
    gis = {},
    now = new Date(),
    txt = $("<textarea></textarea>"),
    url = location.protocol.indexOf("http") ? "/WS/Validate.ashx/Hall" : "/WS/Validate.ashx/Hall";
for (var i = 0, len = param.length; i < len; i++) {
    var kv = param[i].split("=");
    data[kv[0]] = kv[1]
}
$.support.cors = true;

$(window).on("popstate", function(e) {
    updateContent(e.state)
});
History.replaceState(location.search.substring(1), document.title, location.href);

$("dl").ready(function() {
    //History.replaceState(null, document.title, location.pathname);
    if ($("body>:first-child").is("dl") || ($("body>:first-child").is("button") && $("body>:nth-child(2)").is("dl"))) updateContent(location.search.substring(1));
    $("input[type=date]").val(function() {
        return this.name == "to" ? getDate(new Date(Date.now() + 864e5)) : getDate(now)
    });
}).find(">dt").on("click", function() {
    $(this).addClass("active").siblings("dt").removeClass("active")
}).find(">a").on("click", function(e) {
    var url = e.target.href;
    History.pushState(null, null, url);
    updateContent(url.slice(url.indexOf("?") + 1));
    return false
});

function updateContent(o) {
    var ura = (o ? o : location.search.substring(1)).split("/");
    var url = ura.pop() || ura.pop();
    if (!isNaN(url)) {
        try {
            $('li[aid="' + url + '"]').get(0).click()
        } catch (e) {};
        url = ura.pop()
    } else {
        if (url && url.indexOf("=") > -1) url = "Home" /*fix IE 8*/ ;
        var obj = $("dt." + (url || "Home") + "+dd");
        if ($(obj).is(":has(>article)")) $(">article", obj).hide().siblings(":not(article)").show()
    }
    $("dt." + (url || "Home")).get(0).click()
}
/*
(function(){var WebP=new Image();WebP.onload=WebP.onerror=function(){
if(WebP.height!=2){var sc=document.createElement('script');sc.type='text/javascript';sc.async=true;
var s=document.getElementsByTagName('script')[0];sc.src='js/webp.js';s.parentNode.insertBefore(sc,s);}};
WebP.src='data:image/webp;base64,UklGRjoAAABXRUJQVlA4IC4AAACyAgCdASoCAAIALmk0mk0iIiIiIgBoSygABc6WWgAA/veff/0PP8bA//LwYAAA';})();
//*/
$("dt.item+dd>a,dt.disp+dd>a,dt.list+dd>a").on("click", function(e) {
    if (this.href.indexOf("android") > 0) return false;
    var url = e.target.href;
    History.pushState(null, null, url);
    updateContent(url.slice(url.indexOf("?") + 1));
    return false
});
$("dt.popw+dd>ul>li>a").on("click", function(e) {
    $("iframe").attr("src", href).show();
    return false
});

try {
    $("dt.wheel").on("click", getWinners).find("+dd>#disc").rotate(Math.random() * 360 + "deg")
} catch (e) {}
try {
    $(".modal>.close").on('click', function() {
        $(this).parent().hide("slow")
    })
} catch (e) {}
$(".msg>button").on("click", function() {
    $(this).parent().hide()
});
$(".moneymsg>button").on("click", function() {
    $(this).parent().hide()
});
$("dt.mobipay+dd input[name=payment]").on("change", function() {
    var val = this.value;
    var e = pay[val][0];
    $('dt.mobipay+dd>form label[for="dsp"]').html(["支付宝", "微信"][
        ["alipay", "wechat"].indexOf(val)
    ] + "名称：");
    $('dt.mobipay+dd>form select[name="acc"]').html("<option value='" + e.id + "' selected>" + e.name + "</option>");
    $("dt.mobipay+dd>form p.img>img").attr("src", "http://img.ifeng7777.com" + e.code);
});

$("select[name=bnk]").on("change", function() {
    if (!this.selectedIndex) {
        $("table.bank").hide();
        $("select[name=bnk]+a").hide();
        return;
    }
    var bnk = pay.banks[this.selectedIndex - 1];
    var obj = $("table.bank").show().find(">tbody").get(0);
    $("select[name=bnk]+a").attr("href", bnk.url).show();
    $("input", obj.rows[0].cells[1]).val(bnk.name);
    $("input", obj.rows[1].cells[1]).val(bnk.card);
    $(obj.rows[2].cells[1]).html(bnk.addr);
});

//$(document).ajaxSuccess(function(){$("dt.wheel+dd>.list").marquee({dir:"up",step:2})});
var wrid;

function getWinners() { //活动中心-幸运大转盘
    if (wrid) clearTimeout(wrid);
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "roulette"
        },
        success: function(data) {
            var obj = $("dt.wheel+dd>.list>ul").html("");
            $.each(data, function(i, e) {
                obj.append("<li>恭喜玩家<b>" + e.a + "</b><br>在幸运抽奖中获得奖金<b>" + e.w + "</b>！</li>")
            });
            obj.parent().marquee({
                dir: "up",
                step: 40
            });
        }
    });
    wrid = setTimeout(getWinners, 60000);
}

function getTime(s) {
    var ts = new Date(null);
    ts.setSeconds(s);
    return ts.toJSON().substr(11, 8)
}

function getDate(o) {
    var f = function(n) {
        return n < 10 ? '0' + n : n
    };
    return o.getFullYear() + "-" + f(o.getMonth() + 1) + '-' + f(o.getDate())
}

function getRecord() { //个人中心-游戏记录
    var obj = this.parentNode,
        did = $(obj).attr("draw") || 0;
    obj = $(">table", obj);
    if ($(obj).css("display") == "table") {
        $(obj).hide();
        return
    }
    $("ul.game table").hide();
    obj.show();

    obj = $(">tbody", obj);
    if (obj.html()) return;
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "game",
            uid: data.uid,
            pwd: data.pwd,
            from: $(this).find("input[name=from]").val(),
            to: $(this).find("input[name=to]").val(),
            did: did
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            $.each(data, function(i, e) {
                $(obj).append('<tr><td>' + e.a + '</td><td>' + e.s + '</td><td>' + e.r + '</td><td>' + e.m + '</td></tr>')
            });
        }
    });
    return false;
}

function getRule() { //比赛中心
    $('div.rule').show();
    $('div.rank').hide();

    var mid = $(this.parentNode).attr('match');
    var tid = $(this.parentNode).attr('time');
    var obj = $('div.rule ul').html('<li style="color:#888">加载中</li>');
    obj.parent().height(obj.height() + 85);
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "match",
            uid: data.uid,
            pwd: data.pwd,
            mid: mid,
            tid: tid
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }

            obj.html("");
            $.each(data, function(i, e) {
                if (e.Reward) obj.append('<li style="margin-left:125px;padding:0;text-align:left">第' + e.Placing + '名： 奖金 <font>' + e.Reward + '</font></li>')
            });
            obj.parent().height(obj.height() + 85);
        }
    });
}

function getRank() { //比赛中心
    $('div.rank').show();
    $('div.rule').hide();

    var mid = $(this.parentNode).attr('match');

    var obj = $('div.rank tbody').html('<tr><td colspan="5" style="color:#888">加载中</td></tr>');
    obj.parent().parent().height(obj.height() + 85);

    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "match",
            uid: data.uid,
            pwd: data.pwd,
            mid: mid
        },
        success: function(data) {
            obj.html("");
            if (data.s) {
                obj.append('<tr><td colspan="5" style="color:#ff0000;font-weight:bold;font-size:14px;text-align:center;margin-top:20px">' + data.m + '</td></tr>');
                return false
            }

            $.each(data, function(i, e) {
                if (e) obj.append("<tr><td>" + e.UserPlacing + "</td><td>" + e.Accounts + "</td><td>" + (e.UserReward ? e.UserReward : "-") + "</td><td>" + e.WinScore + "</td><td>" + (e.UserReward ? "已发放" : "-") + "</td></tr>")
            });
            obj.parent().parent().height(obj.height() + 85);
        }
    })
}

function getFee() { //兑换中心
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "withdraw",
            uid: data.uid,
            pwd: data.pwd,
            step: 1
        },
        success: function(data) {
                if (data.s) {
                    $(".msg").show().find(">div").html(data.m);
                    return false
                };
                tax = data.tax;
                $('div[step="1"]>span:first-of-type').html(data.sum).next().html(data.tax * 100 + "%");
                $('div[step="1"]>p.tips').html("豪门世纪星游戏平台禁止多账号注册，如发现多账号注册将永久冻结相关账号并不予兑换。")
            } //.html("温馨提示：一天只能兑换"+data.num+"次，最低兑换金额"+Number(data.min).toFixed(2)+"。每笔需收取"+(Number(data.tax)*100)+"%服务费（每日首笔免收服务费）。豪门世纪星游戏平台禁止多账号注册，如发现多账号注册将永久冻结相关账号并不予兑换。")
    });
}

function getInfo() { //支付中心
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            pay: "getinf",
            uid: data.uid,
            pwd: data.pwd
        },
        success: function(e) {
            if (e.s) return;
            $('input[name="usr"]').val(e.a);
            $('input[name="reu"]').val(e.a);
            $("dt.transfer+dd>form label[for=sum]:last-of-type").html("*最低金额" + Number(e.q).toFixed(2));
            $("dt.netbank+dd>form label[for=sum]:last-of-type").html("最低金额" + Number(e.m).toFixed(2));
            $("dt.prepaid+dd>form label[for=sum]:last-of-type").html("*点卡充值比例为1:0.9"); //比例 e.r
            $("dt.mobipay+dd>form p.msg").html("输入您要充值的金额<b>（最低" + Number(e.p).toFixed(2) + "且不能大于15,000.00）</b>，完成支付后请核对提交财务添加款项到您指定的帐户中。");
            $("select[name=bnk]").html('<option value="-1">=== 请选择银行 ===</option>');
            $.each(e.d, function(i, o) {
                if (o.t == "支付宝") pay.alipay.push({
                    name: o.c,
                    id: o.i,
                    code: o.e
                });
                if (o.t == "微信") pay.wechat.push({
                    name: o.c,
                    id: o.i,
                    code: o.e
                });
                if (o.s == 0) {
                    pay.banks.push({
                        id: o.i,
                        type: o.t,
                        name: o.n,
                        card: o.c,
                        addr: o.a,
                        url: o.u
                    });
                    $("select[name=bnk]").append($("<option></option>").attr("value", o.i).text(o.t));
                }
            });
        }
    });
}

function getReward(sid, cnt) { //领取奖励
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "task",
            uid: data.uid,
            pwd: data.pwd,
            sid: sid,
            cnt: cnt
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            $(".msg").show().find(">div").html(data.m);
        }
    });
}

function getGifts() { //红包列表
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "luckymoney",
            uid: data.uid,
            pwd: data.pwd,
            lid: -1
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("dt.disp+dd>ul").html(""),
                now = new Date(),
                list = $("dt.list+dd>ul").html("");
            $.each(data, function(i, e) {
                if (e) {
                    e.ValidityStart = eval(("new " + e.ValidityStart).replace(/\//g, "")), e.ValidityEnd = eval(("new " + e.ValidityEnd).replace(/\//g, ""));
                    //e.ValidityStart=new Date(e.ValidityStart.getTime()+28800000),e.ValidityEnd=new Date(e.ValidityEnd.getTime()+28800000);
                    if (e.recordtime) {
                        e.recordtime = eval(("new " + e.recordtime).replace(/\//g, ""));
                        e.recordtime = new Date(e.recordtime.getTime() + 28800000);
                    }
                    var sta = e.id ? "已领取" : e.TotalUser == e.HaveUser ? "抢完了" : e.ValidityStart > now ? "未到时间" : e.ValidityEnd < now ? "已结束" : e.limittype == 0 ? "可领取" : "达成条件可领取";
                    $(obj).append('<li class="hbl' + (e.dif ? "" : " new") + '"><img src="../images/lucky/new.png" /><b>' + e.theme + '</b><hr />总金额：<span>' + Number(e.TotalScore).toFixed(2) + '</span><button class="' + ["outdated", "exhausted", "collected", "yettocome", "grabmoney", "grabmoney"][
                        ["已结束", "抢完了", "已领取", "未到时间", "可领取", "达成条件可领取"].indexOf(sta)
                    ] + '" rid="' + e.rid + '"></button><div><b>' + e.theme + '</b>金额：<span>' + Number(e.TotalScore).toFixed(2) + '</span><br />数量：<span>' + e.TotalUser + '</span><br />状态：<span>' + sta + '</span><br />时间：<span>' + getDate(e.ValidityStart) + '至' + getDate(e.ValidityEnd) + '</span><br />领取金额：<span>' + Number(e.GetScore).toFixed(2) + '</span><br />领取人数：<span>' + e.HaveUser + '</span></div></li>');
                    if (sta == "未到时间") setTimeout(getGifts, e.ValidityStart.getTime() - now.getTime());
                    if (e.id) $(list).append("<li><span>" + e.Accounts + "</span><span>" + e.theme + "</span><span>" + e.Score + "</span><span>" + e.recordtime.toJSON().replace("T", " ").substr(0, 19) + "</span></li>");
                }
            });
            $("button[rid].grabmoney", obj).on("click", grabMoney);
        }
    });
}

function grabMoney() { //抢红包
    var obj = $(this).prop("disabled", true);
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "luckymoney",
            uid: data.uid,
            pwd: data.pwd,
            lid: $(this).attr("rid") || 0
        },
        success: function(data) {
            $(obj).prop("disabled", false);
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            } else {
                $(".msg").show().find(">div").html(data.m), $(obj).removeClass("grabmoney").addClass("collected")
            }
        }
    });
}

$("dt.match+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "match",
            uid: data.uid,
            pwd: data.pwd,
            from: $("input[name=from]", this).val(),
            to: $("input[name=to]", this).val(),
            sta: $("select[name=status]", this).val() || -1
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.match").html("");
            $.each(data, function(i, e) {
                $(obj).append('<li match="' + e.mid + '" time="' + e.tid + '"><span>' + e.x.replace(" (比赛)", "") + '</span><span>' + e.c + '</span><span>' + e.k + '</span><span>' + e.w + '</span><span>' + ["未开始", "比赛中", "未奖励", "已结束"][e.m] + '</span><span class="rule"><a href="#">规则</a></span><span class="rank"><a href="#">排名</a></span></li>')
            });
            $(".rule", obj).on("click", getRule).find(">a").on("click", function() {
                this.parentNode.click();
                return false
            });
            $(".rank", obj).on("click", getRank).find(">a").on("click", function() {
                this.parentNode.click();
                return false
            });
        }
    });
    return false;
});

$("dt.lucky+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "lucky",
            uid: data.uid,
            pwd: data.pwd,
            from: $(this).find("input[name=from]").val(),
            to: $(this).find("input[name=to]").val(),
            sta: $(this).find("select[name=status]").val() || -1
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.lucky").html("");
            $.each(data, function(i, e) {
                $(obj).append('<li><span class="slvzr-first-of-type">' + e.x + '</span><span>' + e.c + '</span><span>' + e.k + '</span><span>' + ["未中奖", "幸运奖"][e.w] + '</span><span>' + e.n + '</span><span>' + e.m + '</span><span>' + e.b + '</span></li>')
            });
        }
    });
    return false;
});

$("dt.game+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "game",
            uid: data.uid,
            pwd: data.pwd,
            from: $(this).find("input[name=from]").val(),
            to: $(this).find("input[name=to]").val(),
            kid: $(this).find("select[name=game]").val() || -1
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.game").html(""),
                count = 0,
                ts = 0,
                amount = 0;
            $.each(data, function(i, e) {
                if (e.d) {
                    ts += e.l, count++, amount += (Math.abs(e.b) || 0) + (e.r || 0), gis[e.d] = e.o, e.x = eval(("new " + e.x).replace(/\//g, "")), e.c = eval(("new " + e.c).replace(/\//g, ""));
                    e.x = new Date(e.x.getTime() + 28800000), e.c = new Date(e.c.getTime() + 28800000);
                    $(obj).append('<li draw="' + e.d + '"><span class="slvzr-first-of-type">' + e.x.toJSON().replace("T", " ").substr(0, 19) + '&nbsp;<a href="">记录</a></span><span>' + e.c.toJSON().replace("T", " ").substr(0, 19) + '</span><span>' + getTime(e.l) + '</span><span>' + e.s + '</span><span><a href="javascript:void(0)" onclick="showdrawinfo(' + e.d + ')">详情</a></span><table><thead><tr><th>用户名</th><th>输赢金额</th><th>税收</th><th>幸运币</th></tr></thead><tbody></tbody></table></li>')
                }
            });
            $(">li>span:first-child", obj).on("click", getRecord).on("click", function() {
                this.parentNode.click();
                return false
            });
            $("dt.game+dd>form .info").html("总局数：" + count + "，总时长：" + getTime(ts) + "，总流水：" + amount.toFixed(2));
        }
    });
    return false;
});

$("dt.paid+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "paid",
            uid: data.uid,
            pwd: data.pwd,
            from: $(this).find("input[name=from]").val(),
            to: $(this).find("input[name=to]").val()
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.paid").html(""),
                sum = 0;
            $.each(data, function(i, e) {
                sum += e.w;
                $(obj).append('<li><span class="slvzr-first-of-type">' + e.x + '</span><span>' + e.c + '</span><span>' + e.k + '</span><span>' + e.w + '</span><span>' + e.m + '</span></li>')
            });
            $("dt.paid+dd>form>.total").html("符合条件的充值记录总额为" + Number(sum).toFixed(2));
        }
    });
    return false;
});

$("dt.draw+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "draw",
            uid: data.uid,
            pwd: data.pwd,
            from: $(this).find("input[name=from]").val(),
            to: $(this).find("input[name=to]").val(),
            sta: $(this).find("select[name=status]").val() || -1
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.draw").html("");
            $.each(data, function(i, e) {
                $(obj).append('<li><span class="slvzr-first-of-type">' + e.x + '</span><span>' + e.c + '</span><span>' + e.k + '</span><span>' + ["其它", "银行"][e.w] + '</span><span>' + e.m + '</span><span>' + ["申请中", "已处理", "拒绝", "已提现"][e.n] + '</span><span title="' + e.b + '">' + e.b + '</span></li>')
            });
        }
    });
    return false;
});

$("dt.transfer+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            pay: "transfer",
            uid: data.uid,
            pwd: data.pwd,
            usr: $("input[name=usr]", this).val(),
            reu: $("input[name=reu]", this).val(),
            sum: $("input[name=sum]", this).val() || 0,
            bid: $("select[name=bnk]", this).val() || 0,
            tid: $("input[name=typ]:checked", this).val() || 0,
            dsp: $("input[name=dsp]", this).val() || ""
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            $(".msg").show().find(">div").html(data.m);
        }
    });
    return false;
});

$("dt.netbank+dd>form,dt.cashier+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            pay: "netbank",
            uid: data.uid,
            pwd: data.pwd,
            usr: $("input[name=usr]", this).val(),
            reu: $("input[name=reu]", this).val(),
            sum: $("input[name=sum]", this).val() || 0,
            bid: $("input[name=bank]:checked", this).val() || ""
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return
            }
            $("iframe").show().contents().find("html").html('充值数据处理中...').attr("src", data.u + "?" + data.v);
            //$("u")
            //$('<form method="post" action="/WS/Validate.ashx/Paid?' + data.v + '" target="pay"><input name="url" type="hidden" value="' + data.u + '"><input name="ref" type="hidden" value="' + data.r + '"></form>').submit();
        },
    });
    return false;
});

$("dt.prepaid+dd>form").on("submit", function() {
    var obj = $("input[type=submit]", this).get(0);
    obj.disabled = true;
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            pay: "prepaid",
            uid: data.uid,
            pwd: data.pwd,
            usr: $("input[name=usr]", this).val(),
            reu: $("input[name=reu]", this).val(),
            sum: $("input[name=sum]", this).val() || 0,
            cid: $("input[name=card]:checked", this).val() || "",
            sno: $("input[name=sno]", this).val() || "",
            psw: $("input[name=psw]", this).val() || ""
        },
        success: function(data) {
            $(".msg").show().find(">div").html(data.m);
            obj.disabled = false;
        }
    });
    return false;
});

$("dt.mobipay+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            pay: "mobipay",
            uid: data.uid,
            pwd: data.pwd,
            usr: $("input[name=usr]", this).val(),
            reu: $("input[name=reu]", this).val(),
            sum: $("input[name=sum]", this).val() || 0,
            pid: $("input[name=payment]:checked", this).val() || "",
            aid: $("select[name=acc]", this).val() || "",
            dsp: $("input[name=dsp]", this).val() || ""
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            $(".msg").show().find(">div").html(data.m);
        }
    });
    return false;
});

$(".qrpay111+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            pay: "qrpay",
            uid: data.uid,
            pwd: data.pwd,
            usr: $("input[name=usr]", this).val(),
            reu: $("input[name=reu]", this).val(),
            sum: $("input[name=sum]", this).val() || 0,
            pid: $("input[name=payment]:checked", this).val() || ""
        },
        success: function(o) {
            if (data.uid == 7515) alert(JSON.stringify(o));
            if (o.s) {
                $(".msg").show().find(">div").html(o.m);
                return false
            }
            $("iframe").show().contents().find("html").html('充值数据处理中......');
            if (/^(weixin:\/\/wap\/pay\?)|(https:\/\/qr\.alipay\.com\/)/i.test(o.u)) {
                if (data.uid == 7515) alert(o.u);
                location = o.u;
                return false
            } else if (/^weixin:\/\/wxpay\/bizpayurl\?/i.test(o.u)) {
                $("iframe").show().contents().find("html").html('<style>body{margin:0;padding:0}img{display:block;margin:0 auto;max-width:90vh}figcaption{text-align:center}</style><figure><img src="data:image/png;base64,' + o.d + '"><figcaption>（点击手机屏幕弹出二维码）请用微信扫一扫支付</figcaption></figure><script>document.getElementById("img").crossOrigin="Anonymous"</script>');
                return false
            } else if (/^data:/i.test(o.u)) {
                $("iframe").attr("src", o.u + o.d);
                return false
            }
            //if(/Android/i.test(navigator.userAgent)){try{ $('<form method="post" action="/mobile/pay.aspx?'+o.v+'" target="pay"><input name="url" type="hidden" value="'+o.u+'"><input name="ref" type="hidden" value="'+o.r+'"></form>').submit() } catch(e) { location.href="/V/Paid?"+o.v+"&url="+o.u+"&ref="+o.r }; return; }
            //location.href="/V/Paid?"+o.v+"&url="+o.u+"&ref="+o.r;//}catch(e){open("/mobile/pay.aspx?"+o.v+"&url="+o.u+"&ref="+o.r)}
            $("iframe").attr("src", o.u + "?" + o.v);
            //$('<form method="post" action="/V/Paid?'+o.v+'" target="pay"><input name="url" type="hidden" value="'+o.u+'"><input name="ref" type="hidden" value="'+o.r+'"></form>').submit();
        },
        error: function(o) {
            if (data.uid == 7515) alert(JSON.stringify(o))
        }
    });
    return false;
});

$(".start>button").on("click", function() {
    if (!data.uid) {
        $(".msg").show().find(">div").html("运行环境错误！");
        return
    }
    var obj = this;
    obj.disabled = true;
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "roulette",
            uid: data.uid,
            pwd: data.pwd
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                obj.disabled = false
            } else {
                setTimeout(function() {
                    obj.disabled = false;
                    $(".msg").show().find(">div").html(data.m);
                    if (data.r < 12) getWinners()
                }, 8000)
                $("#disc").animate({
                    rotate: data.r * 30 - 15 + 360 * 10
                }, 8000, function() {
                    $(this).rotate(data.r * 30 - 15 + "deg")
                });
            }
        }
    });
});

$("dt.task").on("click", function() {
    if ($("ul.task").html() && Date.now() - now.getTime() < 15000) return;
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "task",
            uid: data.uid,
            pwd: data.pwd,
            from: $("input[name=from]", this).val(),
            to: $("input[name=to]", this).val(),
            sta: $("input[name=status]", this).val() || -1
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.task").html("");
            $.each(data, function(i, e) {
                var t = e.t > e.r && e.u >= e.c * (e.r + 1);
                $(obj).append("<li><span class='slvzr-first-of-type'>" + e.n + "</span><span>" + e.c + "</span><span>" + e.s + "</span><span>" + (e.u || 0) + "</span><span>" + (e.r > 0 ? e.r + "次" : "未领取") + "</span><span style='cursor:pointer' onclick='" + (t ? "getReward(" + e.i + "," + e.c + ")" : "return") + "'>" + (t ? "领取" : "未达到") + "</span></li>");
            });
            now = new Date();
        }
    });
    return false;
});

$("dt.inquire").on("click", function() {
    if ($("ul.inquire").html() && Date.now() - now.getTime() < 15000) return;
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "withdraw",
            uid: data.uid,
            pwd: data.pwd,
            step: 0
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            var obj = $("ul.inquire").html("");
            $.each(data, function(i, e) {
                e.c = eval(("new " + e.c).replace(/\//g, ""));
                $(obj).append("<li><span class='slvzr-first-of-type'>" + getDate(e.c) + "</span><span>" + "银行转账" + "</span><span>" + e.o + "</span><span>" + e.b + "</span><span>" + e.a + "</span><span>" + ["其它", "银行"][e.t] + "</span><span>" + ["申请中", "已处理", "拒绝", "已提现"][e.s] + "</span></li>");
            });
            now = Date();
        }
    });
    return false;
});

$("dt.convert+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "withdraw",
            uid: data.uid,
            pwd: data.pwd,
            sum: $("input[name=sum]", this).val() || 0,
            way: $("input[name=way]", this).val() || "",
            acc: $("input[name=acc]", this).val() || "",
            rea: $("input[name=rea]", this).val() || "",
            bnk: $("input[name=bnk]", this).val() || "",
            usr: $("input[name=usr]", this).val() || "",
            loc: $("input[name=loc]", this).val() || "",
            pas: $("input[name=pwd]", this).val() || "",
            ips: $("input[name=ips]", this).val() || ""
        },
        success: function(data) {
            if (data.s) {
                if (data.s == 7) {
                    $(".modal").show();
                    return false;
                }
                $(".msg").show().find(">div").html(data.m);
                return false;
            }
            step = 3;
            toggle();
            $(".nav>.step2").hide();
            $(".modal").hide();
        }
    });
    return false;
});

$(".info>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "withdraw",
            uid: data.uid,
            pwd: data.pwd,
            qqnum: $("input[name=qqnum]", this).val() || "",
            email: $("input[name=email]", this).val() || "",
            phone: $("input[name=phone]", this).val() || ""
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                if (data.s == 7) $(".info").show();
                return false;
            }
            $(".info").hide();
        }
    });
    return false;
});

$("dt.statistics+dd>form").on("submit", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "spread",
            uid: data.uid,
            pwd: data.pwd,
            sum: $("input[name=sum]", this).val() || 0
        },
        success: function(data) {
            if (data.s) {
                $(".msg").show().find(">div").html(data.m);
                return false
            }
            $(".msg").show().find(">div").html(data.m);
        }
    });
    return false;
});

$('input[type=radio][name="date"]').on("change", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            req: "spread",
            uid: data.uid,
            pwd: data.pwd,
            int: ["today", "preday", "thisweek", "lastweek"].indexOf(this.value)
        },
        success: function(data) {
            var obj = $("table.statistics>tbody").get(0);
            $.each(data.s, function(i, e) {
                $(obj.rows[i.substring(5) - 1].cells[2]).html(e * 100 + "%")
            });
            var revs = 0,
                revTotals = 0;
            if (data.r.length > 0) $.each(data.r, function(i, e) {
                revs += e.rev;
                revTotals += e.revTotal;
                $(obj.rows[i].cells[1]).html(e.revTotal);
                $(obj.rows[i].cells[3]).html(e.rev)
            });
            $("ul.total>li").eq(0).html("<span>贡献小结：</span> " + revs).next().html("<span>获益小结：</span> " + revTotals).next().html("<span>总抽水：</span> " + data.a).next().html("<span>已提取：</span> " + data.g).next().html("<span>待提取：</span> " + (data.a - data.g));
        }
    });
    return false;
});

$(".copy").on("click", function() {
    var tmp = $("input.url").get(0);
    if (/iPad|iPhone|iPod/.test(navigator.platform)) {
        $(tmp).prop("readonly", false);
        $(".copy").off("click");
    }
    tmp.focus();
    tmp.setSelectionRange(0, tmp.value.length);
    if (document.execCommand("copy")) {
        $(".msg").show().find(">div").html("已经成功复制到剪帖板上！");
        return true;
    } else return false;
});

$(".card,.name").on("click", function() {
    var succeed = false;
    if (window.clipboardData)
        try {
            clipboardData.clearData();
            clipboardData.setData("Text", this.val());
            succeed = true;
        } catch (e) {}
    if (!succeed) {
        this.focus();
        this.setSelectionRange(0, this.value.length);
        try {
            succeed = document.execCommand("copy")
        } catch (e) {}
    }
    if (succeed) $(".msg").show().find(">div").html("已经成功复制到剪帖板上！");
});

$("dt.money").on("click", function() {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        url: url,
        type: "POST",
        crossDomain: true,
        dataType: "json",
        data: {
            act: "coupons",
            uid: data.uid,
            pwd: data.pwd
        },
        success: function(data) {
            if (data.s) {
                $(".moneymsg").show().find(">div").html("查询幸运币报错！");
            } else {
                $(".moneymsg").show().find(">div").html("您的幸运劵还剩下：" + data.u + "！");
            }
        }
    });
});


function CloseWindow() {
    $("<iframe/>").attr("src", "myapp://close").appendTo("body").remove();
}