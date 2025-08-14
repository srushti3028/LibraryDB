
/*
  task7.sql
  Task 7: Creating Views
  Author: Srushti Talule
  Description: Demonstrates creating and using SQL views in the LibraryDB database.
*/

USE LibraryDB;

-- 1. View: Borrow records with member and book details
CREATE OR REPLACE VIEW BorrowDetails AS
SELECT br.borrow_id, m.name AS member_name, b.title AS book_title, br.borrow_date, br.return_date
FROM Borrow_Records br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id;

-- Example usage:
-- SELECT * FROM BorrowDetails;

-- 2. View: Authors and their books
CREATE OR REPLACE VIEW AuthorBooks AS
SELECT a.name AS author_name, b.title AS book_title, b.genre
FROM Authors a
JOIN Book_Authors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.book_id = b.book_id;

-- Example usage:
-- SELECT * FROM AuthorBooks;

-- 3. View: Members who borrowed more than 1 book
CREATE OR REPLACE VIEW FrequentBorrowers AS
SELECT m.member_id, m.name, COUNT(br.borrow_id) AS borrow_count
FROM Members m
JOIN Borrow_Records br ON m.member_id = br.member_id
GROUP BY m.member_id, m.name
HAVING COUNT(br.borrow_id) > 1;

-- Example usage:
-- SELECT * FROM FrequentBorrowers;

-- 4. View: Member list without emails (for privacy)
CREATE OR REPLACE VIEW MembersNoEmail AS
SELECT member_id, name
FROM Members;

-- Example usage:
-- SELECT * FROM MembersNoEmail;

-- 5. View: Genres and total borrow count
CREATE OR REPLACE VIEW GenreBorrowStats AS
SELECT b.genre, COUNT(br.borrow_id) AS total_borrows
FROM Books b
LEFT JOIN Borrow_Records br ON b.book_id = br.book_id
GROUP BY b.genre;

-- Example usage:
-- SELECT * FROM GenreBorrowStats;

-- Dropping a view example:
-- DROP VIEW IF EXISTS BorrowDetails;
