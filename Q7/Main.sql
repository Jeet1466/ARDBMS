SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE BILL(
    p_CustomerID NUMBER,
    p_UNITS NUMBER
)
IS
    v_Customer NUMBER;
    v_BillAmount NUMBER;
    v_BillDate DATE := SYSDATE;
    Coustomer_not_found EXCEPTION;
    Invaild_units EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_Customer FROM E_CUSTOMER WHERE CustomerID = p_CustomerID;
    IF v_Customer = 0 THEN
        RAISE Coustomer_not_found;
    ELSIF p_UNITS < 0 THEN
        RAISE Invaild_units;
    ELSE
        IF p_UNITS <= 100 THEN
            v_BillAmount := p_UNITS * 2;
        ELSIF p_UNITS <= 200 THEN
            v_BillAmount := (100 * 2) + ((p_UNITS - 100) * 3);
        ELSE
            v_BillAmount := (100 * 2) + (100 * 3) + ((p_UNITS - 200) * 5);
        END IF;

        INSERT INTO E_BILL (BillID, CustomerID, UNITS, BillAmount, BillDate, PAIDSTATUS)
        VALUES (BILL_SEQ.NEXTVAL, p_CustomerID, p_UNITS, v_BillAmount, v_BillDate, 'UNPAID');
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Bill generated successfully for Customer ID: ' || p_CustomerID);
    END IF;
EXCEPTION
    WHEN Coustomer_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_CustomerID || ' not found.');
    WHEN Invaild_units THEN
        DBMS_OUTPUT.PUT_LINE('Invalid units: ' || p_UNITS || '. Units must be non-negative.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/