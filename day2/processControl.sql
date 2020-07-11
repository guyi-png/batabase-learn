#流程控制结果
/*
 顺序结构： 程序从上到下依次执行
 分支结构： 程序从两条或多条路径中选择一条执行
 循环结构： 程序在满足条件的情况下重复执行一段代码
*/

#一。分支结构
#1.if (函数)
#2.case	   参考day1\commonFunction.sql文件 

#在begin end 中使用case
DELIMITER ^
CREATE PROCEDURE test_case(IN score INT)
BEGIN
	CASE 
	WHEN score = 100 THEN SELECT '满分';
	WHEN score >= 90 THEN SELECT '优秀';
	WHEN score >= 70 THEN SELECT '良好';
	WHEN score >= 60 THEN SELECT '及格';
	ELSE SELECT '不及格';
	END CASE;
END ^

CALL test_case(33)^

# if 结构
/*
语法：
if 条件 then 语句1
elseif 条件 then 语句2
...
else 语句n

仅用于begin end之中
*/
DELIMITER ^
CREATE FUNCTION test_if(score INT) RETURNS CHAR
BEGIN	
	IF score >= 90 THEN RETURN 'A';
	ELSEIF score >= 80 THEN RETURN 'B';
	ELSEIF score >= 60 THEN RETURN 'C';
	ELSE RETURN 'D';
	END IF;
	
END ^
SELECT test_if(44);

#二。循环结构
/*
while , loop , repeat 


iterate(重复)  类似 continue 
leave(离开) 类似 break 
*/

#1. while
/*
语法：
[标签:]while 循环条件 do
	循环体
end while [标签];
*/

DELIMITER ^
CREATE PROCEDURE test_while(IN insertcount INT)
BEGIN 
	DECLARE i INT DEFAULT 0;
	a:WHILE i < insertcount DO
		INSERT INTO admin 
		VALUES(i+1, CONCAT('p',i), '123');
		SET i = i + 1;
	END WHILE a;
	
END ^

DROP PROCEDURE test_while;
TRUNCATE TABLE admin;
#当插到一半时跳出
DELIMITER ^
CREATE PROCEDURE test_while(IN insertcount INT)
BEGIN 
	DECLARE i INT DEFAULT 0;
	a:WHILE i < insertcount DO
		INSERT INTO admin 
		VALUES(i+1, CONCAT('p',i), '123');
		IF i = insertcount/2-1 THEN LEAVE a;
		END IF;
		SET i = i + 1;
	END WHILE a;
	
END ^
DELIMITER ^
CALL test_while(4) ^
SELECT * FROM admin;

#2. loop
/*
语法：
[标签:]loop 
	循环体
end loop [标签];
*/

#3.repeat
/*
语法：
[标签:]repeat
	循环体
until 结束循环的条件
end repeat [标签];
*/
