CREATE TABLE E_CUSTOMER(
    CustomerID NUMBER Primary Key,
    CustomerName Varchar(50),
    METERNO NUMBER,
    City Varchar(50)
);
CREATE TABLE E_BILL(
    BillID NUMBER Primary Key,
    CustomerID NUMBER References E_CUSTOMER(CustomerID),
    UNITS NUMBER,
    BillAmount NUMBER,
    BillDate Date,
    PAIDSTATUS Varchar(20)
);
CREATE SEQUENCE BILL_SEQ START WITH 1 INCREMENT BY 1;