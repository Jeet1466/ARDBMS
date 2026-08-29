SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE BOOK_ISSUED(
    p_MemberID NUMBER
) IS
    CURSOR ISSUED_BOOK IS SELECT 
    M.MemberName, M.Email, B.BookTitle, B.Author, I.IssueDate, I.ReturnDate
    FROM ISSUE I   
    JOIN MEMBER M ON I.MemberID = M.MemberID
    JOIN BOOK B ON I.BookID = B.BookID
    WHERE M.MemberID = p_MemberID;
    v_REC ISSUED_BOOK%ROWTYPE;
    v_Returned_Count NUMBER := 0;
    v_Not_Returned_Count NUMBER := 0;
    v_Total_Count NUMBER := 0;
BEGIN
    
    FOR v_REC IN ISSUED_BOOK LOOP
        IF v_REC.ReturnDate IS NOT NULL THEN
            v_Returned_Count := v_Returned_Count + 1;
        ELSE
            v_Not_Returned_Count := v_Not_Returned_Count + 1;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Member Name: ' || v_REC.MemberName );
        DBMS_OUTPUT.PUT_LINE('Email : '|| v_REC.Email);
        DBMS_OUTPUT.PUT_LINE('Book Title : '||v_REC.BookTitle);
        DBMS_OUTPUT.PUT_LINE('Author : '||v_REC.Author);
        DBMS_OUTPUT.PUT_LINE('Issue Date : '||v_REC.IssueDate);
        DBMS_OUTPUT.PUT_LINE('Return Date : '||v_REC.ReturnDate);
        DBMS_OUTPUT.PUT_LINE('____________________________________________');
        
    END LOOP;
    v_Total_Count := v_Returned_Count + v_Not_Returned_Count;
    DBMS_OUTPUT.PUT_LINE('Total Books Issued to Member ID ' || p_MemberID || ': ' || v_Total_Count);
    DBMS_OUTPUT.PUT_LINE('Total Books Returned by Member ID ' || p_MemberID || ': ' || v_Returned_Count);
    DBMS_OUTPUT.PUT_LINE('Total Books Not Returned by Member ID ' || p_MemberID || ': ' ||v_Not_Returned_Count);
    
END;
/