CREATE TABLE CUSTOMER(
    CustomerID Int Primary Key,
    CustomerName Varchar(50),
    MobileNo Int,
    City Varchar(50)
);
CREATE TABLE PRODUCT(
    ProductID Int Primary Key,
    ProductName Varchar(50),
    Price Int,
    StockQTY Int
);
CREATE TABLE ORDERS(
    OrderID Int Primary Key,
    CustomerID Int References CUSTOMER(CustomerID),
    ProductID Int References PRODUCT(ProductID),
    Quantity Int,
    OrderDate Date
   
);
CREATE TABLE PAYMENT(
    PaymentID Int Primary Key,
    OrderID Int References ORDERS(OrderID),
    Amount Int,
    PaymentStatus Varchar(20),
    Status Varchar(20)
);
CREATE SEQUENCE Order_seq
START WITH 1
INCREMENT BY 1;