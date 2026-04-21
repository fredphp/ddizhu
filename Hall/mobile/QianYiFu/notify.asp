<!--#include file="conn.asp"-->
<%

returncode = request.QueryString("returncode") '返回代码,1代表收购成功,11代表收购失败
orderid = (request.QueryString("orderid")) '商户流水号
money=request.QueryString("money") '产品提交金额
sign=request.QueryString("sign") '签名数据 32位小写的组合加密验证串
ext=request.QueryString("ext") '商户扩展信息，返回时原样返回，此参数如用到中文，请注意转码
'卡类独特返回
cardNo = request.QueryString("cardNo")
cardPwd = request.QueryString("cardPwd")
typeid = request.QueryString("typeid")
cardstatus=request.QueryString("cardstatus")

if QY_DEBUG then
	'网银加密
	sign_bank="returncode="&returncode&"&userid="&uid_test&"&orderid="&orderid&"&money="&money&"&keyvalue="&key_test&""
	md5_sign_bank = ASP_MD5(sign_bank)
	'点卡加密
	sign_card="returncode="&returncode&"&userid="&uid_test&"&orderid="&orderid&"&cardstatus="&cardstatus&"&cardNo="&cardNo&"&cardPwd="&cardPwd&"&typeid="&typeid&"&money="&money&"&keyvalue="&key_test&""
	md5_sign_card = ASP_MD5(sign_card)
else 
	'网银加密
	sign_bank="returncode="&returncode&"&userid="&uid&"&orderid="&orderid&"&money="&money&"&keyvalue="&key&""
	md5_sign_bank = ASP_MD5(sign_bank)
	'点卡加密
	sign_card="returncode="&returncode&"&userid="&uid&"&orderid="&orderid&"&cardstatus="&cardstatus&"&cardNo="&cardNo&"&cardPwd="&cardPwd&"&typeid="&typeid&"&money="&money&"&keyvalue="&key&""
	md5_sign_card = ASP_MD5(sign_card)
end if

If md5_sign_bank=sign or md5_sign_card=sign Then
	if int(returncode)=1  then
		'商户业务数据成功处理	
		checkOrder orderid,money,ext
	else
		'商户业务数据失败处理
		response.write("商户业务数据失败处理")
	end if
else
	response.write("交易信息被篡改")
end if 	
%>