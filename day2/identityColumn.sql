#标识列
/*
又称自增长列
含义： 可以不用手动插入值，系统提供默认的序列值

*/
#一. 创建表时设置标识列
/*
特点： 
1.标识列必须是key
2.一个表只有一个自增长列
3.标识列的类型必须是数值型
4.标识列可以通过set auto_increment设置步长 
5.可以手动插入起始值
*/
DROP DATABASE library;
CREATE DATABASE library;
USE library;

CREATE TABLE IF NOT EXISTS tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(20)
);

DROP TABLE IF EXISTS tab_identity;

INSERT INTO tab_identity 
VALUES(NULL, 'olg');
INSERT INTO tab_identity 
VALUES(NULL, 'glo');

SELECT * FROM tab_identity;

SHOW VARIABLES LIKE '%auto_increment%';
#设每次自增长为3
SET auto_increment_increment = 3;

#二. 修改表时设置标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT AUTO_INCREMENT;

#三. 修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT;