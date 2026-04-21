----------------------------------------------------------------------------------------------------
-- 版权：2016
-- 时间：2016-01-26
-- 用途：安全中心
----------------------------------------------------------------------------------------------------

USE QPAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AccSeApPwdCard') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AccSeApPwdCard
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_AccSeBindEmail]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_AccSeBindEmail]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_AccSeBindPhone]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_AccSeBindPhone]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_AccSeIdCard]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_AccSeIdCard]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_AccSeSendEmailCode]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_AccSeSendEmailCode]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_AccSeSendSMSCode]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_AccSeSendSMSCode]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_AddAccountProtect]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_AddAccountProtect]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------
-- 账号安全   验证身份证号码
CREATE PROCEDURE [dbo].[NET_PW_AccSeApPwdCard]
	-- 验证信息
	@dwUserID INT,								-- 用户 I D
	-- 密保卡序列号
	@dwserialNumber INT,			   -- 密保卡序列号
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	SELECT @UserID=UserID, @Nullity=Nullity, @StunDown=StunDown FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 1
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END		

	-- 更新密保卡序列
	UPDATE AccountsInfo SET PasswordID=@dwserialNumber WHERE UserID=@dwUserID

	--更新资料
	DECLARE @BindingType INT
	SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType IS NULL
	BEGIN
	   INSERT IndividualDatum (UserID, QQ, EMail, SeatPhone, MobilePhone,BindingType, DwellingPlace, UserNote,BINDINGMOBILE)
	   VALUES (@dwUserID, '', '', '', '',0, '', '',0)
    End
    SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType&32>0
	BEGIN
		 SET @strErrorDescribe ='您已绑定密保卡!';
		 RETURN 3
	END
	ELSE
	BEGIN
		UPDATE IndividualDatum SET BindingType=@BindingType+32 WHERE UserID=@dwUserID
	END
	-- 设置信息	
	SET @strErrorDescribe= N'恭喜您，密保卡绑定成功！'
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
-- 绑定邮箱
CREATE PROC [dbo].[NET_PW_AccSeBindEmail]
	@dwUserID INT,					-- 用户ID
	@strEmail nvarchar(64),     --邮箱
	@Code nvarchar(8),     --验证码
	@EmailType INT, --绑定邮箱0   修改绑定邮箱1
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 执行逻辑
BEGIN
   --验证码置为已用
   UPDATE RecordEmailCode SET  HasUsed =1 ,UseDate = GETDATE() WHERE UserID = @dwUserID and EmailCode = @Code

	--更新资料
	DECLARE @BindingType INT
	SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType IS NULL
	BEGIN
	   INSERT IndividualDatum (UserID, QQ, EMail, SeatPhone, MobilePhone,BindingType, DwellingPlace, UserNote,BINDINGMOBILE)
	   VALUES (@dwUserID, '', '', @strEmail, '',0, '', '',0)
	   UPDATE RecordEMailCode SET HasUsed =1 , UseDate = GETDATE()  WHERE userid = @dwUserID
    End
    SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType&2>0
	BEGIN
		 SET @strErrorDescribe ='您已绑定邮箱!';
		 RETURN 1
	END
	ELSE
	BEGIN
		IF @EmailType=0
			UPDATE IndividualDatum SET BindingType=@BindingType+2,EMail = @strEmail WHERE UserID=@dwUserID
		ELSE
			UPDATE IndividualDatum SET EMail = @strEmail WHERE UserID=@dwUserID
	END
   --INSERT INTO QPAccountsDB.dbo.BindSMSCodelog VALUES (@dwUserID,getdate(),@MobilePhone)  --插入绑定手机日志表
   SET	@strErrorDescribe ='绑定邮箱成功!';
   RETURN 0

End   
   
GO

