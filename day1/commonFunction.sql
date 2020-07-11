#常见函数
/*
调用： select 函数名(参数列表) from 表

分类：1.单行函数: 如concat(), length(), ifnull()
      2.分组函数(统计函数，聚合函数): 传入多个参数，返回一个结果
*/
#一. 字符函数
#1. length()  获取长度
SELECT LENGTH('olg');  #3
SELECT LENGTH('奥利给'); #9

#2. concat() 拼接字符
SELECT CONCAT('o', 'l', '给');

#3. upper() and lower() 变大小写
SELECT UPPER('olg');
SELECT LOWER('OLG');

#4. substring()简写substr()  截取字符串
SELECT SUBSTR('欧勒格奥利给', 4); #index 从1开始
SELECT SUBSTR('欧勒格奥利给', 2, 3); #第二参数是要截的长度
#首字母大写,后面的小写,用_拼接
SELECT CONCAT(UPPER(SUBSTR('olg',1,1)), '_', LOWER(SUBSTR('olg',2))) AS olg;

#5. instr()返回子串在父串的位置,没有就返回0
SELECT INSTR('lglolg', 'olg'); #4

#6. trim() 去除前后空格,或指定字符
SELECT LENGTH(TRIM('        olg        ')) AS result; #3
SELECT TRIM('#' FROM '###########olg############') AS result; #olg

#7.lpad() 左填充  rpad() 右填充
SELECT LPAD('olg', 10, '#') AS result; # #######olg 一共10个字符
SELECT RPAD('olg', 10, '@') AS result;	# olg@@@@@@@

#8. replace 替换
SELECT REPLACE('ogg', 'g', 'l') AS result; #oll
SELECT REPLACE('otg', 't', 'l') AS result; #olg


#二. 数学函数
#1. round() 四舍五入
SELECT ROUND(3.3) AS result; #3
SELECT ROUND(1.563, 2) AS result; #1.56 保留小数点后两位

#2. ceil() 向上取整, 返回大于等于当前值的最小整数
SELECT CEIL(2.0001); #3
SELECT CEIL(2.000); #2

#4. floor() 向下取整,返回小于等于当前值的最小整数
SELECT FLOOR(2.9999); # 2
SELECT FLOOR(2.000); #2

#5. truncate() 从小数点后截断
SELECT TRUNCATE(1.333, 1); # 1.3
SELECT TRUNCATE(1.333, 0); # 1

#6. mod() 取余,类似 10%3  a-a/b*b
SELECT MOD(10, 3); # 1

#7. rand() 返回随机数0到1之间
SELECT RAND();


#三. 日期函数
#1. now() 返回日期和时间
SELECT NOW(); #2020-06-19 13:07:00

#2. curdate() 返回日期，不包含时间
SELECT CURDATE(); #2020-06-19

#3. curtime() 返回时间，不包含日期
SELECT CURTIME(); #13:09:23

#4. 获取指定的年，月，日，小时，分钟，秒
SELECT YEAR(NOW()) `year`; #2020
SELECT YEAR('2020-11-11') `year`; #2020
SELECT MONTH(NOW()) `month`; #6
SELECT MONTHNAME(NOW()) `month`; #June
SELECT HOUR(NOW()) `hour`; #13
SELECT MINUTE(NOW()) `minute`; #16
SELECT SECOND(NOW()) `second`; #26

#5. str_to_date() 将指定的字符串转为指定格式的字符
SELECT STR_TO_DATE('2020-9-1','%Y-%c-%d'); #2020-09-01
SELECT STR_TO_DATE('9-1 2020', '%c-%d %Y'); #2020-09-01

#6. date_fromat() 将日期转换为字符
SELECT DATE_FORMAT(NOW(), '%Y年%c月%d日'); #2020年6月19日
SELECT DATE_FORMAT(NOW(), '%c月/%d日 %Y年'); #6月/19日 2020年


#四. 其他函数
SELECT VERSION();   #查看数据库管理系统的版本
SELECT DATABASE();   #查看当前库 
SELECT USER();   #查看用户
SELECT PASSWORD('123'); #为密码加密
SELECT MD5('123');   #为密码加密
# ....


#五. 流程控制函数
#1. if()  与三元运算符类似   (a > b)? true:false
SELECT IF(10>5, '大于', '小于');

#2. case() 
# 使用情况一
/*
case 字段 
when 值 then 需要执行的表达式 
else 所有when不成立就执行的表达式 
end
*/
SELECT xx
CASE xx 
WHEN 1 THEN xx+1;
WHEN 2 THEN xx+2;
WHEN 3 THEN xx+3;
WHEN 4 THEN xx+4;
ELSE xx;
END AS result 
FROM yy;
# 使用情况二
/*
case
when 条件
then 执行的语句或值
else 所有when不成立就执行的语句或值
end 
*/
SELECT xx
CASE 
WHEN xx>10 THEN '10';
WHEN xx>20 THEN '20';
WHEN xx>30 THEN '30';
WHEN xx>40 THEN '40';
ELSE '50';
END AS result FROM yy;

#六. 分组函数
# 分类： sum求和  avg平均值   max最大值   min最小值   count个数
# xx是字段，操作的是该字段下的所有值 
SELECT SUM(xx) FROM yy;
SELECT AVG(xx) FROM yy;
SELECT MAX(xx) FROM yy;
SELECT MIN(xx) FROM yy;
SELECT COUNT(xx) FROM yy; #这几个方法忽略null
# 和distinct搭配
SELECT SUM(DISTINCT xx) FROM yy;
SELECT COUNT(DISTINCT xx) FROM yy;
# ...
# 查看有多少行
SELECT COUNT(*) FROM yy;
SELECT COUNT(1) FROM yy;  #括号里填常量
# 和分组函数一同查询的字段要求是group by后的字段

# datediff()返回日期相差天数
SELECT DATEDIFF(NOW(), '2000-1-1'); #7475


