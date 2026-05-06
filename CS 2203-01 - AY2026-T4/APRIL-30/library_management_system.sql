CREATE DATABASE IF NOT EXISTS LibraryDB; 

USE LibraryDB; 

CREATE TABLE Books ( 

    ISBN        VARCHAR(20)   PRIMARY KEY,     -- Unique book identifier 
    Title       VARCHAR(200)  NOT NULL,        -- Book title 
    Author      VARCHAR(150)  NOT NULL,        -- Author's full name 
    Genre       VARCHAR(100),                  -- Genre category 
    Quantity    INT           DEFAULT 0        -- Available copies 

); 


CREATE TABLE Members ( 

    MemberID    INT           PRIMARY KEY AUTO_INCREMENT, -- Auto ID 
    Name        VARCHAR(150)  NOT NULL,        -- Member's full name 
    Email       VARCHAR(150)  UNIQUE NOT NULL, -- Unique email address 
    Phone       VARCHAR(20)                    -- Contact phone number 

); 

CREATE TABLE Loans ( 

    LoanID      INT           PRIMARY KEY AUTO_INCREMENT, -- Auto loan ID 
    MemberID    INT           NOT NULL,        -- FK to Members table 
    ISBN        VARCHAR(20)   NOT NULL,        -- FK to Books table 
    LoanDate    DATE          NOT NULL,        -- Date book was borrowed 
    ReturnDate  DATE,                          -- NULL until returned 
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID), 
    FOREIGN KEY (ISBN)     REFERENCES Books(ISBN) 

); 



INSERT INTO Books (ISBN, Title, Author, Genre, Quantity) VALUES 
    ('978-0-13-468599-1', 'Database System Concepts', 'Silberschatz et al.', 'Computer Science', 5),
    ('978-0-07-352332-3', 'Operating System Concepts', 'Silberschatz & Galvin', 'Computer Science', 3),
    ('978-0-13-235088-4', 'Introduction to Algorithms', 'Cormen et al.', 'Mathematics', 4),
    ('978-0-321-12521-7', 'The Pragmatic Programmer', 'Hunt & Thomas', 'Software Engineering', 6);

-
INSERT INTO Members (Name, Email, Phone) VALUES 
    ('Ahmed Hassan', 'ahmed.hassan@uopeople.edu', '+92-300-1234567'),
    ('Sara Malik', 'sara.malik@uopeople.edu', '+92-321-7654321'),
    ('John Carter', 'john.carter@uopeople.edu', '+1-555-0192');


INSERT INTO Loans (MemberID, ISBN, LoanDate, ReturnDate) VALUES 
    (1, '978-0-13-468599-1', '2026-04-10', '2026-04-24'),
    (2, '978-0-07-352332-3', '2026-04-15', NULL),
    (1, '978-0-13-235088-4', '2026-04-20', NULL),
    (3, '978-0-321-12521-7', '2026-04-22', '2026-05-01');


SELECT 
    m.Name        AS Member_Name,
    b.Title       AS Book_Title,
    b.Author      AS Author,
    b.Genre       AS Genre,
    l.LoanDate    AS Loan_Date,
    l.ReturnDate  AS Return_Date
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID    -- Link Loans to Members
JOIN Books   b ON l.ISBN     = b.ISBN        -- Link Loans to Books
WHERE l.MemberID = 1;                        -- Filter for Ahmed Hassan


UPDATE Books
SET    Quantity = 8
WHERE  ISBN = '978-0-13-468599-1';  -- Targets only this book

DELETE FROM Members
WHERE MemberID = 3;  -- Deletes only John Carter's record


-- Display all records in Books table (should show updated Quantity)
SELECT * FROM Books;

-- Display all records in Members table (John Carter should be removed)
SELECT * FROM Members;

-- Display all records in Loans table
SELECT * FROM Loans;

