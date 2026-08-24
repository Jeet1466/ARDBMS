SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION GET_BAL(p_AccountNO NUMBER) RETURN NUMBER IS
    v_Balance NUMBER;
    Account_not_found EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_Balance FROM ACCOUNT WHERE AccountNO = p_AccountNO;
    IF v_Balance = 0 THEN
        RAISE Account_not_found;
    ELSE
        SELECT Balance INTO v_Balance FROM ACCOUNT WHERE AccountNO = p_AccountNO;
        DBMS_OUTPUT.PUT_LINE('Balance for Account Number ' || p_AccountNO || ' is: ' || v_Balance);
        RETURN NULL;
    END IF;
EXCEPTION
    WHEN Account_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Account Number ' || p_AccountNO || ' not found.');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RETURN NULL;

END;
/