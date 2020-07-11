#常见约束
/*
含义： 一种限制， 用于限制表中的数据， 为了保证表中的数据的准确和可靠
分类：
	NOT NULL;  非空，该字段的值不能为空， 如姓名
	DEFAULT;    默认，字段有默认值，如性别
	PRIMARY KEY; 主键，字段的值具有唯一性且非空，如员工编号
	UNIQUE;     字段的值具有唯一性，可空， 如座位号
	CHECK;      检查约束（mysql不支持），如年龄
	FOREIGN KEY; 外键，该表的值必须来自于主表的关联列的值，如学生的专业编号
添加约束的时机： 1.创建表时   2.修改表时
约束的添加分类： 列级约束： 以上约束都行，但外键约束不起作用
		 表级约束： 除了NOT NULL 和DEFAULT都支持
*/
#一. 创建表时添加约束
#1.添加列级约束
/*
只支持默认，非空，主键，唯一
*/
CREATE TABLE studentinfo(
	id INT PRIMARY KEY,
	stuname VARCHAR(20) NOT NULL,
	gender CHAR CHECK(gender='男' OR gender='女'),
	seat INT UNIQUE,
	age INT DEFAULT 18,
	majorid INT REFERENCES major(id) # 外键, references引用
);
CREATE TABLE major(
	id INT PRIMARY KEY,
	majorname VARCHAR(20) NOT NULL
);
SHOW INDEX FROM studentinfo; #查看表中所有的索引，包括主键，外键，唯一

#2.添加表级约束
/*
在所有字段的最下面
[constraint 约束名](可选) 约束类型
*/
DROP TABLE IF EXISTS studentinfo;

CREATE TABLE IF NOT EXISTS studentinfo(
	id INT,
	stuname VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	CONSTRAINT pk PRIMARY KEY(id),
	CONSTRAINT un UNIQUE(stuname),
	CONSTRAINT ck CHECK(gender='男' OR gender='女')
	CONSTRAINT fk FOREIGN KEY(majorid) REFERENCES major(id)
);

#通用的写法
DROP TABLE IF EXISTS studnetinfo
CREATE TABLE IF NOT EXISTS studentinfo(
	id INT PRIMARY KEY,
	stuname VARCHAR(20) NOT NULL,
	gender CHAR,
	age INT DEFAULT 18,
	seat INT UNIQUE,
	majorid INT,
	CONSTRAINT fk_studentinfo_major FOREIGN KEY(majorid) REFERENCES major(id),
);

#主键和唯一的比较：
/*	保证唯一性	能否空		一个表有多少个    是否允许组合
主键：    yes             no		   最多1个            yes
唯一：	  yes	     yes,only one          可多个	      yes

外键：
	1.要求在从表设置外键关系
	2.从表的外键列的类型和主表的关联列类型一样或兼容，名称可不同
	3.主表的关联列必须是一个key(主键或唯一)
	4.插入数据时，先插入主表，再从表， 删除数据时，先删除从表，再主表
*/
#级联删除, 删除主表数据时同时把从表数据删除
ALTER TABLE studentinfo ADD CONSTRAINT fk_stu_major FOREIGN KEY(majorid) REFERENCES major(id) ON DELETE CASCADE;
#级联置空, 删除主表数据时同时把从表数据设为null
ALTER TABLE studentinfo ADD CONSTRAINT fk_stu_major FOREIGN KEY(majorid) REFERENCES major(id) ON DELETE SET NULL;

#二. 修改表时添加约束
/*
1.添加列级约束
alter table 表名 modify column 字段名 字段类型 新约束
2.添加表级约束
alter table 表名 add [constraint 约束名](可选) 约束类型(字段名);
*/
DROP TABLE IF EXISTS studentinfo;
CREATE TABLE IF NOT EXISTS studentinfo(
	id INT,
	stuname VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT
);
#1.添加非空约束
ALTER TABLE studentinfo MODIFY COLUMN stuname VARCHAR(20) NOT NULL;
#2.添加默认约束
ALTER TABLE studentinfo MODIFY COLUMN age INT DEFAULT 18;
#3.添加主键约束
ALTER TABLE studentinfo MODIFY COLUMN id INT PRIMARY KEY;
ALTER TABLE studentinfo ADD PRIMARY KEY(id);
#4.添加唯一约束
ALTER TABLE studentinfo MODIFY COLUMN seat INT UNIQUE;
ALTER TABLE studentinfo ADD UNIQUE(seat);
#4.添加外键约束
ALTER TABLE studentinfo ADD CONSTRAINT fk_studntinfo_major FOREIGN KEY(major) REFERENCES major(id);

#三.修改表时删除约束
#1.删除非空约束
ALTER TABLE studentinfo MODIFY COLUMN stuname VARCHAR(20) NULL;
ALTER TABLE studentinfo MODIFY COLUMN stuname VARCHAR(20);
#2.删除默认约束
ALTER TABLE studentinfo MODIFY COLUMN age INT;
#3.删除主键，主键最多一个
ALTER TABLE studentinfo DROP PRIMARY KEY; 
#4.删除唯一
ALTER TABLE studentinfo DROP INDEX seat;
#5.删除外键
ALTER TABLE studentinfo DROP FOREIGN KEY fk_studntinfo_major;

