#DDL
/*
数据定义语言
库和表的管理
一. 库的管理
创建，修改，删除
二. 表的管理
创建，修改，删除

创建： create
修改： alter
删除： drop

*/

#一. 库的管理
#1. 库的创建
/*
语法：
create database 库名;
*/
CREATE DATABASE library;
# 如果不存在bank这个库就可以创建
CREATE DATABASE IF NOT EXISTS bank;

#2. 库的修改，
#为数据库重命名
RENAME DATABASE library TO newlibrary # 慎重，可能数据会丢失
# 修改库的字符集
ALTER DATABASE library CHARACTER SET utf8;

#3. 库的删除
DROP DATABASE IF EXISTS library;

#二. 表的管理
#1.表的创建
/*
create table 表名(
	列名 列的类型(长度) 约束,
	列名 列的类型(长度) 约束,
	...
)
*/
CREATE TABLE IF EXISTS books(
	id INT,  #书的编号
	bname VARCHAR(20), #书名
	price DOUBLE, #价格
	author VARCHAR(20), #作者
	publishdate DATE #出版日期 
);
DESC books; #显示表的结构

#2.表的修改
#修改列名 
ALTER TABLE books CHANGE COLUMN bname bookname VARCHAR(20);
#修改列的类型或约束
ALTER TABLE books MODIFY COLUMN publishdate DATETIME;
#添加新的列, first/after加到前面/后面，
ALTER TABLE books ADD COLUMN popularity INT FIRST;
#删除列
ALTER TABLE books DROP COLUMN popularity;
#修改表名
ALTER TABLE books RENAME TO b_books;

#3.表的删除
DROP TABLE IF EXISTS b_books;
SHOW TABLES; #显示当前库的所有表

#4.表的复制
# 创建表
CREATE TABLE IF NOT EXISTS person(
	`name` VARCHAR(20),
	age INT,
	sex CHAR(1)
);
# 向表中添加数据
INSERT INTO person
VALUES ('小一', 10, '男'),
('中二', 15, '女'),
('大三', 20, '男');

SELECT * FROM person;
# 仅仅复制上表的结构
CREATE TABLE human LIKE person;
# 复制表的结构和所有数据
CREATE TABLE human SELECT * FROM person;
# 复制表的结构和部分数据
CREATE TABLE human SELECT `name`, age FROM person WHERE age = 15;
# 仅仅复制某些字段
CREATE TABLE human SELECT `name`, sex FROM person WHERE 1 = 2;

