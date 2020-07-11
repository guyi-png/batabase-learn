# 条件查询
/*
语法：
select 查询列表 from 表名 where 筛选条件

分类：
	一. 按条件表达式筛选
	条件运算符： >  <  =(等于)  != 或 <> (不等于)   <=   >=
	二. 按逻辑表达式筛选
	逻辑运算符： &&  ||  !    或    and or not
	三. 模糊查询：
	like   
	between and 
	in
	is  null
*/

#1.按条件表达式筛选
# 查询 >100的情况
SELECT * FROM yy WHERE oo > 100;
# 查询oo字段不等于100的情况
SELECT * FROM yy WHERE oo <> 100;
SELECT * FROM yy WHERE oo != 100;

#2.按逻辑表达式筛选
# 查询oo > 100 和 oo < 50的情况
SELECT * FROM yy WHERE oo >100 && oo < 50;
# 查询oo < 50 和 oo > 100, 或 oo > 200的情况
SELECT * FROM yy WHERE NOT(oo >= 50 AND oo <= 100) OR oo > 200;

#3.模糊查询
# like
# 查询字符中包含'a'的情况, yy表，oo字段, %通配符,任意多个字符(包括0个字符)
# _ 表示任意单个字符
SELECT * FROM yy WHERE oo LIKE '%a%'; 
SELECT * FROM yy WHERE oo LIKE '_a%'; # 以开头第二个字母为a的情况
SELECT * FROM yy WHERE oo LIKE '_\_a%'; # 第二个_被转义
SELECT * FROM yy WHERE oo LIKE '_$_a%' ESCAPE '$'; # 第二个_被转义
# between and  在……之间 
# 查询oo <= 100 和 oo >= 50的情况
SELECT * FROM yy WHERE oo BETWEEN 50 AND 100;
#in
#查询oo是aa,bb,cc的情况, oo与aa,bb,cc类型相同或兼容
SELECT xx FROM yy WHERE oo IN(aa,bb, cc);

#4.is null
#查询xx中没有aa的情况, =或<>不能判断null
SELECT xx FROM yy WHERE aa IS NULL;
#查询xx中有aa的情况
SELECT xx FROM yy WHERE aa IS NOT FULL;
#安全等于<=>
SELECT xx FROM yy WHERE aa <=> FULL;
SELECT xx FROM yy WHERE aa <=> 100;
