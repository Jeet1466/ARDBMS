SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE PAY_SALARY(
    p_EmpID IN Int,
    p_Bonus IN Int
)
IS
    v_EmpID int;
    v_Salary int;
    v_PaymentDate date;
BEGIN
    SELECT EmpID, Salary INTO v_EmpID, v_Salary FROM Employee WHERE EmpID = p_EmpID;

    IF v_EmpID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Employee does not exist.');
    ELSE
        INSERT INTO Salary_payment (PaymentID, EmpID, PaymentDate, Amount, Status)
        VALUES (Salary_payment_seq.NEXTVAL, p_EmpID, SYSDATE, v_Salary + p_Bonus, 'PAID');

        INSERT INTO Emp_Audit (AuditID, ActionType, ActionDate)
        VALUES (Emp_Audit_seq.NEXTVAL, 'SALARY_PAID', SYSDATE);
    END IF;
END;
/