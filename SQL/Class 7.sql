/*drop all the tables*/
DROP TABLE customer;
DROP TABLE customerOrder;

select productDesc
From product
WHERE productDesc Like '%TABLE'

create table Customer
(
customerID CHAR(10) PRIMARY KEY,
customerFName VARCHAR(30) NOT NULL,
customerLName VARCHAR(30) NOT NULL
);


SeleCT * FROM customer;
INSERT into customer VALUES ('1', 'Abe', 'Kelly')

SELECT customerFName, customerLNAme
FROM customer
WHERE customerLName LIKE '____y';

DROP TABLE product;

CREATE TABLE product
(
  productID INT IDENTITY(1,1),
  productDesc VARCHAR(50) NOT NULL,
  productFinish VARCHAR(20)
	check(productFinish in ('Cherry', 'Natural Ash', 'White Ash', 'Red Oak', 'Natural Oak', 'Walnut')),
  standardPrice DECIMAL(6,2),
  
  CONSTRAINT product_PK PRIMARY KEY (productID),
  
);

INSERT INTO product VALUES ('End Table', 'Cherry', 175.00);
INSERT INTO product VALUES ('Coffee Table', 'Natural Ash', 400.00);
INSERT INTO product VALUES ('Computer Desk', 'Cherry', 175.00);
INSERT INTO product VALUES ('Dining Table', 'Cherry', 800.00);
INSERT INTO product VALUES ('Computer Desk', 'Walnut', 250.00);

SELECT * FROM product

/*show table and desks products whose prices are higher than 200*/
SELECT productDesc, productFinish, standardPrice
FROM product
WHERE (productDesc LIKE '%Desk'
			OR productDesc LIKE '%Table')
		       AND standardPrice > 200;

/*show table and desks products whose prices are between 200 and 500*/
SELECT * FROM product
WHERE standardPrice  BETWEEN 200 AND 500;
/*it always includes the boundaries*/
DROP TABLE CUSTOMER;
CREATE TABLE customer
(
  customerID NUMERIC(10,0) NOT NULL,
  customerFName VARCHAR(20) NOT NULL,
  customerLName VARCHAR(20) NOT NULL,
  customerStreetNo VARCHAR(10) NOT NULL,
  customerStreet VARCHAR(20) NOT NULL,
  customerCity VARCHAR(20) NOT NULL,
  customerState VARCHAR(2) NOT NULL,
  customerZip VARCHAR(9) NOT NULL,
  customerGender CHAR(1) NOT NULL,

  CONSTRAINT customer_PK PRIMARY KEY (customerID)

);
INSERT INTO customer values (1000000001, 'John', 'Smith', '708', 'Main Street', 'Pinesville', 'TX', '45678','M');
INSERT INTO customer values (1000000002, 'Abe', 'Kelly', '6508', 'Wright Street', 'Pinesville', 'MN', '24680','F');
INSERT INTO customer values (1000000003, 'Ben', 'Muller', '508', 'Oak Street', 'Greensville', 'NY', '13579','M');
INSERT INTO customer values (1000000004, 'Carl', 'Lyle', '608', 'Pine Street', 'Mountain View', 'CA', '12345','M');
INSERT INTO customer values (1000000005, 'Diane', 'Nielsen', '650', 'Maple Street', 'Savoy', 'RI', '67890','F');
INSERT INTO customer values (1000000006, 'Elaine', 'Thomas', '511', 'Apple Street', 'Thunder', 'CA', '55555','F');
INSERT INTO customer values (1000000007, 'Henry', 'Thomas', '765', 'Pear Street', 'Thunder', 'CA', '55555','M');
/*Find the customers who are not from FL, TX, CA OR HI*/
SELECT *
FROM customer
WHERE customerState NOT IN ('FL', 'TX', 'CA', 'HI');

/*count*/
SELECT COUNT(customerID) AS COUNTCUSTOMERS from customer WHERE customerState ='CA';

SELECT COUNT(productID) 
FROM orderline
WHERE orderID=1004;

SELECT SUM(quantity) 
FROM orderline
WHERE orderID=1004

/*GROUP BY: data categorization */

SELECT customerState, customerGender, COUNT(customerID) 'total number of customers'
FROM customer
GROUP BY customerState, customerGender
ORDER BY customerState DESC, customerGender;

select * from customer;

SELECT COUNT(customerID) 'total number of male customers'
FROM customer
where customerGender='M';



/*Exercise 1*/
Select customerState, COUNT (customerID) FROM customer
GROUP BY customerState
Having count (distinct customerGender)>1;

/*Exercise2*/ 
Select customerState, count(customerID) as MALE
From customer
Where customerGender like 'M' group by customerState