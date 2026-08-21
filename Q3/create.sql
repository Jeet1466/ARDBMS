CREATE TABLE PATIENT(
    PatientID Int Primary Key,
    PatientName Varchar(50),
    MobileNo Int,
    City Varchar(50)
);
CREATE TABLE DOCTOR(
    DoctorID Int Primary Key,
    DoctorName Varchar(50),
    Specialization Varchar(50),
    AvailableSlots Int
);
CREATE TABLE APPOINTMENT(
    AppointmentID Int Primary Key,
    PatientID Int,
    DoctorID Int,
    AppointmentDate Date,
    Constraint fk_appointment_Patient
        Foreign Key (PatientId)
        References Patient(PatientId),
    Constraint fk_appointment_Doctor
        Foreign Key (DoctorID)
        References Doctor(DoctorID)
);
CREATE SEQUENCE Appointment_seq
START WITH 1
INCREMENT BY 1;

