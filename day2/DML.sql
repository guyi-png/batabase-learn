#DML语言
/*
数据操作语言
插入： insert
删除： delete
修改： update
*/

#一. 插入语言
/*
语句1(支持多行插入)：
insert into 表名(列名, ...)
values(要插的值, ...);
特点：
1.插入的值的类型要与列的类型一致或兼容
2.不可以为null的列必须插入值，可以为null的列可以插入null或不填
3.列的顺序可以调换
4.列数与值的个数必须一致
5.可以省略列名，默认为所有列，而且列的顺序与表中的列的顺序一致
*/
USE test;
INSERT INTO female(id, `name`, sex, birthday)
VALUES(1, '奥利给', '女', NULL);

INSERT INTO female
VALUES(2, '里给了', '女', '2000-1-1');

INSERT INTO female
VALUES(4, '利给了', '女', '2020-1-2'),
(5, '利勒格', '女', '2010-5-2');

#子查询的结果插入表中
INSERT INTO female
SELECT 6, '咣咣咣', '女', NULL;

SELECT * FROM female;
/*
语法2：
insert into 表名
set 列名=值，列名=值...
*/
INSERT INTO female
SET id = 3, `name`='欧勒格', sex = '女';

# 二. 修改语言
/*
语法：
update 表名		#1
set 列=新值，列=新值...	#3
where 筛选条件;		#2

修改多个表的记录：
# sql99语法：
update 表1 别名
连接类型 join 表2 别名
on 连接条件
set 列=新值，列=新值...
where 筛选条件; 
*/
#修改奥利给的birthday
UPDATE female
SET birthday = '2221-4-3 12:33:43'
WHERE `name` = '奥利给';

#三. 删除语句
/*
方式一： delete
语法：
delete from 表名 where 筛选条件

删除多个表数据
# sql99语法
delete 表1的别名，表2的别名
from 表1 别名
连接类型 join 表2 别名
on 连接条件
where 筛选条件

方式二： truncate
语法：truncate table 表名
*/
SELECT * FROM female ;
#删除有‘给’字的行
DELETE FROM female WHERE `name` LIKE '%给%';
#删除表中所有的数据， 不能加where
TRUNCATE TABLE female;

# 如果删除的表中有自增长列，
# 使用delete删除再次插入值时是从断点处自增
# 使用truncate删除再次插入值时是从1开始
# delete 删除有返回值且可以回滚， 而truncate 删除没有返回值不能回滚
