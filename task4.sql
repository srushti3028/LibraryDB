
/*
  task4.sql
  Task 4: Aggregate Functions and Grouping
  Author: Srushti Talule
  Description: Demonstrates aggregate functions (SUM, COUNT, AVG) with GROUP BY and HAVING in the LibraryDB.
*/

USE LibraryDB;

-- 1. Count total number of books
SELECT COUNT(*) AS total_books FROM Books;

-- 2. Count books per genre
SELECT genre, COUNT(*) AS books_count
FROM Books
GROUP BY genre;

-- 3. Average publication year per genre
SELECT genre, ROUND(AVG(publication_year), 2) AS avg_pub_year
FROM Books
GROUP BY genre;

-- 4. Count books per author
SELECT a.name AS author_name, COUNT(ba.book_id) AS total_books
FROM Authors a
JOIN Book_Authors ba ON a.author_id = ba.author_id
GROUP BY a.name;

-- 5. Count borrows per member
SELECT m.name AS member_name, COUNT(br.borrow_id) AS total_borrows
FROM Members m
LEFT JOIN Borrow_Records br ON m.member_id = br.member_id
GROUP BY m.name;

-- 6. Count borrows per member, only for members who borrowed more than 1 book
SELECT m.name AS member_name, COUNT(br.borrow_id) AS total_borrows
FROM Members m
LEFT JOIN Borrow_Records br ON m.member_id = br.member_id
GROUP BY m.name
HAVING COUNT(br.borrow_id) > 1;

-- 7. Latest borrow date per member
SELECT m.name AS member_name, MAX(br.borrow_date) AS latest_borrow
FROM Members m
LEFT JOIN Borrow_Records br ON m.member_id = br.member_id
GROUP BY m.name;

-- 8. Number of distinct genres borrowed by each member
SELECT m.name AS member_name, COUNT(DISTINCT b.genre) AS distinct_genres
FROM Members m
JOIN Borrow_Records br ON m.member_id = br.member_id
JOIN Books b ON br.book_id = b.book_id
GROUP BY m.name;

-- 9. Total borrows per genre
SELECT b.genre, COUNT(*) AS total_borrows
FROM Borrow_Records br
JOIN Books b ON br.book_id = b.book_id
GROUP BY b.genre;

-- 10. Members who borrowed books in more than 1 genre
SELECT m.name AS member_name, COUNT(DISTINCT b.genre) AS distinct_genres
FROM Members m
JOIN Borrow_Records br ON m.member_id = br.member_id
JOIN Books b ON br.book_id = b.book_id
GROUP BY m.name
HAVING COUNT(DISTINCT b.genre) > 1;
