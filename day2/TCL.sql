#TCL
/*
transaction control language 事务控制语言
事务：
一个或一组sql语句组成的一个执行单元，这个执行单元要么全部执行，要么全部不执行

事务的ACID属性
1.原子性(atomicity): 事务不可分，要么全部执行，要么全部不执行
2.一致性(consistency)：事务必须使数据库从一个一致性状态变换到另一个一致性状态
3.隔离性(isolation): 每个事务不受其他事务的干扰
4.持久性(durability): 一个事务一旦提交，它对数据库中数据的改变是永久的

事务的创建
隐式事务：事务没有明显的开启和结束的标记， 如delete，update，insert，select
显式事务：事务具有明显的开启和结束的标记，
使用 set_autocommit=0 禁用自动提交功能
显式事务语法：
set autocommit = 0;
start transaction;
事务一（sql的语句）
事务二
事务三
...
结束事务
提交事务
回滚事务
*/
SHOW ENGINES;  #查看mysql支持的存储引擎

CREATE TABLE balance(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20) NOT NULL,
	account DECIMAL(12,2) DEFAULT 0
);
INSERT INTO balance 
VALUES(NULL, 'one', 1000), (NULL, 'two', 1000);

SELECT * FROM balance;

#开启事务
SET autocommit = 0;
START TRANSACTION;
#编写事务的语句
UPDATE balance SET account = 500 WHERE username='one';
UPDATE balance SET account = 1500 WHERE username='two';
#结束事务
COMMIT;

#开启事务
SET autocommit = 0;
START TRANSACTION;
#编写事务的语句
UPDATE balance SET account = 1000 WHERE username='one';
UPDATE balance SET account = 1000 WHERE username='two';
#回滚
ROLLBACK;

/*
并发事务: 多个事务同时操作同一个数据库的相同数据
并发事务产生的问题: 
1.脏读: 一个事务读取了其他事务还没有提交的数据,会读到刚更新的数据
2.不可重复读: 一个事务读取多次数据,结果不一样
3.幻读: 一个事务读取了其他事务还没有提交的数据,会读到新插入的数据

每启动一个mysql程序，就会获得一个单独的数据库连接，
每个数据库都有一个全局变量 @@tx_isolation表示当前的事务隔离级别
select @@tx_isolation; #查看当前的隔离级别

事务的隔离级别：
会出现			脏读		幻读		不可重复读
read uncommitted:	yes		yes		yes
read committed:		no 		yes		yes	
repeatable read:	no		yes		no
serialzable:		no		no		no
mysql中默认为repeatable read
Oracle中默认为read committed		

设置当前mysql连接的隔离级别： 
set [session] transaction isolaction level 隔离级别;
设置mysql的全局的隔离级别
set global transaction isolaction level 隔离级别;
*/

/*
savepoint 节点名，设置保存点
*/
SET autocommit = 0;
START TRANSACTION;
DELETE FROM balance WHERE id = 1;
SAVEPOINT a;  #设置保存点
DELETE FROM balance WHERE id = 2;
ROLLBACK TO a;	#回滚到a保存点

#delete和truncate在事务使用时的区别
SELECT * FROM balance;
#使用delete,可回滚
SET autocommit = 0;
START TRANSACTION;
DELETE FROM balance;
ROLLBACK;
#使用truncate,不可回滚
SET autocommit = 0;
START TRANSACTION;
TRUNCATE TABLE balance;
ROLLBACK;