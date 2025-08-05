
/*
  task2.sql
  Task 2: Data Insertion and Handling Nulls
  Author: Srushti Talule
  Description: Demonstrates data insertion, updates, deletions, and NULL handling using SQL DML commands.
*/

USE LibraryDB;

-- 1. INSERT statements
-- Inserting full data
INSERT INTO Authors (name) VALUES ('Agatha Christie'), ('Mark Twain');

-- Inserting with partial values (genre is optional)
INSERT INTO Books (title, publication_year) VALUES 
    ('Murder on the Orient Express', 1934), 
    ('The Adventures of Tom Sawyer', 1876);

-- Inserting NULL explicitly
INSERT INTO Members (name, email) VALUES 
    ('Charlie Puth', NULL),
    ('Emily Watson', 'emily@example.com');

-- Inserting full Borrow_Records
INSERT INTO Borrow_Records (member_id, book_id, borrow_date, return_date) VALUES 
    (3, 3, '2025-08-01', NULL),
    (4, 4, '2025-08-02', NULL);

-- 2. UPDATE statements
-- Update missing emails
UPDATE Members
SET email = 'charlie@example.com'
WHERE name = 'Charlie Puth';

-- Update return date for a borrow record
UPDATE Borrow_Records
SET return_date = '2025-08-10'
WHERE borrow_id = 3;

-- 3. DELETE statements
-- Delete a member who hasn’t borrowed any book
DELETE FROM Members
WHERE member_id = 5;

-- Delete a book (this will also delete from Book_Authors and Borrow_Records due to ON DELETE CASCADE)
DELETE FROM Books
WHERE book_id = 2;

-- 4. Handling NULLs
-- Select members with no email
SELECT * FROM Members WHERE email IS NULL;

-- 5. Inserting values into specific columns only
INSERT INTO Authors (name) VALUES ('Stephen King');

-- 6. Insert using SELECT (example: copying authors to a temp table)
CREATE TEMPORARY TABLE TempAuthors AS
SELECT * FROM Authors;

-- 7. Demonstrating NOT NULL error (commented out to avoid script failure)
-- INSERT INTO Members (name) VALUES ('NoEmailUser'); -- email is NOT NULL

-- 8. Demonstrating rollback (only works in transaction, not shown here due to DDL mode)

