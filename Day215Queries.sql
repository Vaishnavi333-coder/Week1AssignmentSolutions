-- DDL Operations (Creating Tables with Constraints)

-- Create Authors table
CREATE TABLE Authors (
    Author_ID NUMBER PRIMARY KEY,
    Author_Name VARCHAR2(100) NOT NULL
);

-- Create Books table
CREATE TABLE Books (
    Book_ID NUMBER PRIMARY KEY,
    Title VARCHAR2(200) NOT NULL,
    Author_ID NUMBER NOT NULL,
    ISBN VARCHAR2(13) UNIQUE NOT NULL,
    Publication_Year NUMBER(4) CHECK (Publication_Year > 1900),
    Available_Copies NUMBER DEFAULT 1 CHECK (Available_Copies >= 0),
    CONSTRAINT fk_author FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID) ON DELETE CASCADE
);

-- Create Members table
CREATE TABLE Members (
    Member_ID NUMBER PRIMARY KEY,
    Member_Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(200),
    Phone VARCHAR2(15) UNIQUE,
    Membership_Date DATE DEFAULT SYSDATE
);

-- Create Borrowings table
CREATE TABLE Borrowings (
    Borrowing_ID NUMBER PRIMARY KEY,
    Book_ID NUMBER NOT NULL,
    Member_ID NUMBER NOT NULL,
    Borrow_Date DATE DEFAULT SYSDATE,
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    Fine NUMBER(10,2) DEFAULT 0 CHECK (Fine >= 0),
    CONSTRAINT fk_book FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID) ON DELETE CASCADE,
    CONSTRAINT fk_member FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE,
    CONSTRAINT chk_due_date CHECK (Due_Date > Borrow_Date)
);

-- DML Operations (Insert, Update, Delete)

-- INSERT examples
INSERT INTO Authors (Author_ID, Author_Name) VALUES (1, 'J.K. Rowling');
INSERT INTO Authors (Author_ID, Author_Name) VALUES (2, 'J.R.R. Tolkien');

INSERT INTO Books (Book_ID, Title, Author_ID, ISBN, Publication_Year, Available_Copies)
VALUES (1, 'Harry Potter and the Sorcerer''s Stone', 1, '9780747532743', 1997, 5);
INSERT INTO Books (Book_ID, Title, Author_ID, ISBN, Publication_Year, Available_Copies)
VALUES (2, 'The Hobbit', 2, '9780261103344', 1937, 3);

INSERT INTO Members (Member_ID, Member_Name, Address, Phone)
VALUES (1, 'John Doe', '123 Main St, City', '123-456-7890');
INSERT INTO Members (Member_ID, Member_Name, Address, Phone)
VALUES (2, 'Jane Smith', '456 Elm St, Town', '987-654-3210');

INSERT INTO Borrowings (Borrowing_ID, Book_ID, Member_ID, Due_Date)
VALUES (1, 1, 1, SYSDATE + 14);
--------------------------------------------------------------------------------------------------------------------------------------------------------------
1)List books with exactly one available copy
SELECT Book_ID,Title,Available_Copies FROM Books WHERE Available_Copies=1;

2)List authors whose number start with a specific letter(EG:J)
SELECT Author_Name,Author_ID FROM Authors WHERE Author_Name LIKE '%J';

3)List members with no address recorded
SELECT Member_Name,Address FROM Members WHERE Address IS NULL;

4)List borrowings with a specific borrow date
SELECT Borrowing_ID,Borrow_Date,Member_ID,Book_ID FROM Borrowings WHERE Borrow_Date=TO_DATE('2025-10-01','YYYY-MM-DD');

5)List books with a publication year after 2000
SELECT Book_ID,Title,Publication_Year FROM Books WHERE Publication_Year>2000;

6)List borrowing with no fines
SELECT Borrowing_ID,Member_ID,Fine FROM Borrowings WHERE Fine=0;

7)List members sorted by membership date in descending order
SELECT Member_ID,Member_Name,Member_Shipdate FROM Members ORDER BY Member_Shipdate DESC;

8)Count the total No.of authors
SELECT COUNT(*) AS TOTALAUTHORS FROM Authors;

9)List books with titles containing a specific word (Eg:'Potter')
SELECT Book_ID,Title FROM Books WHERE Title LIKE '%Potter%';

10)List borrowings returned on a specific date
SELECT Borrowing_ID,Book_ID,Return_Date,Member_ID FROM Borrowings WHERE Return_Date=TO_DATE('2025-10-05','YYYY-MM-DD');

11)List members with a specific area code in their phone NO.(Eg:'111')
SELECT Member_ID,Member_Name,Phone FROM Members WHERE Phone LIKE '111%';

12)List books sorted by title alphabetically
SELECT Book_ID,Title FROM Books ORDER BY Title ASC;

13)Sum  the total available copies across all books
SELECT Sum(Available_Copies) AS TOTALAVAILABLE FROM Books;

14)List borrowings with a due date in a specific month
SELECT Borrowing_ID,Book_ID,Member_ID,Due_Date FROM Borrowings WHERE TO_CHAR(Due_Date,'YYYY-MM')='2025-10';

15)List authors with longer than 10 characters
SELECT Author_ID,Author_Name FROM Authors WHERE LENGTH(Author_Name)>10;
  
