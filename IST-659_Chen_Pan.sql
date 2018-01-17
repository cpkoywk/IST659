create table Customer
(
customerID CHAR(10) PRIMARY KEY,
customerName VARCHAR(39) NOT NULL
);

INSERT INTO customer VALUES('1', 'Pan');
INSERT INTO customer VALUES('2', 'BronBron');

select * FROM customer;

Create TABLE Product
(
productID Char(10) NOT NULL,
productName VARCHAR(30) NOT NULL UNIQUE,
productDesc VARCHAR(100) NOT NULL,
productPrice DECIMAL(6,2) NOT NULL,
productFinish VARCHAR(10) NOT NULL CHECK (productFinish IN('cherry', 'walnut', 'oak')),
CONSTRAINT product_PK PRIMARY KEY (productID)
);

INSERT INTO Product VALUES('12', 'WoodBox', 'its good', '12.00', 'cherry');

create TABLE customerOrder
(
	orderID CHAR(10) NOT NULL,
	orderDate DATETIME DEFAULT getdate(),
	customerID CHAR(10) NOT NULL,

	constraint order_PK PRIMARY KEY (orderID),
	constraint order_FK FOREIGN KEY (customerID) REFERENCES customer(CustomerID)
);
INSERT INTO customerOrder(orderID, customerID) VALUES ('1000001', '1');

select * FROM customerOrder;
/*
comment
*/

create TABLE orderline
(
	orderID CHAR(10) NOT NULL,
	productID CHAR(10) NOT NULL,
	quantity INTEGER NOT NULL,

	constraint orderline_PK PRIMARY KEY (orderID, productID),
	constraint orderline_FK_productID FOREIGN KEY (productID) REFERENCES product(productID),
	constraint orderline_FK_orderID FOREIGN KEY(orderID) REFERENCES customerOrder(orderID)
);



