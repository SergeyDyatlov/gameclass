USE GameClass
GO

/* -----------------------------------------------------------------------------
				��������� ���� � ���������� � ������
----------------------------------------------------------------------------- */

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'forcedvolume' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [forcedvolume]  [int] NOT NULL DEFAULT (-1)
GO

/* -----------------------------------------------------------------------------
				��������� ��������� ���������� ������
----------------------------------------------------------------------------- */


USE [GameClass]
GO
/****** ������:  StoredProcedure [dbo].[TarifsUpdate]    ���� ��������: 02/04/2013 09:43:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[TarifsUpdate] 
@idTarif int, 
@name nvarchar(100), 
@internet int, 
@calctraffic int, 
@roundtime int, 
@roundmoney money, 
@idGroup int, 
@BytesInMB int, 
@SpeedLimitInKB int, 
@PluginGroupName nvarchar(50), 
@userlevel int, 
@operatorlevel int, 
@useseparatesumm int, 
@startmoneymin int, 
@startmoneymax int, 
@addmoneymin int, 
@addmoneymax int, 
@maximumtrust int,
@forcedvolume int
AS  
set nocount on 
if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0)) 
begin 
raiserror 50000 'Tarif with these name already exist!' 
return 50000 
end 
update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime , 
	[roundmoney]=@roundmoney, [idGroup]=@idGroup, [BytesInMB]=@BytesInMB, 
	[SpeedLimitInKB]=@SpeedLimitInKB, [PluginGroupName]=@PluginGroupName, [userlevel]=@userlevel, 
	[operatorlevel]=@operatorlevel, 
	[useseparatesumm]=@useseparatesumm, 
	[startmoneymin]=@startmoneymin, 
	[startmoneymax]=@startmoneymax, 
	[addmoneymin]=@addmoneymin, 
	[addmoneymax]=@addmoneymax, 
	[maximumtrust]=@maximumtrust,
	[forcedvolume]=@forcedvolume 
where [id]=@idTarif 
GO


/* ---------------------------------------------------------------------------------------------------------------------------------------
                               ������� ��������� ��� ������ � �������� ���������� ������������� ����
------------------------------------------------------------------------------------------------------------------------------------------ */


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsGetLastUsed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsGetLastUsed]
GO

CREATE PROCEDURE [dbo].[AccountsGetLastUsed] 
@id INT = NULL 
AS  
BEGIN 
	SELECT TOP 1 AccountsHistory.moment FROM AccountsHistory  
		WHERE (idAccounts = @id) AND (what >= 2)
		ORDER BY [moment] DESC 
END 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsGetLastUsed]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsHistoryInsert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsHistoryInsert]
GO


CREATE PROCEDURE [dbo].[AccountsHistoryInsert] 
@idAccount INT = NULL,
@moment datetime,
@what	INT,
@summa money,
@comment nvarchar(200)=''
 
AS  
BEGIN 
	declare @idMe int 
	select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

	INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])   
		VALUES  (@idAccount, @moment, @what, @summa, @comment,@idMe) 
END 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsHistoryinsert]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/* -----------------------------------------------------------------------------
				��������� ���� � "��������" ����� ����������� � ����
----------------------------------------------------------------------------- */

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'hardcode' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [hardcode]  [nvarchar](50) NOT NULL DEFAULT (N'')
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'ignorehardcode' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [ignorehardcode]  [int] NOT NULL DEFAULT (1)
GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsGetIdByHardCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsGetIdByHardCode]
GO


CREATE PROCEDURE [dbo].[AccountsGetIdByHardCode]  
@hardcode nvarchar(200)='' 
AS   
BEGIN  
	SELECT TOP 1 Accounts.id FROM Accounts
		WHERE (hardcode = @hardcode) 
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsGetIdByHardCode]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsUpdate]
GO

