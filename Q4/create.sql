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
    CustomerID Int,
    ProductID Int,
    Quantity Int,
    OrderDate Date,
    Constraint fk_order_Customer
        Foreign Key (CustomerId)
        References CUSTOMER(CustomerId),
    Constraint fk_order_Product
        Foreign Key (ProductID)
        References PRODUCT(ProductID)
);
CREATE TABLE PAYMENT(
    PaymentID Int Primary Key,
    OrderID Int,
    Amount Int,
    PaymentStatus Varchar(20),
    Status Varchar(20),
    Constraint fk_payment_Order
        Foreign Key (OrderID)
        References ORDERS(OrderID)
);
CREATE SEQUENCE Order_seq
START WITH 1
INCREMENT BY 1;