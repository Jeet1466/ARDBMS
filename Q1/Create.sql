CREATE TABLE Student(
    StudentID Int Primary key,
    StudentName Varchar(50),
    Email Varchar(50),
    MobileNo Int,
    Course Varchar(50)
);
CREATE TABLE Subject(
    SubjectID Int Primary Key,
    SubjectName Varchar(20),
    Credits Int,
    Seats Int
);

Create table Registration(
    RegID Int Primary Key,
    StudentID Int,
    SubjectID Int,
    RegDate Date,
    Constraint fk_reg_Stud
        Foreign Key (StudentId)
        References Student(StudentId),
    Constraint fk_reg_Sub
        Foreign Key (SubjectID)
        References Subject(SubjectID)
);

Create table Fee(
    FeeID Int Primary Key,
    StudentID Int,
    Amount Int,
    PaidStatus Varchar(20),
    Constraint fk_fee_Stud
        Foreign Key (StudentId)
        References Student(StudentId)
);
    
CREATE TABLE Student_Audit(
    AuditID Int Primary KEY,
    ActionType VArchar(20),
    ActionDate Date
);

CREATE SEQUENCE Registration_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE Student_Audit_seq
START WITH 1
INCREMENT BY 1;