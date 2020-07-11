# 基础查询
/*
语法：
select 查询列表
form 表名;

类似于： System.out.println(打印);
特点：
1. 查询列表可以是，表中的字段，常量值，表达式，函数
2. 查询的结果是一个虚拟的表格
*/

USE test; 
#1.查询表中的单个字段
SELECT xx FROM yy;

#2.查询表中的多个字段
SELECT xx, xx FROM yy;

#3.查询表中的所有字段
SELECT * FROM yy;

#4.查询常量池
SELECT 100;
SELECT 'olg';

#5.查询表达式
SELECT 100+150;

#6.查询函数 
SELECT DATABASE();

#7.取别名
SELECT 100+150 AS result;
SELECT xx AS XX FROM yy;
SELECT xx XX FROM yy;
SELECT xx AS "x x" FROM yy;

#8.查询时去除重复(distinct 独特的)
SELECT DISTINCT xx FROM yy;

#9.操作符+的作用,
# aa和bb都是数值类型就直接相加，其中一个为字符型(22+'33')，
# 则尝试将'33'转为数值型33, 
# 若(22+'三三'),明显转化不了，则将字符型转为数值0，
# 若aa或bb有为 null 的相加后一定是null
SELECT aa+bb AS xx FROM yy;

#10.合并字符型,使用函数concat(),和null拼接一定是null
SELECT CONCAT('o','l','g') AS xx;
SELECT CONCAT('o','l',NULL) AS xx;

#11.判断是否为空, isnull(p1, p2), 
# p1为null就取p2的值，p1不为null还是p1
SELECT IFNULL(NULL, 222) AS xx;
SELECT IFNULL(22, 33) AS xx;
