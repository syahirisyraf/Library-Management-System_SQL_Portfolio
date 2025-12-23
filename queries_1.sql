SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;

-- PROJECT TASK

-- Q1. Create a New Book Record -- " '978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B Lippincott & Co' "
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES(
	'978-1-60129-456-2', 
	'To Kill a Mockingbird', 
	'Classic', 
	6.00,
	'yes',
	'Harper Lee',
	'J.B Lippincott & Co'
);
SELECT * FROM books;

-- Q2. Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

-- Q3. Delete a Record from the issued Status table 
-- Objective: Delete the record with issue_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

SELECT * FROM issued_status
WHERE issued_id = 'IS121';

-- Q4. Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Q5. List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT
	issued_emp_id,
	COUNT(issued_id) as total_book_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1;

-- CTAS
-- Q6. Create suummary Tables: Used CTAS to generate based on query results - each book and total book_issued_cnt**
CREATE TABLE book_cnts
AS
SELECT
	b.isbn,
	b.book_title,
	COUNT(ist.issued_id) as no_issued
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 2;

SELECT * FROM book_cnts;

-- Q7. Retrieve All Books in a Specific Category.
SELECT * FROM books
WHERE category = 'Classic';

-- Q8. Find Total Rental Income by Category.
SELECT
	b.category,
	SUM(b.rental_price),
	COUNT(*)
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1;

-- 	Q9. List Members Who Registered in the Last 365 Days.
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '365 days';


INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C168', 'Sam', '145 Main St', '2025-06-01'),
('C169', 'John', '133 Main St', '2025-05-01')

-- Q10. List Employees with Their Branch Manager's Name and their branch details.
SELECT
	e1.*,
	b.manager_id,
	e2.emp_name as manager
FROM employees as e1
JOIN
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2
ON b.manager_id = e2.emp_id;

-- Q11. Create a Table of Books with Rental Price Above a Certain Threshold 7 USD.

CREATE  TABLE books_price_greater_than_seven
AS
SELECT * FROM books
WHERE rental_price > 7

SELECT * FROM books_price_greater_than_seven

-- Q12. Retrieve the List of Books Not Yet Returned
SELECT
	DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL








