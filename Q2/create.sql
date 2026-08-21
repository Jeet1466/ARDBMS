CREATE TABLE Employee(
    EmpID Int Primary Key,
    EmpName Varchar(50),
    Department Varchar(50),
    Salary Int,
    JoinDate Date
); 
CREATE TABLE Salary_payment(
    PaymentID Int Primary Key,
    EmpID Int,
    PaymentDate Date,
    Amount Int,
    Status Varchar(20),
    Constraint fk_payment_Emp
        Foreign Key (EmpID)
        References Employee(EmpID)
);
CREATE TABLE Emp_Audit(
    AuditID Int Primary KEY,
    ActionType VArchar(20),
    ActionDate Date
);

CREATE SEQUENCE Salary_payment_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE Emp_Audit_seq
START WITH 1
INCREMENT BY 1;