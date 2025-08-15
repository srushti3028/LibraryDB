
/*
  task8.sql
  Task 8: Stored Procedures and Functions
  Author: Srushti Talule
  Description: Demonstrates creating stored procedures and functions in the LibraryDB database.
*/

USE LibraryDB;

-- 1. Stored Procedure: Get borrow history for a given member
DELIMITER //
CREATE PROCEDURE GetBorrowHistoryByMember(IN memberId INT)
BEGIN
    SELECT br.borrow_id, b.title AS book_title, br.borrow_date, br.return_date
    FROM Borrow_Records br
    JOIN Books b ON br.book_id = b.book_id
    WHERE br.member_id = memberId;
END //
DELIMITER ;

-- Example usage:
-- CALL GetBorrowHistoryByMember(1);

-- 2. Stored Function: Get total number of borrows for a given member
DELIMITER //
CREATE FUNCTION GetTotalBorrowsByMember(memberId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalBorrows INT;
    SELECT COUNT(*) INTO totalBorrows
    FROM Borrow_Records
    WHERE member_id = memberId;
    RETURN totalBorrows;
END //
DELIMITER ;

-- Example usage:
-- SELECT GetTotalBorrowsByMember(1) AS total_borrows;

-- 3. Stored Procedure: Add a new member (demonstrates INSERT via procedure)
DELIMITER //
CREATE PROCEDURE AddNewMember(IN memberName VARCHAR(100), IN memberEmail VARCHAR(100))
BEGIN
    INSERT INTO Members (name, email) VALUES (memberName, memberEmail);
END //
DELIMITER ;

-- Example usage:
-- CALL AddNewMember('John Doe', 'john@example.com');

-- 4. Stored Procedure with conditional logic: Mark a book as returned
DELIMITER //
CREATE PROCEDURE MarkBookAsReturned(IN borrowId INT)
BEGIN
    IF EXISTS (SELECT 1 FROM Borrow_Records WHERE borrow_id = borrowId AND return_date IS NULL) THEN
        UPDATE Borrow_Records
        SET return_date = CURDATE()
        WHERE borrow_id = borrowId;
    ELSE
        SELECT 'Book is already returned or borrow ID not found' AS message;
    END IF;
END //
DELIMITER ;

-- Example usage:
-- CALL MarkBookAsReturned(3);
