SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE SCHEDULE_APPOINTMENT(
    p_PatientID IN Int,
    p_DoctorID IN Int
)
IS
    v_PatientID int;
    v_DoctorID int;
    v_AvailableSlots int;
    Patient_Dont_Exists EXCEPTION;
    Doctor_Dont_Exists EXCEPTION;
    No_Slots_Available EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_PatientID FROM Patient WHERE PatientID = p_PatientID;
    SELECT COUNT(*) INTO v_DoctorID FROM Doctor WHERE DoctorID = p_DoctorID;

    IF v_PatientID = 0 THEN
        RAISE Patient_Dont_Exists;
    ELSIF v_DoctorID = 0 THEN
        RAISE Doctor_Dont_Exists;
    ELSE
        SELECT AvailableSlots INTO v_AvailableSlots FROM Doctor WHERE DoctorID = p_DoctorID;
        IF v_AvailableSlots <= 0 THEN
            RAISE No_Slots_Available;
        ELSE
            INSERT INTO Appointment (AppointmentID, PatientID, DoctorID, AppointmentDate)
            VALUES (Appointment_seq.NEXTVAL, p_PatientID, p_DoctorID, SYSDATE);

            UPDATE Doctor SET AvailableSlots = AvailableSlots - 1 WHERE DoctorID = p_DoctorID;
            DBMS_OUTPUT.PUT_LINE('Appointment scheduled successfully.');
        END IF;
    END IF;
EXCEPTION
    WHEN Patient_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Patient does not exist.');
    WHEN Doctor_Dont_Exists THEN
        DBMS_OUTPUT.PUT_LINE('Doctor does not exist.');
    WHEN No_Slots_Available THEN
        DBMS_OUTPUT.PUT_LINE('No available slots for the doctor.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM); 
END;
/