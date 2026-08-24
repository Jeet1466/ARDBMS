CREATE TABLE ACCOUNT(
    AccountNO NUMBER Primary Key,
    CustomerName Varchar(50),
    AccountType Varchar(20),
    Balance NUMBER
);
CREATE TABLE TRANSACTION(
    TransactionID NUMBER Primary Key,
    AccountNO NUMBER References ACCOUNT(AccountNO),
    TransactionType Varchar(20),
    Amount NUMBER,
    TransactionDate Date
);