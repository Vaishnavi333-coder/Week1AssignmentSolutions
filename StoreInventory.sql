-- Create Products Table
CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(150) NOT NULL,
    Category VARCHAR2(60) NOT NULL,
    Price NUMBER(10,2) CHECK (Price > 0),
    StockQuantity NUMBER DEFAULT 0 CHECK (StockQuantity >= 0)
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(60) NOT NULL,
    LastName VARCHAR2(60) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(20)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    OrderDate DATE DEFAULT SYSDATE,
    TotalAmount NUMBER(10,2) DEFAULT 0 CHECK (TotalAmount >= 0),
    constraint FK_Orders Foreign KEY(CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID NUMBER PRIMARY KEY,
    OrderID NUMBER NOT NULL,
    ProductID NUMBER NOT NULL,
    Quantity NUMBER CHECK (Quantity > 0),
    constraint FK_OrderDetails FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    constraint FK_OrderDetails FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES ('Laptop', 'Electronics', 76000, 50);
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES ('Headphones', 'Accessories', 25000, 15);

-- Insert Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES ('Aarav', 'sharma', 'aarav.sharma@example.com', '9876543210');
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES ('Divya', 'Patel', 'divya.patel@example.com', '9988776655');

-- Insert Orders
INSERT INTO Orders (CustomerID, TotalAmount)
VALUES (1, 77500);
INSERT INTO Orders (CustomerID, TotalAmount)
VALUES (2, 5000);

-- Insert OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES (1, 1, 1);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES (2, 2, 2);
