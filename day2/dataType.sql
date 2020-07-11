#常见的数据类型
/*
数值型：
	整型
	小数型：
		定点数：
		浮点数：
字符型：
	较短的文本: char  varchar
	较长的文本: text  blob
 日期型：
	
*/
#一. 整型
/*
tinyint, 字节1
smallint,    2
mediumint,   3
int/integer, 4
bigint	     8
特点：
1.如果不设置unsigned(无符号) 默认为有符号的
2.如果插入的数值超出了整型的范围，会报out of range异常,并且插入临界值
3.如果不设置长度， 会有默认的长度
4. 长度代表显示的最长宽度，如果不够会用0在左边填充，但必须搭配zerofill使用
*/
DROP TABLE tab_int;
CREATE TABLE tab_int(
	t1 INT(11) ZEROFILL,
	t2 INT UNSIGNED
);
INSERT INTO tab_int
VALUES(11, 11);
SELECT * FROM tab_int;

#二. 小数
/*
1.浮点型
float(M,D)
double(M, D)
2.定点型
dec(M,D)
decimal(M,D)

特点：
M和D(可省略): M整数部位和小数部位的长度， D小数部位的长度
如果插入的数值超出了整型的范围，会报out of range异常,并且插入临界值
如果是decimal，则M默认为10，D默认为0
定点型的精度较高， 如果要求插入数值的精度较高如货币运算则使用定点型

选择原则：
所选择的类型越简单越好，能保存的数值的类型越小越好
*/
CREATE TABLE tab_float(
	f1 FLOAT(5,2),
	f2 DOUBLE(5,2),
	f3 DECIMAL(5,2)
);
INSERT INTO tab_float VALUES(123.45, 123.45, 123.34);
SELECT * FROM tab_float;

#三. 字符型
/*
较短的文本： char  varchar
较长的文本： text  blob(较长的二进制)

特点：
 char：
 写法：  char(M)      M为最大的字符数默认为1    特点：固定长度的字符   空间耗费大点，但效率高点
 varchar：
 写法：  varchar(M)   M(不可省略)为最大的字符数    特点：可变长度的字符   空间耗费小点，但效率低点
*/
#ENUM类型保存枚举,不区分大小写
CREATE TABLE tab_char(
	c1 ENUM('a', 'b', 'c')
);

INSERT INTO tab_char 
VALUES('a'), ('b'), ('c'), ('C');

SELECT * FROM tab_char;

#set类型保存集合，不区分大小写
CREATE TABLE tab_set(
	s1 SET('a', 'b', 'c', 'd')
);

INSERT INTO tab_set
VALUES('a'), ('a,c,d'), ('a,b,c,d');

SELECT * FROM tab_set;

#binary和varbinary用于保存较短的二进制

#四. 日期型
/*
分类：
date 只保存日期
time 只保存时间
year 只保存年
datetime 保存日期+时间
timestamp 保存日期+时间

特点：
		字节		范围		时区等的影响
datetime 	  8	 1000-1-1~9999-12-31       无影响
timestamp	  4 1970-1-1 8:00:01~2038某时间    有影响
*/
CREATE TABLE tab_date(
	t1 DATETIME,
	t2 TIMESTAMP
);

INSERT INTO tab_date 
VALUES(NOW(), NOW());

SELECT * FROM tab_date;

SET time_zone = '+9:00';

