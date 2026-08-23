CREATE TABLE MARKS(
    MarksID Number Primary Key,
    StudentID Number References STUDENT(StudentID),
    SubjectName VARCHAR(20),
    Marks Number
);

