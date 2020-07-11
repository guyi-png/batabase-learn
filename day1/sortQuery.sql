#排序查询
/*
语法：
select 查询列表 from 表 where 筛选条件 order by 排序列表(asc/desc)
asc 升序(默认)     desc 降序 
*/

#查询oo，以aa从高到低排序
SELECT * FROM yy ORDER BY oo DESC;
#按oo的长度显示xx, length()获取字段长度
SELECT xx FROM yy ORDER BY LENGTH(oo);
#按aa升序，再按bb降序
SELECT * FROM yy ORDER BY aa ASC, bb DESC;
 