create database Bookstore
on
(
name =	'Bookstore-data',
filename = 'd:\db\Bookstore-data.mdf',
size = 8 mb,
filegrowth = 50mb
)

log on 
(
name =	'Bookstore-log',
filename = 'd:\db\Bookstore-log.ldf',
size = 8 mb,
filegrowth = 50mb,
maxsize = 500mb
)
go 

use Bookstore


go
create table T_Author 
(
A_ID int constraint PK__Author_ID primary key identity(1001,1),
A_First_Name nvarchar(20) not null,
A_Last_Name nvarchar(30) not null,
A_Birth_Date date constraint DF__Birth_Date default getdate(),
A_Bio nvarchar(max)
)  

go
create table T_Publisher
(
P_ID int constraint PK__Publisher_ID primary key identity(1001,1),
P_Name nvarchar(30) not null constraint UN__Publisher_Name unique,
P_Address nvarchar(max),
P_Phone char(11) 
)

go
create table T_Genres
(
G_ID int constraint PK_Genres_ID primary key,
G_name nvarchar(30) 
)


go
create table T_Library_Sections
(
LS_ID int constraint PK_Library_Sections_ID primary key identity(10,1),
LS_Name nvarchar(30)
)

go 
create table T_Section_Genres
(
SG_ID int constraint PK_Section_Genres_ID primary key,
SG_Section_ID int constraint FK_Section_Genres_Section_ID foreign key references T_Library_Sections(LS_ID),
SG_Generes_ID int constraint FK_Section_Genres_Generes_ID foreign key references T_Genres(G_ID)
)

go
create table T_Books
(
B_ID int primary key,
B_Title nvarchar(20) not null,
B_Author_ID int constraint FK__Books_author_ID foreign key references T_Author(A_ID),
B_Publisher_ID int constraint FK__Books_Publisher_ID foreign key references T_Publisher(P_ID),
B_Year_Published int constraint DF__Books_Year_Published default year(getdate()),
B_Generes_ID int constraint FK_Books_Generes_ID foreign key references T_Genres(G_ID),
B_Page_Count varchar(max),
--B_Library_Sections_ID int constraint FK_Books_Library_Sections_ID foreign key references  T_Library_Sections(LS_ID)
)

go 
create table T_Member_Ship
(
M_ID int constraint PK_Member_Ship_ID primary key,
M_Start DATE NOT NULL,       
M_End DATE,                         
M_Price money,
)

go
create table T_User 
(
U_ID int constraint PK__User_ID primary key identity(1000,1),
U_Name nvarchar(20),
U_Last_Neme nvarchar(30),
U_Member_Ship_ID int constraint FK_User_Member_Ship_ID foreign key references T_Member_Ship(M_ID),
U_Membership_Date date constraint DF__User_Membership_Date default getdate()
)

go
create table T_Borrowing
(
BO_ID int constraint PK__Borrowing_ID primary key identity(4000,1),
BO_User_ID int constraint FK__Borrowing_User_ID foreign key references T_User(U_ID),
BO_Book_ID int constraint FK__Borrowing_Books_ID foreign key references T_Books(B_ID),
BO_Borrow_Date date constraint DF__Borrowing_Borrow_Date default getdate(),
BO_Return_Date date
)

create table T_Shop
(
SH_ID int constraint PK__Shop_ID primary key identity(90000,1),
SH_User_ID int constraint FK__Shop_User_ID foreign key references T_User(U_ID),
SH_Book_ID int constraint FK__Shop_Books_ID foreign key references T_Books(B_ID),
SH_Sell_Date date constraint DF__Shop_sell_Date default getdate(),
)

--اضافه کرن رکورد ها




INSERT INTO T_Author (A_First_Name, A_Last_Name, A_Birth_Date, A_Bio)
VALUES 
('John', 'Doe', '1980-05-14', 'Famous author of mystery novels.'),
('Jane', 'Smith', '1975-02-23', 'Award-winning science fiction writer.'),
('George', 'Martin', '1948-09-20', 'Fantasy author known for long series.'),
('Emily', 'Bronte', '1818-07-30', 'Classic English novelist.'),
('Charles', 'Dickens', '1812-02-07', 'English author of famous works.'),
('Mark', 'Twain', '1835-11-30', 'American author of adventures.'),
('J.K.', 'Rowling', '1965-07-31', 'Famous for wizarding world.'),
('Leo', 'Tolstoy', '1828-09-09', 'Russian novelist known for war themes.'),
('Agatha', 'Christie', '1890-09-15', 'Mystery writer with many famous books.'),
('Fyodor', 'Dostoevsky', '1821-11-11', 'Russian novelist of psychological depth.'),
('H.G.', 'Wells', '1866-09-21', 'Science fiction writer of classics.'),
('Virginia', 'Woolf', '1882-01-25', 'English modernist author.'),
('Ernest', 'Hemingway', '1899-07-21', 'American author known for concise style.'),
('Oscar', 'Wilde', '1854-10-16', 'Irish playwright and novelist.'),
('Franz', 'Kafka', '1883-07-03', 'Austrian writer of surreal stories.'),
('Gabriel', 'Garcia Marquez', '1927-03-06', 'Latin American author of magical realism.'),
('Harper', 'Lee', '1926-04-28', 'Author of a major American novel.'),
('Isaac', 'Asimov', '1920-01-02', 'Prolific science fiction author.'),
('Toni', 'Morrison', '1931-02-18', 'American novelist and Nobel laureate.'),
('Alice', 'Walker', '1944-02-09', 'American novelist and poet.');
GO