CREATE PROCEDURE [dbo].[AccountsUpdate] 
@id int, 
@name nvarchar(50), 
@password nvarchar(50), 
@email nvarchar(80), 
@phone nvarchar(50), 
@isenabled int, 
@isblocked int, 
@isprivileged int,  
@privilegedDiscount int,  
@zeroBalance money, 
@memotext nvarchar(2000) = N'', 
@address nvarchar(300)=N'', 
@summary money, 
@PeriodOfValidity int = 0, 
@ExpirationDate datetime, 
@assigntarif int, 
@userlevel int, 
@force_tariff int, 
@referal int, 
@username nvarchar(50), 
@uname nvarchar(50), 
@uotch nvarchar(50),
@hardcode nvarchar(50),
@ignorehardcode int
AS  
IF (EXISTS (SELECT * FROM Accounts WHERE ([name]=@name) AND (@name <> N'') AND ([id]<>@id) AND ([isdeleted]=0))) BEGIN 
RAISERROR 50001 'Account already exists! Choose other name...' 
RETURN 50001 
END 
IF (EXISTS (SELECT * FROM Accounts WHERE [id] = @id AND [isdeleted] = 0)) BEGIN 
UPDATE Accounts SET 
[name] = @name, 
[password] = @password, 
[email] = @email, 
[phone] = @phone, 
[isenabled] = @isenabled, 
[isblocked] = @isblocked, 
[isprivileged] = @isprivileged,  
[privilegedDiscount] = @privilegedDiscount,  
[zeroBalance] = @zeroBalance, 
[memo] = @memotext, 
[address] = @address, 
[summary] = @summary, 
[PeriodOfValidity] = @PeriodOfValidity, 
[ExpirationDate] = @ExpirationDate, 
[assigntarif] = @assigntarif, 
[userlevel] = @userlevel, 
[force_tariff] = @force_tariff, 
[referal] = @referal, 
[username] = @username, 
[uname] = @uname, 
[uotch] = @uotch, 
[hardcode] = @hardcode,
[ignorehardcode] = @ignorehardcode
WHERE [id] = @id 
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsUpdate]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/* -----------------------------------------------------------------------------
				��������� ������
----------------------------------------------------------------------------- */


ALTER TRIGGER [dbo].[AccountsAutoUPDATE] ON [dbo].[Accounts]  
FOR INSERT, UPDATE, DELETE  
AS 
BEGIN 
DECLARE @idI INT 
DECLARE @idD INT 
DECLARE @idAction INT 
DECLARE @idRecord INT 
DECLARE @isdeleted INT 
DECLARE @flag INT 
DECLARE @idActionOld INT 
DECLARE @idTableOld INT 
DECLARE @idRecordOld INT 
DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD],  
I.isdeleted FROM INSERTED AS I 
FULL OUTER JOIN DELETED AS D ON I.id = D.id 
OPEN IDcursor 
FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted 
WHILE @@FETCH_STATUS = 0 
BEGIN 
IF NOT(@idI IS NULL) AND (@idD IS NULL)  
SET @idAction = 1 --Insert 
IF (@idI IS NULL) AND NOT(@idD IS NULL)  
SET @idAction = 2 --Delete 
IF NOT(@idI IS NULL) AND NOT(@idD IS NULL)  
BEGIN  
IF @isdeleted = 0 
SET @idAction = 3 --Update 
ELSE 
SET @idAction = 2 --Delete 
END 
SET @idRecord = ISNULL(@idI,@idD) 
IF @idAction = 2 
BEGIN 
SELECT @flag=count([id]) FROM [GameClass].[dbo].[AutoUpdate] WHERE  
(idTable=1) AND (idAction=2) AND (idRecord=@idRecord) 
IF @flag >0 
BEGIN
	DELETE FROM [GameClass].[dbo].[AutoUpdate] WHERE (idTable=1) AND (idAction=2) AND (idRecord=@idRecord) 
	INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord) 
END
ELSE 
INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord) 
END 
IF @idAction <> 2 
INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord) 
FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted 
END 
CLOSE IDcursor 
DEALLOCATE IDcursor 
END 
GO