----------------------------------------------------------------------------------------------------
-- 绑定手机
CREATE PROC [dbo].[NET_PW_AccSeBindPhone]
	@dwUserID INT,					-- 用户ID
	@MobilePhone nvarchar(16),     --手机号码
	@Code nvarchar(8),     --验证码
	@PhoneType INT,		--绑定手机0   修改绑定手机1
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 执行逻辑
BEGIN
   --验证码置为已用
   UPDATE RecordPhoneCode SET  HasUsed =1 ,UseDate = GETDATE() WHERE UserID = @dwUserID and PhoneCode = @Code

	--更新资料
	DECLARE @BindingType INT
	SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType IS NULL
	BEGIN
	   INSERT IndividualDatum (UserID, QQ, EMail, SeatPhone, MobilePhone,BindingType, DwellingPlace, UserNote,BINDINGMOBILE)
	   VALUES (@dwUserID, '', '', '', @MobilePhone,0, '', '',0)
	   UPDATE RecordPhoneCode SET  HasUsed =1 , UseDate = GETDATE()  WHERE userid = @dwUserID
    End
    SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType&4>0
	BEGIN
		 SET @strErrorDescribe ='您已绑定手机!';
		 RETURN 1
	END
	ELSE
	BEGIN
		IF(@PhoneType=0)
			UPDATE IndividualDatum SET BindingType=@BindingType+4,MobilePhone = @MobilePhone,bindingmobile =1 WHERE UserID=@dwUserID
		ELSE
			UPDATE IndividualDatum SET MobilePhone = @MobilePhone,bindingmobile =1 WHERE UserID=@dwUserID
    END
   --INSERT INTO QPAccountsDB.dbo.BindSMSCodelog VALUES (@dwUserID,getdate(),@MobilePhone)  --插入绑定手机日志表
   SET	@strErrorDescribe ='绑定手机成功!';
   RETURN 0

End

GO

----------------------------------------------------------------------------------------------------
-- 账号安全   验证身份证号码
CREATE PROCEDURE [dbo].[NET_PW_AccSeIdCard]
	-- 验证信息
	@dwUserID INT,								-- 用户 I D
	-- 用户资料
	@strTrueName NVARCHAR(32),					--真实姓名
	@strIDCard NVARCHAR(32),					-- 身份证号码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询用户
	DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	SELECT @UserID=UserID, @Nullity=Nullity, @StunDown=StunDown FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 1
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END		

	-- 更新身份证
	UPDATE AccountsInfo SET PassPortID=@strIDCard,Compellation=@strTrueName WHERE UserID=@dwUserID

	--更新资料
	DECLARE @BindingType INT
	SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType IS NULL
	BEGIN
	   INSERT IndividualDatum (UserID, QQ, EMail, SeatPhone, MobilePhone,BindingType, DwellingPlace, UserNote,BINDINGMOBILE)
	   VALUES (@dwUserID, '', '', '', '',0, '', '',0)
    End
    SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
	IF @BindingType&1>0
	BEGIN
		 SET @strErrorDescribe ='您已成功验证身份!';
		 RETURN 1
	END
	ELSE
	BEGIN
		UPDATE IndividualDatum SET BindingType=@BindingType+1 WHERE UserID=@dwUserID
	END

	-- 设置信息	
	SET @strErrorDescribe= N'恭喜您，身份认证成功！'
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 生成邮箱验证码
CREATE PROC [dbo].[NET_PW_AccSeSendEmailCode]
	@dwUserID INT,					-- 用户ID
	@strEmail nvarchar(64),     --邮箱
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 绑定信息
DECLARE @SMSCodeID INT
DECLARE @SMSCodeCount INT
DECLARE @SMSCode INT
DECLARE @Email NVARCHAR(32)
DECLARE @BindingType INT
DECLARE @TextDesc NVARCHAR(60)

