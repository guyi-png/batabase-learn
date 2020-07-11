#连接查询
/*
含义：又称多表查询, 当查询的字段来自于多个表时， 就需要连接查询

笛卡尔乘积现象： table1 有n行,  table2 有m行,  结果n*m行
发生原因： 没有有效的连接条件
解决： 添加有效的连接条件

分类： 
	按年代分： sql92标准   sql99标准
	按功能分： 
		   内连接:  等值连接  非等值连接  自连接  
		   外连接： 左外连接  右外连接    全外连接   
		   交叉连接
*/

#select aa,bb from xx,yy; 出现笛卡尔乘积现象

#sql92标准
#1. 等值连接
/*
多表等值连接的结果为多表的交集部分
n表连接，至少需要n-1个连接条件
多表的顺序没有要求
一般为表取别名，避免歧义，简化
*/
SELECT aa ,bb 
FROM xx,yy
WHERE xx.o1 = yy.o2;
#为表取别名
SELECT xx.aa, yy.bb
FROM xxx AS xx, yyy AS yy
WHERE xx.o1 = yy.o2;

#2.非等值连接
#查询员工工资和员工等级
SELECT salary, grade_level 
FROM employee e, job_grade g
WHERE salary BETWEEN g.`lowest_sal` AND g.`highest_sal`;

#3.自连接
#查询员工名和上级名
SELECT e.employee_id, e.`name`, m.employee_id, m.`name` 
FROM employee e, employee m
WHERE e.manager_id = m.employee_id;


#sql99标准
/*
语法：
select 查询列表
from 表1 连接类型 
join 表2
on 连接条件
where 筛选条件

连接类型： 
内连接： inner (可省略)
外连接： 左外：left outer
	 右外：right outer
	 全外： full outer
交叉连接： cross
*/
#1.内连接
#查询员工名，部门名
SELECT e.employee_name, d.department_name
FROM employees e 
INNER JOIN departments d 
ON e.department_id = d.department_id;
#查询名字中包含a的员工名和工种名
SELECT e.employee_name, j.job_name
FROM employee e 
INNER JOIN job j
ON e.job_id = j.job_id;
WHERE e.employee_name LIKE '%a%' AND j.job_name LIKE '%a%';
#查询部门个数>3的城市名和部门个数
SELECT city,COUNT(*) 
FROM location l 
INNER JOIN department d
ON l.location_id = d.location_id
GROUP BY city
HAVING COUNT(*) > 3;
#查询哪些部门的员工个数>3的部门名和员工个数，并按个数降序
SELECT department_name, COUNT(*) `count` 
FROM employee e
INNER JOIN department d
ON e.department_id = d.department_id
GROUP BY department_name
HAVING COUNT(*) > 3
ORDER BY COUNT(*) DESC;

#2.外连接
/*
应用场景：用于查询一个表中有，另一个表中没有的记录
特点：
	1.外连接的查询结果为主表中所有记录
	2.如果表中存在与它匹配的，就显示匹配的值，不存在就显示null
	3.外连接的结果 = 内连接结果 + 主表中有而从表中没有的记录
	4.左外以左边的表为主表
	5.右外以右边的表为主表
	6.全外连接 = 内连接的结果 + 表1中有而表2中没有的记录 + 表2中有而表1中没有的记录
*/
#没有女朋友的男人的名字
SELECT m.name,f.name
FROM female f
RIGHT OUTER JOIN male m
ON m.grilfriend_id = f.id
WHERE f.id IS NOT NULL;
#查询哪个部门没有员工
SELECT d.*, e.employee_id
FROM department d
LEFT OUTER JOIN employee e
ON e.department_id = d.department_id
WHERE e.employee.id IS FULL;
#全外
SELECT f.*, m.*
FROM female f
FULL OUTER JOIN male m
ON m.grilfriend_id = f.id

#交叉连接,就是笛卡尔乘积
SELECT f.name, m.name
FROM female f
CROSS male m;
