#存储过程和函数
/*
存储过程和函数, 类似Java中的方法

存储过程:
	含义: 一组预先编译好的sql语句的集合,可理解成批处理语句
	优点: 1.提高代码的重用性   2.简化操作   3.减少了编译次数和数据库的连接次数 
*/

#一. 创建存储过程语法
CREATE PROCEDURE 存储过程名(参数列表)
BEGIN
	存储过程体(一组sql语句)
END 结束标记;
/*
1.参数列表包含三部分: 参数模式	参数名	参数类型
如   in argname int
参数模式: in:表明参数作为输入,要求调用方提供传入值
	  out:表明参数作为输出,该参数可以作为返回值
	  inout: 可进可出
存储过程体的每个语句结束都要加;
存储过程体的结尾用delimiter(分隔符)设置结尾标记
语法:  delimiter 结束标记 如 delimiter xx
*/

#二. 调用语法
CALL 存储过程名(参数列表);

#1.空参列表
#从插入到表中五条记录
TRUNCATE TABLE admin;
CREATE TABLE admin(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20) DEFAULT 'administer',
	`password` INT(10) NOT NULL
);
INSERT INTO admin
VALUES(NULL, NULL, 123456), (NULL, 'olg', 888888);

SELECT * FROM admin;

#创建存储过程
DELIMITER xx  #设置结尾标记
CREATE PROCEDURE my_func()
BEGIN 
	INSERT INTO admin(`password`) VALUES(018945);
	INSERT INTO admin(username, `password`) VALUES('mike', 4444);
	INSERT INTO admin(username, `password`) VALUES('mikd', 44444);
	INSERT INTO admin(username, `password`) VALUES('mikg', 444444);
	INSERT INTO admin(username, `password`) VALUES('sike', 4444444);
END xx
#调用
DELIMITER xx  #设置结尾标记
CALL my_func()xx

#2.in模式一个参数
DELIMITER $
CREATE PROCEDURE my_func1(IN beautyname VARCHAR(20))
BEGIN
	SELECT bo.* 
	FROM boy bo 
	RIGHT OUTER JOIN beauty be
	ON bo.id = be.boyfriend_id
	WHERE be.name = beautyname;
END $
CALL mu_func1('xx')$
#

#3.in模式两参数
DELIMITER $
CREATE PROCEDURE my_account(IN username VARCHAR(20), IN `password` INT(10))
BEGIN 
	DECLARE result INT DEFAULT 0; #定义局部变量
	
	SELECT COUNT(*) INTO result
	FROM admin
	WHERE admin.username = username AND admin.`password` = `password`;
	
	SELECT IF(result, 'yes', 'no');
END $
CALL my_account('olg', 123456)$

#4.in参数 + out参数
DELIMITER $
CREATE PROCEDURE my_func2(IN beautyname VARCHAR(20), OUT boyname VARCHAR(20))
BEGIN
	SELECT bo.boyname INTO boyname
	FROM boy bo
	INNER JOIN beauty be
	ON bo.id = be.boyfriend_id
	WHERE be.name = beautyname;
END $
SET @bname $
CALL my_func2('xx', @bname)$

#5.in参数 + out参数 + out参数
DELIMITER ^
CREATE PROCEDURE my_func2(IN beautyname VARCHAR(20), OUT boyname VARCHAR(20), OUT boycp INT)
BEGIN
	SELECT bo.boyname, bo.boycp INTO boyname, boycp
	FROM boy bo
	INNER JOIN beauty be
	ON bo.id = be.boyfriend_id
	WHERE be.name = beautyname;
END ^
SET @bname ^
CALL my_func2('xx', @bname, @bcp)^

#6.inout模式的参数
DELIMITER $
CREATE PROCEDURE multiplier(INOUT a INT, INOUT b INT)
BEGIN
	SET a = a * a;
	SET b = b * b;
END $
SET @a = 2$
SET @b = 3$
CALL multiplier(@a, @b)$
SELECT @a, @b$


#三. 删除存储过程
DROP PROCEDURE 存储过程名

DROP PROCEDURE my_func;
DROP PROCEDURE my_func1, my_func2; #error  

#四. 查看存储过程的信息
DESC my_func; #no
SHOW CREATE PROCEDURE my_func;



#函数
/*
含义: 一组预先编译好的sql语句的集合,可理解成批处理语句
	优点: 1.提高代码的重用性   2.简化操作   3.减少了编译次数和数据库的连接次数 
存储过程与函数区别：
	存储过程：可以有0或多个返回
	函数： 只能是有一个返回	
	
*/
#一.函数创建
/*
语法：
create function 函数名(参数列表) returns 返回类型
begin 
	函数体
end

参数列表： 参数名 参数类型

函数体必须有return语句
*/

#二. 调用
SELECT 函数名(参数列表);

#1.空参列表
DELIMITER ^
CREATE FUNCTION my_func() RETURNS INT
BEGIN 
	DECLARE c INT DEFAULT 0; #定义局部变量
	SELECT COUNT(*) INTO c
	FROM tab_identity;
	
	RETURN c; #返回结果
END ^

SELECT my_func()^	#调用函数

SELECT * FROM tab_identity;

#2.仅一个参数
DELIMITER &
CREATE FUNCTION my_func1(`name` VARCHAR(20)) RETURNS INT
BEGIN
	DECLARE r INT;  #声明局部变量
	
	SELECT id INTO r   #注意可能select的结果有多个
	FROM tab_identity t
	WHERE t.name = `name`;
	
	RETURN r;
END &

SELECT my_func1('olg');

#三. 查看函数
SHOW CREATE FUNCTION my_func;

#四. 删除函数
DROP FUNCTION my_func;