-- 执行逻辑
BEGIN
	SELECT @Email=EMail,@BindingType=BindingType FROM IndividualDatum WHERE EMail=@strEmail
	IF @Email<>'' and @BindingType&8>0
	BEGIN
		SET @strErrorDescribe=N'此邮箱已被绑定，请检查您的邮箱地址或联系客服人员'
		RETURN 2
	END

	-- 查询有效的验证码个数
	SET @SMSCodeCount=0
	SELECT @SMSCodeCount=COUNT(*) FROM RecordEmailCode(NOLOCK) WHERE UserID=@dwUserID AND DATEDIFF(hh,GenerateDate,GetDate())<=24 AND HasUsed=0 AND AssociateMobileEmail=@strEmail
	--IF @SMSCodeCount<3   -- 24小时内不能超过3个
	--BEGIN
		IF @SMSCodeCount>0
		BEGIN
			-- 1分钟之内不在产生新的
			SELECT @SMSCodeCount=COUNT(*) FROM RecordEmailCode(NOLOCK) WHERE UserID=@dwUserID AND DATEDIFF(n,GenerateDate,GetDate()) < 1 AND HasUsed=0
			IF @SMSCodeCount>0
			BEGIN
				SET @strErrorDescribe=N'您绑定的邮箱在1分钟内存在未使用的验证码，稍后再试！'
				RETURN 3
            END
		END
		-- 产生新的手机验证码
		SET @SMSCode = 100000 + cast(ceiling(rand()*899999) as INT)
		INSERT INTO RecordEmailCode(UserID,EmailCode,AssociateMobileEmail,GenerateDate,HasUsed,UseDate)
		VALUES(@dwUserID,@SMSCode,@strEmail,GetDate(),0,GetDate())
		SET @SMSCodeID=SCOPE_IDENTITY()
		SET @TextDesc = N'验证码：' + CAST(@SMSCode as varchar(6))
		
		 SELECT @SMSCodeID AS SMSCodeID, @strEmail AS Email, @TextDesc AS TextDesc	
	--END
	--ELSE
	--BEGIN
	--	SET @strErrorDescribe=N'您绑定的邮箱在今天已经有三条未使用验证码，不能重新生成！'
	--	RETURN 4
	--END
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
-- 生成手机验证码
CREATE PROC [dbo].[NET_PW_AccSeSendSMSCode]
	@dwUserID INT,					-- 用户ID
	@MobilePhone nvarchar(16),     --手机号码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 绑定信息
DECLARE @SMSCodeID INT
DECLARE @SMSCodeCount INT
DECLARE @SMSCode INT
DECLARE @BindingMobile INT
DECLARE @IsMobilePhone NVARCHAR(16) 
DECLARE @TextDesc NVARCHAR(60)
DECLARE @LastInsertTime DATETIME

