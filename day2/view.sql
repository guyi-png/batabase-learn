#视图
/*
含义： 虚拟表，通过表多态生成的数据，没有实际创建表

作用:  
提高了重用性，就像一个函数。
对数据库重构，却不影响程序的运行。
提高了安全性能。
让数据更加清晰。

语法：
create view 视图名 as 查询语句;
*/
#一. 视图的创建
#查询姓猴的学生名和专业名
SELECT stuname, majorname
FROM studentinfo s
INNER JOIN major m
ON s.majorid = m.id
WHERE stuname LIKE '猴%';
#用视图
CREATE VIEW v1
AS 
SELECT stuname, majorname
FROM studentinfo s
INNER JOIN major m
ON s.majorid = m.id
WHERE stuname LIKE '猴%';

SELECT * FROM v1;

#二. 视图的修改
/*
方法一:
create or replace view 视图名 as 查询语句;
方法二:
alter view 视图名 as 查询语句;

可向视图中使用insert,delete,update,非以下情况下同时会改变原表;
情况: as后的查询语句有分组函数, distinct, group by, having, union或union all, 
常量视图不可更新, as后的查询语句包含子查询, as后的查询语句有多表连接, 
查询语句中from一个不能更新的视图, 查询语句中where的子查询引用了from子句中的表;

*/
ALTER VIEW v1 AS SELECT * FROM employees;

#三. 删除视图
/*
语法: drop view 视图名,视图名,...;
*/
CREATE VIEW s1 AS SELECT * FROM emplyees;
CREATE VIEW s2 AS SELECT * FROM departments;

DROP VIEW s1, s2;

#四. 查看视图
DESC 视图名;
SHOW CREATE VIEW 视图名;


