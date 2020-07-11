1. show databases;   //显示数据库
2. use xx;      //使用哪个数据库
3. show tables;     //显示库中的表
4. show tables from xx;  //从哪个库中看表
5. select database();   //查看当前选择的库
6. create table xx(id int, name varchar(20));     //在库中创建表
7. desc xx;     //打印表的结构
8. select version();     //查询mysql的版本
### MySql的语法规范
1. 不区分大小写，但建议关键字大写，表名，列名小写
2. 每条命令最好用分号结尾
3. 每条命令根据需要，可以进行缩进，或换行
4. 注释  
    单行注释： # xxxx   或者  -- xxxxx
    多行注释： /* xxx */
#### DQL(data query language)
select 
#### DML(data manipulation language)
insert
delete
update
#### DDL(data definition language)
create
alter
drop
#### TCL(transaction control language)
 