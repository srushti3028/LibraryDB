
/*
  task6.sql
  Task 6: Subqueries and Nested Queries
  Author: Srushti Talule
  Description: Demonstrates various types of subqueries (scalar, correlated, IN, EXISTS, FROM) using LibraryDB tables.
*/

USE LibraryDB;

-- 1. Scalar subquery: Find the book with the latest publication year
SELECT title, publication_year
FROM Books
WHERE publication_year = (SELECT MAX(publication_year) FROM Books);

-- 2. Subquery with IN: Members who borrowed books in the 'Fantasy' genre
SELECT name
FROM Members
WHERE member_id IN (
    SELECT DISTINCT br.member_id
    FROM Borrow_Records br
    JOIN Books b ON br.book_id = b.book_id
    WHERE b.genre = 'Fantasy'
);

-- 3. Subquery with EXISTS: Authors who have written at least one book
SELECT name
FROM Authors a
WHERE EXISTS (
    SELECT 1 FROM Book_Authors ba
    WHERE ba.author_id = a.author_id
);

-- 4. Correlated subquery: Members who borrowed more than 1 book
SELECT m.name
FROM Members m
WHERE (SELECT COUNT(*) FROM Borrow_Records br WHERE br.member_id = m.member_id) > 1;

-- 5. Subquery in FROM (Derived Table): Average publication year per genre
SELECT genre, avg_pub_year
FROM (
    SELECT genre, ROUND(AVG(publication_year), 2) AS avg_pub_year
    FROM Books
    GROUP BY genre
) AS GenreAverages;

-- 6. Subquery with = : Book(s) borrowed earliest
SELECT title
FROM Books
WHERE book_id IN (
    SELECT book_id FROM Borrow_Records
    WHERE borrow_date = (SELECT MIN(borrow_date) FROM Borrow_Records)
);

-- 7. Correlated subquery: Members who borrowed books in more than 1 genre
SELECT m.name
FROM Members m
WHERE (
    SELECT COUNT(DISTINCT b.genre)
    FROM Borrow_Records br
    JOIN Books b ON br.book_id = b.book_id
    WHERE br.member_id = m.member_id
) > 1;

-- 8. Subquery with NOT IN: Books never borrowed
SELECT title
FROM Books
WHERE book_id NOT IN (SELECT DISTINCT book_id FROM Borrow_Records);