INSERT INTO T_Publisher (P_Name, P_Address, P_Phone)
VALUES
('Penguin Random House', 'New York, USA', '12345678901'),
('HarperCollins', 'London, UK', '12345678902'),
('Simon & Schuster', 'New York, USA', '12345678903'),
('Macmillan', 'London, UK', '12345678904'),
('Hachette Livre', 'Paris, France', '12345678905'),
('Oxford University Press', 'Oxford, UK', '12345678906'),
('Cambridge University Press', 'Cambridge, UK', '12345678907'),
('Scholastic', 'New York, USA', '12345678908'),
('Pearson', 'London, UK', '12345678909'),
('McGraw-Hill Education', 'New York, USA', '12345678910'),
('Springer', 'Berlin, Germany', '12345678911'),
('Wiley', 'Hoboken, USA', '12345678912'),
('Elsevier', 'Amsterdam, Netherlands', '12345678913'),
('Sage Publications', 'Thousand Oaks, USA', '12345678914'),
('Taylor & Francis', 'London, UK', '12345678915'),
('MIT Press', 'Cambridge, USA', '12345678916'),
('Bloomsbury', 'London, UK', '12345678917'),
('Pan Macmillan', 'London, UK', '12345678918'),
('Faber & Faber', 'London, UK', '12345678919'),
('Verso Books', 'London, UK', '12345678920');
GO

INSERT INTO T_Genres (G_ID, G_Name)
VALUES
(1, 'Fiction'),
(2, 'Non-Fiction'),
(3, 'Mystery'),
(4, 'Fantasy'),
(5, 'Science Fiction'),
(6, 'Romance'),
(7, 'Horror'),
(8, 'Historical'),
(9, 'Biography'),
(10, 'Children'),
(11, 'Adventure'),
(12, 'Classics'),
(13, 'Drama'),
(14, 'Thriller'),
(15, 'Poetry'),
(16, 'Graphic Novels'),
(17, 'Self-Help'),
(18, 'Cookbooks'),
(19, 'Travel'),
(20, 'Science');
GO

INSERT INTO T_Library_Sections (LS_Name)
VALUES
('General Fiction'),
('Non-Fiction'),
('Children’s Literature'),
('Science & Technology'),
('History'),
('Arts & Culture'),
('Mystery & Thrillers'),
('Romance'),
('Science Fiction & Fantasy'),
('Biographies'),
('Adventure'),
('Poetry & Drama'),
('Self-Help'),
('Cookbooks & Food'),
('Travel & Adventure'),
('Horror'),
('Classics'),
('Comics & Graphic Novels'),
('Religious Studies'),
('Philosophy');
GO

INSERT INTO T_Section_Genres (SG_ID, SG_Section_ID, SG_Generes_ID)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 10),
(4, 4, 5),
(5, 5, 8),
(6, 6, 13),
(7, 7, 3),
(8, 8, 6),
(9, 9, 4),
(10, 10, 9),
(11, 11, 11),
(12, 12, 15),
(13, 13, 17),
(14, 14, 18),
(15, 15, 19),
(16, 16, 7),
(17, 17, 12),
(18, 18, 16),
(19, 19, 20),
(20, 20, 14);
GO

INSERT INTO T_Books (B_ID, B_Title, B_Author_ID, B_Publisher_ID, B_Year_Published, B_Generes_ID, B_Page_Count)
VALUES
(1001, 'The Mysterious Affair', 1001, 1001, 1920, 3, '256'),
(1002, 'A Study in Scarlet', 1002, 1002, 1887, 3, '307'),
(1003, 'The Great Gatsby', 1003, 1003, 1925, 1, '180'),
(1004, 'War and Peace', 1004, 1004, 1869, 8, '1225'),
(1005, '1984', 1005, 1005, 1949, 5, '328'),
(1006, 'To Kill a Mockingbird', 1006, 1006, 1960, 1, '281'),
(1007, 'Pride and Prejudice', 1007, 1007, 1813, 6, '279'),
(1008, 'Frankenstein', 1008, 1008, 1818, 7, '280'),
(1009, 'The Hobbit', 1009, 1009, 1937, 4, '310'),
(1010, 'Harry Potter', 1010, 1010, 1997, 4, '223'),
(1011, 'Moby-Dick', 1011, 1011, 1851, 11, '585'),
(1012, 'Anna Karenina', 1012, 1012, 1877, 8, '864'),
(1013, 'The Catcher in the Rye', 1013, 1013, 1951, 1, '277'),
(1014, 'The Odyssey', 1014, 1014, -800, 11, '541'),
(1015, 'Brave New World', 1015, 1015, 1932, 5, '288'),
(1016, 'The Divine Comedy', 1016, 1016, 1320, 15, '798'),
(1017, 'Les Misérables', 1017, 1017, 1862, 8, '1463'),
(1018, 'The Picture of Dorian Gray', 1018, 1018, 1890, 12, '254'),
(1019, 'Dracula', 1019, 1019, 1897, 7, '418'),
(1020, 'Don Quixote', 1020, 1020, 1605, 12, '1072');
GO

