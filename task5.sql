
/*
  task5.sql
  Task 5: SQL Joins (Inner, Left, Right, Full)
  Author: Srushti Talule
  Description: Demonstrates various types of SQL joins using LibraryDB tables.
*/

USE LibraryDB;

-- 1. INNER JOIN: List borrow records with member and book details
SELECT br.borrow_id, m.name AS member_name, b.title AS book_title, br.borrow_date, br.return_date
FROM Borrow_Records br
INNER JOIN Members m ON br.member_id = m.member_id
INNER JOIN Books b ON br.book_id = b.book_id;

-- 2. LEFT JOIN: List all members and their borrow records (if any)
SELECT m.name AS member_name, br.borrow_id, b.title AS book_title
FROM Members m
LEFT JOIN Borrow_Records br ON m.member_id = br.member_id
LEFT JOIN Books b ON br.book_id = b.book_id;

-- 3. RIGHT JOIN: List all books and who borrowed them (if any)
SELECT b.title AS book_title, m.name AS member_name, br.borrow_date
FROM Borrow_Records br
RIGHT JOIN Books b ON br.book_id = b.book_id
RIGHT JOIN Members m ON br.member_id = m.member_id;

-- 4. FULL OUTER JOIN: All members and all books, with borrow info if exists
-- MySQL doesn't support FULL OUTER JOIN directly, so we use UNION
SELECT m.name AS member_name, b.title AS book_title, br.borrow_date
FROM Members m
LEFT JOIN Borrow_Records br ON m.member_id = br.member_id
LEFT JOIN Books b ON br.book_id = b.book_id
UNION
SELECT m.name AS member_name, b.title AS book_title, br.borrow_date
FROM Members m
RIGHT JOIN Borrow_Records br ON m.member_id = br.member_id
RIGHT JOIN Books b ON br.book_id = b.book_id;

-- 5. Multi-table join: Authors and books they wrote, along with borrow records
SELECT a.name AS author_name, b.title AS book_title, m.name AS borrowed_by
FROM Authors a
JOIN Book_Authors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.book_id = b.book_id
LEFT JOIN Borrow_Records br ON b.book_id = br.book_id
LEFT JOIN Members m ON br.member_id = m.member_id;

-- 6. Self-join example: Compare members with same first letter in their name
SELECT m1.name AS member1, m2.name AS member2
FROM Members m1
JOIN Members m2 ON LEFT(m1.name, 1) = LEFT(m2.name, 1)
WHERE m1.member_id < m2.member_id;