-- 执行逻辑
BEGIN
--	SELECT @BindingMobile=BindingMobile FROM IndividualDatum WHERE MobilePhone=@MobilePhone
--	IF @BindingMobile>0
--	BEGIN
--		SET @strErrorDescribe=N'此手机号已被绑定，请检查您的手机号码或联系客服人员'
--		RETURN 2
--	END

	-- 查询有效的验证码个数
	SET @SMSCodeCount=0
	SELECT @SMSCodeCount=COUNT(*) FROM RecordPhoneCode(NOLOCK) WHERE UserID=@dwUserID AND DATEDIFF(hh,GenerateDate,GetDate())<=24 AND HasUsed=0 AND AssociateMobilePhone=@MobilePhone
	IF @SMSCodeCount<3   -- 24小时内不能超过3个
	BEGIN
		IF @SMSCodeCount>0
		BEGIN
			-- 1分钟之内不在产生新的
			SELECT @SMSCodeCount=COUNT(*) FROM RecordPhoneCode(NOLOCK) WHERE UserID=@dwUserID AND DATEDIFF(n,GenerateDate,GetDate()) < 1 AND HasUsed=0
			IF @SMSCodeCount>0
			BEGIN
				SET @strErrorDescribe=N'您绑定的手机号在五分钟内存在未使用的验证码，稍后再试！'
				RETURN 3
            END
		END
		-- 产生新的手机验证码
		SET @SMSCode = 100000 + cast(ceiling(rand()*899999) as INT)
		INSERT INTO RecordPhoneCode(UserID,PhoneCode,AssociateMobilePhone,GenerateDate,HasUsed,UseDate)VALUES(@dwUserID,@SMSCode,@MobilePhone,GetDate(),0,GetDate())
		SET @SMSCodeID=SCOPE_IDENTITY()
		SET @TextDesc = N'手机验证码：' + CAST(@SMSCode as varchar(6))
		
		 SELECT @SMSCodeID AS SMSCodeID, @MobilePhone AS MobilePhone, @TextDesc AS TextDesc	
	END
    ELSE
    BEGIN
		SET @strErrorDescribe=N'您绑定的手机号在今天已经有三条未使用验证码，不能重新生成！'
		RETURN 4
    END
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
-- 申请密码保护
CREATE PROCEDURE [dbo].[NET_PW_AddAccountProtect]
	@dwUserID INT,								-- 用户 I D

	@strQuestion1 NVARCHAR(32),					-- 问题一
	@strResponse1 NVARCHAR(32),					-- 答案一
	@strQuestion2 NVARCHAR(32),					-- 问题二
	@strResponse2 NVARCHAR(32),					-- 答案二
	@strQuestion3 NVARCHAR(32),					-- 问题三
	@strResponse3 NVARCHAR(32),					-- 答案三

	@strPassportID NVARCHAR(32),				-- 证件号码
	@dwPassportType TINYINT,					-- 证件类型
	@strSafeEmail NVARCHAR(32),					-- 邮箱号码

	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 查询用户
	DECLARE @UserID INT
	DECLARE @StunDown BIT
	DECLARE @Nullity BIT
	DECLARE @ProtectID INT
	DECLARE @LogonPass NCHAR(32)
	SELECT @UserID=UserID, @ProtectID=ProtectID, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL 
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 3
	END	

	-- 密保效验
	IF @ProtectID<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号已经申请了“帐号保护”功能，无法再次申请“帐号保护”！'
		RETURN 4
	END

	-- 密码保护
	INSERT INTO AccountsProtect(UserID,Question1,Response1,Question2,Response2,Question3,Response3,
		PassportID,PassportType,SafeEmail,CreateIP,ModifyIP)
	VALUES(@UserID,@strQuestion1,@strResponse1,@strQuestion2,@strResponse2,@strQuestion3,@strResponse3,
		@strPassportID,@dwPassportType,@strSafeEmail,@strClientIP,@strClientIP)

	-- 设置用户
	IF @@ERROR=0 
	BEGIN
		UPDATE AccountsInfo SET ProtectID=@@IDENTITY WHERE UserID = @dwUserID
		SET @strErrorDescribe=N'恭喜您，“帐号保护”功能申请成功了，请紧记您的“帐号保护”内容！'
		--更新资料
		DECLARE @BindingType INT
		SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
		IF @BindingType IS NULL
		BEGIN
		   INSERT IndividualDatum (UserID, QQ, EMail, SeatPhone, MobilePhone,BindingType, DwellingPlace, UserNote,BINDINGMOBILE)
		   VALUES (@dwUserID, '', '', '', '',0, '', '',0)
		End
		SELECT @BindingType=BindingType FROM IndividualDatum WHERE UserID=@dwUserID --获取当前用户绑定类型
		IF @BindingType&16>0
		BEGIN
			 SET @strErrorDescribe ='您的密保卡已申请成功!';
			 RETURN 5
		END
		ELSE
		BEGIN
			UPDATE IndividualDatum SET BindingType=@BindingType+16 WHERE UserID=@dwUserID
			RETURN 0
		END
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'“帐号保护”功能申请失败了，请联系客户服务中心了解详细情况！'
		RETURN 5
	END
END

SET NOCOUNT OFF
RETURN 0

GO

----------------------------------------------------------------------------------------------------