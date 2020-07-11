#子查询
/*
含义：出现在其他语句中的select语句，称为子查询或内查询
外部的查询语句称为主查询或外查询
以select为主：
  分类：
	按子查询出现的位置：
			    select后面：仅支持标量子查询  
			    from后面：支持表子查询
			    where或having后面：标量子查询，列子查询，行子查询
			    exists后面：表子查询
	按结果集的行列数不同：
			    标量子查询（结果集只有一行一列）
			    列子查询（结果集有一列多行）
			    行子查询（结果集有一行多列）
			    表子查询（结果集有多行多列）
*/
#一. where或having的后面
#1.标量子查询（单行子查询）
#2.列子查询（多行子查询）
#3.行子查询（多列多行）
#特点：
#①子查询放在小括号内
#②子查询一般放在条件的右边
#标量子查询，一般搭配单行操作符（> = < <> <= >=）使用
#列子查询，一般搭配多行操作符（in any/some all）使用
#子查询优先于主查询

#1.标量子查询
#查询谁的工资比aa的高
SELECT *
FROM employees
WHERE salary > (
	SELECT salary FROM employees WHERE `name` = 'aa'
);

#查询job_id与111号员工相同，salary比135号员工多的员工，姓名，job_id，工资
SELECT `name`, job_id, salary
FROM employees 
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 111
) AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 135
);

#查询公司工资最少的员工的name，job_id，salary
/*select `name`, job_id, salary
from employee 
where salary = min(salary);*/  #   ???
SELECT `name`, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

#查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary) 
	FROM employees
	WHERE department_id = 50
);

#2.列子查询
#查询location_id是1400或1700的部门中的所有员工姓名
SELECT `name` 
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400, 1700)
);

#查询其他工种中比job_id为“olg”工种任意员工的工资低的员工号，姓名，job_id，salary
SELECT `name`, employee_id, salary, job_id
FROM employees 
WHERE salary < ANY(  # any和some一样
	SELECT DISTINCT salary 
	FROM employees
	WHERE job_id = 'olg'
) AND job_id <> 'olg';
#或者
SELECT `name`, employee_id, salary, job_id
FROM employees 
WHERE salary < (
	SELECT MAX(salary)
	FROM employees
	WHERE job_id = 'olg'
) AND job_id <> 'olg';

#查询其他工种中比job_id为“olg”工种所有员工的工资低的员工号，姓名，job_id，salary
SELECT `name`, employee_id, salary, job_id
FROM employees
WHERE salary < ALL(
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id = 'olg'
);
#或者
SELECT `name`, employee_id, salary, job_id
FROM employees 
WHERE salary < (
	SELECT MIN(salary)
	FROM employees
	WHERE job_id = 'olg'
) AND job_id <> 'olg';

#3.行子查询（一行多列或多行多列）
#查询员工编号最小并且工资最高的员工信息
/*
select *
from employees
where min(employee_id) and max(salary);     ???
*/
SELECT *
FROM employees
WHERE employee_id = (
	SELECT MIN(employee_id)
	FROM employees
) AND salary = (
	SELECT MAX(salary)
	FROM employees
);
#或
SELECT *
FROM employees 
WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary)
	FROM employees
);

#二.select后面
#查询每个部门的员工个数
SELECT d.*, (
	SELECT COUNT(*) 
	FROM employees e
	WHERE e.department_id = d.department_id
)
FROM departments d;

#查询员工号为102的部门名
SELECT (
	SELECT department_name
	FROM departments d
	INNER JOIN employees e
	ON d.department_id = e.department_id
	WHERE e.employee_id = 102
);

#三. from后面
#查询每个部门的平均工资的工资等级
#表子查询
SELECT avg_dep.* , g.level
FROM (
	SELECT AVG(salary) `avg`, department_id
	FROM employees
	GROUP BY department_id
) avg_dep
INNER JOIN job_grades g
ON avg_dep.avg BETWEEN lowest_sal AND highest_sal

#四. exists后面 (exists存在)
/*
语法： 
exists(完整的查询语句)
结果： 0(无)或1(有)
*/
SELECT EXISTS(SELECT employee_id FROM employees);
#查询有员工的部门名
SELECT department_name
FROM departments d 
WHERE EXISTS(
	SELECT *
	FROM employees e
	WHERE d.department_id = e.department_id5ed4
)
