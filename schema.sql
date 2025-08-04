
/*
  schema.sql
  Library Management System - SQL Schema
  Author: Srushti Talule
  Date: 2025-08-04
  Description: Defines the database structure for managing books, authors, members, and borrow records.
*/

-- 1. Drop and Create Database
DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 2. Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 3. Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    publication_year INT,
    genre VARCHAR(50)
);

-- 4. Book_Authors Table (Many-to-Many)
CREATE TABLE Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- 5. Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 6. Borrow_Records Table (One-to-Many)
CREATE TABLE Borrow_Records (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- 7. Index for faster queries
CREATE INDEX idx_borrow_date ON Borrow_Records(borrow_date);

-- 8. Sample Data (Optional)
INSERT INTO Authors (name) VALUES 
    ('J.K. Rowling'), 
    ('George Orwell');

INSERT INTO Books (title, publication_year, genre) VALUES 
    ('Harry Potter and the Sorcerer\'s Stone', 1997, 'Fantasy'),
    ('1984', 1949, 'Dystopian');

INSERT INTO Book_Authors (book_id, author_id) VALUES 
    (1, 1), 
    (2, 2);

INSERT INTO Members (name, email) VALUES 
    ('Alice Johnson', 'alice@example.com'),
    ('Bob Smith', 'bob@example.com');

INSERT INTO Borrow_Records (member_id, book_id, borrow_date, return_date) VALUES 
    (1, 1, '2025-08-01', NULL),
    (2, 2, '2025-08-03', '2025-08-10');
