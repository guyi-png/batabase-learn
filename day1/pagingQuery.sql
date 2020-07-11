#分页查询
/*
应用场景：当要显示的数据：一页显示不全，需要分页提交sql请求
语法：
	select 查询列表		#7
	form 表			#1
	连接类型 join 表2	#2
	on 连接条件		#3
	where 筛选条件		#4
	group by 分组字段	#5
	having 分组后的筛选条件	#6
	order by 排序的字段	#8
	limit offset, size;	#9
	
	offset 要显示条目的起始索引(从0开始)
	size 要显示的条目的个数
	limit 语法和执行顺序上都是在最后
	
	分页请求的公式：(page页数， size每页的条目数)
		limit后面：(page-1)*size ,size;
*/
#查询前五条员工的信息
SELECT * 
FROM employees
LIMIT 0, 5;
#查询第11到25条的员工的信息
SELECT *
FROM employees
LIMIT 10,15;
#查询有奖金的员工信息， 并且显示工资较高的前10名
SELECT *
FROM employees
WHERE bonus IS NOT NULL 
ORDER BY salary DESC
LIMIT 10;






