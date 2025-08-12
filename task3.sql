
/*
  task3.sql
  Task 3: Writing Basic SELECT Queries
  Author: Srushti Talule
  Description: Demonstrates retrieving data from the LibraryDB using SELECT, WHERE, ORDER BY, and LIMIT.
*/

USE LibraryDB;

-- 1. Select all columns from Authors
SELECT * FROM Authors;

-- 2. Select specific columns from Books
SELECT title, genre FROM Books;

-- 3. Filter with WHERE: Books published after 1950
SELECT * FROM Books
WHERE publication_year > 1950;

-- 4. Using AND: Books published after 1950 AND genre is 'Fantasy'
SELECT * FROM Books
WHERE publication_year > 1950 AND genre = 'Fantasy';

-- 5. Using OR: Books in Fantasy OR Dystopian genre
SELECT * FROM Books
WHERE genre = 'Fantasy' OR genre = 'Dystopian';

-- 6. Using LIKE: Find members whose name starts with 'A'
SELECT * FROM Members
WHERE name LIKE 'A%';

-- 7. Using BETWEEN: Find books published between 1900 and 2000
SELECT * FROM Books
WHERE publication_year BETWEEN 1900 AND 2000;

-- 8. Sorting: List members by name in ascending order
SELECT * FROM Members
ORDER BY name ASC;

-- 9. Sorting in descending order: Books by publication year
SELECT * FROM Books
ORDER BY publication_year DESC;

-- 10. Limit output: First 3 borrow records
SELECT * FROM Borrow_Records
LIMIT 3;

-- 11. Aliasing: Display book title as 'Book Name'
SELECT title AS 'Book Name', genre AS 'Category'
FROM Books;

-- 12. Distinct: List unique genres
SELECT DISTINCT genre FROM Books;
