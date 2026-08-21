SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE SCHEDULE_APPOINTMENT(
    p_PatientID IN Int,
    p_DoctorID IN Int
)
IS
    v_PatientID int;
    v_DoctorID int;
    v_AvailableSlots int;
BEGIN
    SELECT PatientID INTO v_PatientID FROM Patient WHERE PatientID = p_PatientID;
    SELECT DoctorID, AvailableSlots INTO v_DoctorID, v_AvailableSlots FROM Doctor WHERE DoctorID = p_DoctorID;

    IF v_PatientID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Patient does not exist.');
    ELSIF v_DoctorID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Doctor does not exist.');
    ELSIF v_AvailableSlots <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'No available slots for the doctor.');
    ELSE
        INSERT INTO Appointment (AppointmentID, PatientID, DoctorID, AppointmentDate)
        VALUES (Appointment_seq.NEXTVAL, p_PatientID, p_DoctorID, SYSDATE);

        UPDATE Doctor SET AvailableSlots = AvailableSlots - 1 WHERE DoctorID = p_DoctorID;
    END IF; 
END;
/