/* ----------------------------------------------------------------------------- 
����� ������� �����  
----------------------------------------------------------------------------- */ 
ALTER PROCEDURE [dbo].[ReportCurrent] 
@NewShiftPoint datetime, 
@LastShiftPoint datetime OUTPUT, 
@Time money OUTPUT, 
@Serices money OUTPUT, 
@Print money OUTPUT, 
@Internet money OUTPUT, 
@AccountsAdded money OUTPUT, 
@AccountsPayed money OUTPUT, 
@AccountsReturned money OUTPUT, 
@Rest money OUTPUT 
AS  
set nocount on 
-- ��� ����� �������� ������ ���������� ���������� ����� 
if exists (select * from JournalOp)   
select top 1 @LastShiftPoint=[moment] from JournalOp where [moment]<=@NewShiftPoint order by [moment] desc 
else 
select top 1 @LastShiftPoint=SA.[start] from SessionsAdd as SA order by SA.[start] 
if (@LastShiftPoint is NULL)  
begin 
select top 1 @LastShiftPoint = S.[moment] from Services as S order by [moment] desc 
end 
set @LastShiftPoint=ISNULL(@LastShiftPoint,@NewShiftPoint) 
-- ������� ���� ���������� ������ ��������� (����������� ���������)  
-- ������� ���.�������� (�����) 
select @Serices = ISNULL(sum(RS.[summa]),0) from repServices as RS 
where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint) and (TypeCost = 1) 
-- ������� ������� � ������������� ������� 
select @Internet =  ISNULL(Sum(SA.TrafficCost),0), @Print =  ISNULL(Sum(S.[PrintCost]),0) from sessions as S 
inner join SessionsAdd as SA on (SA.[idSessions] = S.[id]) 
where (S.[postpay]=0) 
and (@LastShiftPoint<=SA.[start]) and (SA.[start]<=@NewShiftPoint) and (S.[idClients]=0) 
-- ������� ����� ��� ��������� 
-- ��������� 
select @AccountsAdded= ISNULL(Sum(AH.summa),0) from AccountsHistory as AH 
inner join users on (users.id=AH.operator) 
inner join usersgroup on (usersgroup.id=users.idUsersGroup) 
where (AH.What=0)   
and usersgroup.name='Staff' 
and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint) 
AND (users.name <> 'gcsync')
-- ���������� 
select @AccountsReturned =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH 
inner join users on (users.id=AH.operator) 
inner join usersgroup on (usersgroup.id=users.idUsersGroup) 
where (AH.[What]=1) 
and usersgroup.name='Staff' 
and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
AND (users.name <> 'gcsync')
-- ���������� 
select @AccountsPayed =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH 
where (AH.[What]=2) 
and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint) 
select @Time = ISNULL(sum(SA2.[summa]),0) - @Internet from sessions as S 
inner join SessionsAdd as SA on (SA.[idSessions] = S.[id]) 
inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd]) 
where (S.[postpay]=0) 
and (@LastShiftPoint<=SA2.[moment]) and (SA2.[moment]<=@NewShiftPoint) 
and S.[idClients]=0 
SELECT @Rest= SUM(Rest) FROM  
(SELECT S.[id], S.[CommonPay] + S.[SeparateTrafficPay] - S.[PrintCost] - S.[ServiceCost] 
- SUM(SA.[TimeCost]) - SUM(SA.[TrafficCost]) - SUM(SA.[SeparateTrafficCost]) Rest, S.[status] 
FROM Sessions AS S 
INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions]) 
WHERE S.PostPay = 0 
GROUP BY S.id, S.status, S.CommonPay, S.SeparateTrafficPay, S.PrintCost, S.ServiceCost) SS 
INNER JOIN SessionsAdd AS SA ON (SS.[id] = SA.[idSessions]) 
WHERE ((SA.[start] <= @NewShiftPoint) OR (SS.[status]=0)) AND (@NewShiftPoint < SA.[stop]) 
SET @Rest = ISNULL(@Rest, 0.0) 
GO

/* -----------------------------------------------------------------------------
                               ��������� ������� ��� snmp
----------------------------------------------------------------------------- */

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'on_val' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [on_val] [int] NOT NULL DEFAULT (1)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'off_val' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [off_val] [int] NOT NULL DEFAULT (0)
GO

/* -----------------------------------------------------------------------------
                               ������ ComputersUpdate
----------------------------------------------------------------------------- */


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[ComputersUpdate] 
	@idComp int, 
	@number int,
	@client_type int,
	@idGroup int, 
	@ipaddress nvarchar(15), 
	@macaddress nvarchar(17),
	@snmp_password nvarchar(49),
	@mib_port nvarchar(49),
	@ignore_offline int,
	@on_val int,
	@off_val int
AS  
set nocount on 
if (exists(select * from Computers where ([number]=@number) and [id]<>@idComp and [isdelete]=0)) 
begin 
	raiserror 50000 'Computers with these number or ip-addres already exist!' 
	return 50000 
end 
else 
	update Computers set 
	[number]=@number, 
	[client_type]=@client_type, 
	[idGroup]=@idGroup, 
	[ipaddress]=@ipaddress, 
	[macaddress]=@macaddress,
	[snmp_password]=@snmp_password ,
	[snmp_mib_ports]=@mib_port,
	[ignore_offline]=@ignore_offline,
	[on_val]=@on_val,
	[off_val]=@off_val
	
		where [id]=@idComp 
GO


/* -----------------------------------------------------------------------------
                               UPDATE Version
---------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.7' WHERE [key]='BaseVersion'
GO


