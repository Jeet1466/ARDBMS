SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE REGISTER_STUDENT(
    p_StudentID IN Int,
    p_SubjectID IN Int
)
IS
    v_studentID 
    int;
    v_subjectID int;
    V_COUNT int;
    v_seats int;
    Student_Dont_Exists EXCEPTION;
    Subject_Dont_Exists EXCEPTION;
    Student_Already_Registered EXCEPTION;
    Seats_Not_Available EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_studentID FROM Student WHERE StudentID = p_StudentID;
    SELECT COUNT(*) INTO v_subjectID FROM Subject WHERE SubjectID = p_SubjectID;
    SELECT COUNT(*)INTO v_count FROM Registration WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;

    IF v_studentID = 0 THEN
        RAISE Student_Dont_Exists;
    ELSIF v_subjectID = 0 THEN
        RAISE Subject_Dont_Exists;
    ELSIF v_count > 0 THEN
        RAISE Student_Already_Registered;
    ELSE
        SELECT Seats INTO v_seats FROM Subject WHERE SubjectID = p_SubjectID;
        IF v_seats <= 0 THEN
            RAISE Seats_Not_Available;
        ELSE

            INSERT INTO Registration (RegID, StudentID, SubjectID, RegDate)
            VALUES (Registration_seq.NEXTVAL, p_StudentID, p_SubjectID, SYSDATE);

            UPDATE Subject SET Seats = Seats - 1 WHERE SubjectID = p_SubjectID;

            INSERT INTO Student_Audit (AuditID, ActionType, ActionDate)
            VALUES (Student_Audit_seq.NEXTVAL, 'REGISTER', SYSDATE);

            DBMS_OUTPUT.PUT_LINE('Student registered successfully.');
        END IF;
    END IF;

EXCEPTION
    WHEN Student_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Student does not exist.');
    WHEN Subject_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Subject does not exist.');
    WHEN Student_Already_Registered THEN
        DBMS_OUTPUT.PUT_LINE('Student is already registered for this subject.');
    WHEN Seats_Not_Available THEN
        DBMS_OUTPUT.PUT_LINE('No available seats for the subject.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    
END;
/