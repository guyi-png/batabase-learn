#变量
/*
系统变量: 
	 全局变量
	 会话变量
自定义变量:
	 用户变量
	 局部变量
*/
#一.系统变量
#由系统提供,属于服务器层面
/*

全局变量的作用域: 服务器每次启动将为所有的全局变量赋此时值,
针对于所有的会话(连接)有效,但不能跨重启

会话变量的作用域: 仅仅针对于当前会话(连接)有效

*/
#1.查看所有的系统变量
SHOW VARIABLES;	#会话变量,省略session
SHOW SESSION VARIABLES;#会话变量
SHOW GLOBAL VARIABLES; #全局变量

#2.查看满足条件的部分系统变量
SHOW VARIABLES LIKE '%char%';

#3.查看指定的某个系统变量的值
SELECT @@global.系统变量名; #全局系统变量
SELECT @@session.系统变量名;#会话系统变量

#4.为某个系统变量赋值
SET GLOBAL 系统变量名 = 值;
SET @@global.系统变量名 = 值;
SET 系统变量名 = 值;
SET @@系统变量名 = 值;

#二. 自定义变量
/*
使用步骤:
声明,
赋值,
使用(查看,比较,运算符)
*/
#1.用户变量
/*
作用域: 针对于当前会话(连接)有效
*/
#①声明并初始化, 赋值
SET @自定义变量名 = 值;
SET @自定义变量名 := 值;
SELECT @自定义变量名 := 值;
#②赋值
SELECT 字段 INTO 变量名 FROM 表;
#③使用,查看
SELECT @自定义变量名;

#2.局部变量
/*
作用域: 仅仅在定义它的begin end中有效
声明应用在begin end 的第一句话
*/
#①声明 declare
DECLARE 变量名 类型;
DECLARE 变量名 类型 DEFAULT 值;
#②赋值
SET 局部变量名 = 值;
SET 局部变量名 := 值;
SELECT @局部变量名 := 值;
SELECT 字段 INTO 变量名 FROM 表;
#③使用,查看
SELECT 局部变量名;

#声明两个变量并赋予初始值, 求和,查看
#用户变量
SET @value1 = 22;
SET @value2 = 33;
SET @result = @value1 + @value2;
SELECT @result;
