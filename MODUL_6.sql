
USE master
GO
CREATE DATABASE YURII_BRATYUK
GO

USE YURII_BRATYUK
GO


CREATE TABLE [suppliers]   (

		[supplierid]				integer PRIMARY KEY,
		[name]						varchar (20),
		[rating]					integer,
		[city]						varchar (20),
			
)
GO


CREATE TABLE [details]   (

		[detailid]					integer PRIMARY KEY,
		[name]						varchar (20),
		[color]						varchar (20),
		[weight]					integer,
		[city]						varchar (20),
)
GO

CREATE TABLE [products]   (

		[productid]					integer PRIMARY KEY,
		[name]						varchar (20),
		[city]						varchar (20),
)
GO

CREATE TABLE [supplies]   (

		[supplierid]				integer FOREIGN KEY REFERENCES suppliers(supplierid),
		[detailid]					integer FOREIGN KEY REFERENCES details(detailid),
		[productid]				    integer FOREIGN KEY REFERENCES products(productid),
		[quantity]					integer ,
)
GO

USE YURII_BRATYUK
GO

INSERT INTO suppliers VALUES (1,	'Smith',	20,	'London'),
							 (2,	'Jonth',	10,	'Paris'),
							 (3,	'Blacke',	30,	'Paris'),
							 (4,	'Clarck',	20,	'London'),
							 (5,	'Adams',	30,	'Athens');


INSERT INTO details VALUES (1, 'Screw',			'Red',		12,	'London'),
						   (2, 'Bolt',			'Green',	17,	'Paris'),
						   (3, 'Male-screw',	'Blue',		17,	'Roma'),
						   (4, 'Male-screw',	'Red',		14,	'London'),
						   (5, 'Whell',			'Blue',		12,	'Paris'),
						   (6, 'Bloom',			'Red',		19,	'London');
						


INSERT INTO products VALUES (1, 'HDD',			'Paris'),
							(2, 'Perforator',	'Roma'),
							(3, 'Reader',		'Athens'),
							(4, 'Printer',		'Athens'),
							(5, 'FDD',			'London'),
							(6, 'Terminal',		'Oslo'),
							(7, 'Ribbon',		'London');



INSERT INTO supplies VALUES (1,	1,	1,	200),
							(1,	1,	4,	700),
							(2,	3,	1,	400),
							(2,	3,	2,	200),
							(2,	3,	3,	200),
							(2,	3,	4,	500),
							(2,	3,	5,	600),
							(2,	3,	6,	400),
							(2,	3,	7,	800),
							(2,	5,	2,	100),
							(3,	3,	1,	200),
							(3,	4,	2,	500),
							(4,	6,	3,	300),
							(4,	6,	7,	300),
							(5,	2,	2,	200),
							(5,	2,	4,	100),
							(5,	5,	5,	500),
							(5,	5,	7,	100),
							(5,	6,	2,	200),
							(5,	1,	4,	100),
							(5,	3,	4,	200),
							(5,	4,	4,	800),
							(5,	5,	4,	400),
							(5,	6,	4,	500);
						

GO



USE YURII_BRATYUK

---1
SELECT productid, name, city,
ROW_NUMBER() OVER(ORDER BY City) AS 'порядковий номер'
  FROM products

---2

SELECT productid, name, city,
ROW_NUMBER() OVER(PARTITION BY City ORDER BY name) AS 'порядковий номер в межах міста'
  FROM products

---3

SELECT *
FROM (SELECT productid, name, city,
ROW_NUMBER() OVER(PARTITION BY City ORDER BY name) AS 'порядковий номер в межах міста'
  FROM products) AS S
  WHERE [порядковий номер в межах міста] = 1

--- 4

SELECT productid, detailid, quantity,
SUM(quantity) OVER (PARTITION BY productid) AS 'all_quantity_per_prod',
SUM(quantity) OVER (PARTITION BY detailid) AS 'all_quantity_per_det'
  FROM supplies


---5

SELECT *
 FROM (SELECT supplierid, detailid, productid, quantity,
 ROW_NUMBER() OVER (ORDER BY supplierid) AS rn,
 COUNT(supplierid) OVER () AS tot
   FROM supplies
	) AS XXX
WHERE rn BETWEEN 10 AND 15;


---6

SELECT * 
 FROM (SELECT supplierid, detailid, productid, quantity,
 AVG(quantity) OVER () AS avg_qty
   FROM supplies
	) AS SSS
WHERE quantity < avg_qty;