INSERT INTO T_Member_Ship (M_Start, M_End, M_Price)
VALUES
('2023-01-01', '2023-12-31', 100.00),
('2023-02-01', '2023-11-30', 80.00),
('2023-03-01', '2023-12-31', 90.00),
('2023-04-01', '2023-12-31', 85.00),
('2023-05-01', '2023-10-31', 70.00),
('2023-06-01', '2024-05-31', 120.00),
('2023-07-01', '2024-06-30', 130.00),
('2023-08-01', '2024-07-31', 150.00),
('2023-09-01', '2024-08-31', 160.00),
('2023-10-01', '2024-09-30', 140.00),
('2023-11-01', '2024-10-31', 110.00),
('2023-12-01', '2024-11-30', 100.00),
('2024-01-01', '2024-12-31', 90.00),
('2024-02-01', '2024-12-31', 95.00),
('2024-03-01', '2025-02-28', 80.00),
('2024-04-01', '2025-03-31', 85.00),
('2024-05-01', '2025-04-30', 70.00),
('2024-06-01', '2025-05-31', 120.00),
('2024-07-01', '2025-06-30', 130.00),
('2024-08-01', '2025-07-31', 150.00);
GO

INSERT INTO T_User (U_Name, U_Last_Neme, U_Member_Ship_ID)
VALUES
('Alice', 'Johnson', 1),
('Bob', 'Smith', 2),
('Charlie', 'Brown', 3),
('David', 'Williams', 4),
('Eve', 'Davis', 5),
('Frank', 'Miller', 6),
('Grace', 'Clark', 7),
('Hannah', 'Walker', 8),
('Isaac', 'Wright', 9),
('Jack', 'Thompson', 10),
('Karen', 'Moore', 11),
('Leo', 'Anderson', 12),
('Mia', 'Taylor', 13),
('Nora', 'Wilson', 14),
('Oliver', 'Martin', 15),
('Paul', 'Lee', 16),
('Quincy', 'Perez', 17),
('Rachel', 'Hall', 18),
('Samuel', 'Young', 19),
('Tina', 'Allen', 20);
GO

INSERT INTO T_Borrowing (BO_User_ID, BO_Book_ID, BO_Borrow_Date, BO_Return_Date)
VALUES
(1, 1001, '2023-01-01', '2023-01-15'),
(2, 1002, '2023-02-05', '2023-02-20'),
(3, 1003, '2023-03-10', '2023-03-25'),
(4, 1004, '2023-04-01', '2023-04-15'),
(5, 1005, '2023-05-12', '2023-05-27'),
(6, 1006, '2023-06-15', '2023-06-30'),
(7, 1007, '2023-07-01', '2023-07-15'),
(8, 1008, '2023-08-10', '2023-08-25'),
(9, 1009, '2023-09-12', '2023-09-27'),
(10, 1010, '2023-10-01', '2023-10-15'),
(11, 1011, '2023-11-05', '2023-11-20'),
(12, 1012, '2023-12-12', '2023-12-27'),
(13, 1013, '2024-01-01', '2024-01-15'),
(14, 1014, '2024-02-05', '2024-02-20'),
(15, 1015, '2024-03-10', '2024-03-25'),
(16, 1016, '2024-04-01', '2024-04-15'),
(17, 1017, '2024-05-12', '2024-05-27'),
(18, 1018, '2024-06-15', '2024-06-30'),
(19, 1019, '2024-07-01', '2024-07-15'),
(20, 1020, '2024-08-10', '2024-08-25');
GO

INSERT INTO T_Shop (SH_User_ID, SH_Book_ID, SH_Sell_Date)
VALUES
(1, 1001, '2023-01-10'),
(2, 1002, '2023-02-15'),
(3, 1003, '2023-03-20'),
(4, 1004, '2023-04-05'),
(5, 1005, '2023-05-18'),
(6, 1006, '2023-06-20'),
(7, 1007, '2023-07-05'),
(8, 1008, '2023-08-15'),
(9, 1009, '2023-09-18'),
(10, 1010, '2023-10-05'),
(11, 1011, '2023-11-10'),
(12, 1012, '2023-12-15'),
(13, 1013, '2024-01-20'),
(14, 1014, '2024-02-10'),
(15, 1015, '2024-03-15'),
(16, 1016, '2024-04-05'),
(17, 1017, '2024-05-15'),
(18, 1018, '2024-06-18'),
(19, 1019, '2024-07-05'),
(20, 1020, '2024-08-15');
GO

