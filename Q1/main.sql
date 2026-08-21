SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE REGISTER_STUDENT(
    p_StudentID IN Int,
    p_SubjectID IN Int
)
IS
    v_studentID int;
    v_subjectID int;
    V_COUNT int;
    v_seats int;
BEGIN
    SELECT StudentID INTO v_studentID FROM Student WHERE StudentID = p_StudentID;
    SELECT SubjectID, Seats INTO v_subjectID, v_seats FROM Subject WHERE SubjectID = p_SubjectID;
    SELECT COUNT(*)INTO v_count FROM Registration WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;

    IF v_studentID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Student does not exist.');
    ELSIF v_subjectID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Subject does not exist.');
    ELSIF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Student is already registered for this subject.'); 
    ELSIF v_seats <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'No seats available for the subject.');
    ELSE
        INSERT INTO Registration (RegID, StudentID, SubjectID, RegDate)
        VALUES (Registration_seq.NEXTVAL, p_StudentID, p_SubjectID, SYSDATE);

        UPDATE Subject SET Seats = Seats - 1 WHERE SubjectID = p_SubjectID;

        INSERT INTO Student_Audit (AuditID, ActionType, ActionDate)
        VALUES (Student_Audit_seq.NEXTVAL, 'REGISTER', SYSDATE);
    END IF;
END;
/