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

