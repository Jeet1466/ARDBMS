SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE DISPLAY_MARKS AS
    CURSOR c_MARKS IS SELECT S.STUDENTID, S.STUDENTNAME, M.SUBJECTNAME, M.MARKS 
    FROM STUDENT S JOIN MARKS M ON S.StudentID = M.StudentID;

    v_REC c_MARKS%ROWTYPE;
    v_GRADE CHAR(2);
    v_Total_count NUMBER := 0;
BEGIN
    OPEN c_MARKS;
    LOOP
        FETCH c_MARKS INTO v_REC;
        EXIT WHEN c_MARKS%NOTFOUND;

        v_Total_count := v_Total_count + 1;

        IF v_REC.MARKS >= 90 THEN
            v_GRADE := 'A';
        ELSIF v_REC.MARKS >= 75 THEN
            v_GRADE := 'B';
        ELSIF v_REC.MARKS >= 60 THEN
            v_GRADE := 'C';
        ELSIF v_REC.MARKS >= 40 THEN
            v_GRADE := 'D';
        ELSIF v_REC.MARKS < 40 THEN
            v_GRADE := 'F';
        END IF;

        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_REC.STUDENTID || ', Name: ' || v_REC.STUDENTNAME || ', Subject: ' || v_REC.SUBJECTNAME || ', Marks: ' || v_REC.MARKS || ', Grade: ' || v_GRADE);
    END LOOP;

    CLOSE c_MARKS;
    DBMS_OUTPUT.PUT_LINE('Total Students Processed: ' || v_Total_count);
END;
/