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
    PatientID Int References PATIENT(PatientID),
    DoctorID Int References DOCTOR(DoctorID),
    AppointmentDate Date
   
);
CREATE SEQUENCE Appointment_seq
START WITH 1
INCREMENT BY 1;

