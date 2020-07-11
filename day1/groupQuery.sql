#分组查询
/*
语法：
select 分组函数,列(要求在group by后面出现) 
from 表 
where 筛选条件 
group by 分组列表
having 分组后的筛选条件

分组查询中的筛选条件分为两类： 
1. 分组前的筛选     筛选原数据表   	位于group by 的前面   用where
2. 分组后的筛选     筛选分组后的结果	位于group by 的后面   用having
	分组函数做条件一定是放在having子句中
	能在分组前筛选就尽量在分组前筛选
	group by 子句支持单个字段，多个字段
	也可以在后面添加排序
*/
# 以bb为分组，bb中每个都是一个小组，在小组中找到aa为最大的值
SELECT MAX(aa), bb FROM yy GROUP BY bb;
# 查询aa中包含a字符的，每个bb的平均cc
SELECT AVG(cc), bb FROM yy WHERE aa LIKE '%a%' GROUP BY bb;
# 查询每个aa中>2的的个数(添加分组后的筛选)
SELECT COUNT(*), aa FROM yy GROUP BY aa HAVING COUNT(*) > 2;
