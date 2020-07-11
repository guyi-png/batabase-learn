#联合查询
/*
union合并： 将多条查询语句的结果合并为一个结果
语法：
	查询语句
	union
	查询语句
	union
	查询语句
	union
	...
	
应用场景： 要查询的结果来自于多个表， 且多个表没有直接的连接关系，但查询的信息一致时
特点： 
1.要求多条查询语句的列数相同
2.多条查询语句以第一个的查询语句的字段名为所有的字段名，
要求多条查询语句的每一列的类型和顺序一致
3.union默认去除了重复，如果使用union all 可以包含重复项
*/

#查询部门编号>90或邮箱包含a的员工信息
SELECT * 
FROM employees 
WHERE email LIKE '%a%'
UNION 
SELECT * 
FROM employees
WHERE department_id > 90;
# 等价
SELECT * 
FROM employees 
WHERE email LIKE '%a%' OR department_id >90;

#查询中国用户的男人信息和外国用户的男人的信息
SELECT id , `name` FROM ch WHERE sex = '男'
UNION ALL
SELECT f_id, f_name, FROM fc WHERE sex = 'male';
