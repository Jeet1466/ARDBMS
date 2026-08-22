CREATE OR REPLACE PROCEDURE PLACE_ORDER(
    p_CustomerID IN Int,
    p_ProductID IN Int,
    p_Quantity IN Int
)
IS
    v_CustomerID int;
    v_ProductID int;
    v_StockQTY int;
    Customer_Dont_Exists EXCEPTION;
    Product_Dont_Exists EXCEPTION;
    Insufficient_Stock EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_CustomerID FROM CUSTOMER WHERE CustomerID = p_CustomerID;
    SELECT COUNT(*) INTO v_ProductID FROM PRODUCT WHERE ProductID = p_ProductID;

    IF v_CustomerID = 0 THEN
        RAISE Customer_Dont_Exists;
    ELSIF v_ProductID = 0 THEN
        RAISE Product_Dont_Exists;
    ELSE
        SELECT StockQTY INTO v_StockQTY FROM PRODUCT WHERE ProductID = p_ProductID;
        IF v_StockQTY < p_Quantity THEN
            RAISE Insufficient_Stock;
        ELSE
            INSERT INTO ORDERS (OrderID, CustomerID, ProductID, Quantity, OrderDate)
            VALUES (Order_seq.NEXTVAL, p_CustomerID, p_ProductID, p_Quantity, SYSDATE);

            UPDATE PRODUCT SET StockQTY = StockQTY - p_Quantity WHERE ProductID = p_ProductID;

            DBMS_OUTPUT.PUT_LINE('Order placed successfully.');
        END IF;
    END IF;
EXCEPTION
    WHEN Customer_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Customer does not exist.');
    WHEN Product_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Product does not exist.');
    WHEN Insufficient_Stock THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient stock for the product.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/