CREATE TABLE MEMBER(
    MemberID NUMBER Primary Key,
    MemberName Varchar(50),
    Email Varchar(50),
    MobileNo NUMBER
);
CREATE TABLE BOOK(
    BookID NUMBER Primary Key,
    BookTitle Varchar(50),
    Author Varchar(50),
    Category Varchar(50)
);
CREATE TABLE ISSUE(
    IssueID NUMBER Primary Key,
    MemberID NUMBER References MEMBER(MemberID),
    BookID NUMBER References BOOK(BookID),
    IssueDate Date,
    ReturnDate Date
);
