SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE PAY_SALARY(
    p_EmpID IN Int,
    p_Bonus IN Int
)
IS
    v_EmpID int;
    v_Salary int;
    v_PaymentDate date;
    Employee_Dont_Exists EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_EmpID FROM Employee WHERE EmpID = p_EmpID;

    IF v_EmpID = 0 THEN
        RAISE Employee_Dont_Exists;
    ELSE
        SELECT SALARY INTO v_Salary FROM Employee WHERE EmpID = p_EmpID;
        INSERT INTO Salary_payment (PaymentID, EmpID, PaymentDate, Amount, Status)
        VALUES (Salary_payment_seq.NEXTVAL, p_EmpID, SYSDATE, v_Salary + p_Bonus, 'PAID');

        INSERT INTO Emp_Audit (AuditID, ActionType, ActionDate)
        VALUES (Emp_Audit_seq.NEXTVAL, 'SALARY_PAID', SYSDATE);
    END IF;
    EXCEPTION
    WHEN Employee_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Employee does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/