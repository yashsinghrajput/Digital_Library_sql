CREATE TABLE Books (
    BookID      INT PRIMARY KEY AUTO_INCREMENT,
    Title       VARCHAR(200) NOT NULL,
    Author      VARCHAR(150) NOT NULL,
    Category    VARCHAR(80)  NOT NULL,
    TotalCopies INT          NOT NULL DEFAULT 1
);

CREATE TABLE Students (
    StudentID   INT PRIMARY KEY AUTO_INCREMENT,
    FullName    VARCHAR(150) NOT NULL,
    Email       VARCHAR(150) UNIQUE NOT NULL,
    EnrolledOn  DATE         NOT NULL
);

CREATE TABLE IssuedBooks (
    IssueID     INT PRIMARY KEY AUTO_INCREMENT,
    StudentID   INT  NOT NULL,
    BookID      INT  NOT NULL,
    IssueDate   DATE NOT NULL,
    ReturnDate  DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (BookID)    REFERENCES Books(BookID)
);


INSERT INTO Books (Title, Author, Category, TotalCopies) VALUES
('The Great Gatsby',        'F. Scott Fitzgerald', 'Fiction',  3),
('A Brief History of Time', 'Stephen Hawking',     'Science',  2),
('Sapiens',                 'Yuval Noah Harari',   'History',  4),
('Clean Code',              'Robert C. Martin',    'Technology', 2),
('Dune',                    'Frank Herbert',       'Fiction',  3),
('The Selfish Gene',        'Richard Dawkins',     'Science',  2),
('1984',                    'George Orwell',       'Fiction',  5),
('Cosmos',                  'Carl Sagan',          'Science',  2),
('The Silk Roads',          'Peter Frankopan',     'History',  3),
('Thinking Fast and Slow',  'Daniel Kahneman',     'Psychology', 2);

INSERT INTO Students (FullName, Email, EnrolledOn) VALUES
('Arjun Sharma',   'arjun@college.edu',   '2023-07-15'),
('Priya Mehta',    'priya@college.edu',   '2023-07-15'),
('Rahul Verma',    'rahul@college.edu',   '2022-01-10'),
('Sneha Kapoor',   'sneha@college.edu',   '2021-06-01'),
('Amit Joshi',     'amit@college.edu',    '2020-03-20'),
('Divya Nair',     'divya@college.edu',   '2019-08-05'),
('Karan Singh',    'karan@college.edu',   '2023-11-01'),
('Pooja Desai',    'pooja@college.edu',   '2022-09-12');

INSERT INTO IssuedBooks (StudentID, BookID, IssueDate, ReturnDate) VALUES
(1, 1,  CURDATE() - INTERVAL 20 DAY, NULL),
(2, 3,  CURDATE() - INTERVAL 5  DAY, NULL),
(3, 5,  CURDATE() - INTERVAL 18 DAY, NULL),
(4, 7,  CURDATE() - INTERVAL 3  DAY, CURDATE() - INTERVAL 1 DAY),
(5, 2,  CURDATE() - INTERVAL 30 DAY, NULL),
(6, 4,  CURDATE() - INTERVAL 2  DAY, NULL),
(7, 6,  CURDATE() - INTERVAL 16 DAY, NULL),
(1, 8,  CURDATE() - INTERVAL 10 DAY, NULL),
(2, 9,  CURDATE() - INTERVAL 7  DAY, NULL),
(3, 10, CURDATE() - INTERVAL 25 DAY, NULL),
(4, 1,  DATE('2021-01-10'),           DATE('2021-01-20')),
(5, 3,  DATE('2020-05-15'),           DATE('2020-05-30')),
(6, 5,  DATE('2019-09-01'),           DATE('2019-09-14'));


SELECT
    s.StudentID,
    s.FullName,
    s.Email,
    b.Title        AS BookTitle,
    ib.IssueDate,
    DATEDIFF(CURDATE(), ib.IssueDate) AS DaysOverdue
FROM IssuedBooks ib
JOIN Students s ON s.StudentID = ib.StudentID
JOIN Books    b ON b.BookID    = ib.BookID
WHERE ib.ReturnDate IS NULL
  AND DATEDIFF(CURDATE(), ib.IssueDate) > 14
ORDER BY DaysOverdue DESC;


SELECT
    b.Category,
    COUNT(ib.IssueID) AS TotalBorrows
FROM IssuedBooks ib
JOIN Books b ON b.BookID = ib.BookID
GROUP BY b.Category
ORDER BY TotalBorrows DESC;


DELETE FROM Students
WHERE StudentID NOT IN (
    SELECT DISTINCT StudentID
    FROM IssuedBooks
    WHERE IssueDate >= CURDATE() - INTERVAL 3 YEAR
);
