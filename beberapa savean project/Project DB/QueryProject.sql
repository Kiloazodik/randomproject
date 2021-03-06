CREATE DATABASE ProjectDBV2

USE ProjectDBV2

CREATE TABLE MsStaff(
	StaffId CHAR(5) PRIMARY KEY
		CHECK(StaffId LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR (30)
		CHECK(LEN(StaffName) BETWEEN 7 AND 30),
	StaffDOB DATE
		CHECK(YEAR(GETDATE())-YEAR(StaffDOB)>=18),
	StaffPhone VARCHAR (15),
	StaffAddress VARCHAR(50),
	StaffGender VARCHAR(6)
		CHECK(StaffGender IN('Male','Female')),
	StaffEmail VARCHAR(50)
		CHECK(StaffEmail LIKE ('%@%'))
)

CREATE TABLE MsStudio(
	StudioId CHAR(5) PRIMARY KEY
		CHECK(StudioId LIKE 'ST[0-9][0-9][0-9]'),
	StudioName VARCHAR(50),
	StudioPrice INT
		CHECK(StudioPrice BETWEEN 35000 AND 65000)
)

CREATE TABLE MsMovie(
	MovieId CHAR(5) PRIMARY KEY
		CHECK(MovieId LIKE 'MV[0-9][0-9][0-9]'),
	MovieName VARCHAR(50),
	MovieLicenseNumber VARCHAR(50),
	MovieDuration INT 
		CHECK(MovieDuration <= 240)
)

CREATE TABLE RefreshmentInfo(
	RefreshmentId CHAR(5) PRIMARY KEY
		CHECK(RefreshmentId LIKE 'RE[0-9][0-9][0-9]'),
	RefreshmentName VARCHAR(50),
	RefreshmentStock INT
		Check(RefreshmentStock > 50),
	RefreshmentPrice INT
)

CREATE TABLE MsRefreshmentType(
	RefreshmentTypeId CHAR(5) PRIMARY KEY
		CHECK(RefreshmentTypeId LIKE 'RT[0-9][0-9][0-9]'),
	RefreshmentType VARCHAR(50),
	RefreshmentId CHAR(5) REFERENCES RefreshmentInfo ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE MsTicketTransaction(
	ScheduleTransactionId CHAR(5) PRIMARY KEY
		CHECK(ScheduleTransactionId LIKE 'MS[0-9][0-9][0-9]'),
	MovieId CHAR(5) REFERENCES MsMovie ON UPDATE CASCADE ON DELETE CASCADE,
	StudioId CHAR(5) REFERENCES MsStudio ON UPDATE CASCADE ON DELETE CASCADE,
	TicketDate DATE
		CHECK(DAY(TicketDate)>=GETDATE()+7),
	TicketTime TIME
)

CREATE TABLE HeaderMovieSaleTransaction(
	MovieSaleTransactionId CHAR(6) PRIMARY KEY
		CHECK(MovieSaleTransactionId LIKE 'MTr[0-9][0-9][0-9]'),
	StaffId CHAR(5) REFERENCES MsStaff ON UPDATE CASCADE ON DELETE CASCADE,
	--TicketTransactionId CHAR(5) REFERENCES MsTicketTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	MovieSaleTransactionDate DATE,
	Seat VARCHAR(3)
)

--OK
CREATE TABLE DetailMovieSaleTransaction(
	ScheduleTransactionId CHAR(5)
		REFERENCES MsTicketTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	MovieSaleTransactionId CHAR(6)
		REFERENCES HeaderMovieSaleTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(ScheduleTransactionId, MovieSaleTransactionId)
)

CREATE TABLE HeaderRefreshmentTransaction(
	RefreshmentSaleTransactionId Char(6) PRIMARY KEY
		CHECK(RefreshmentSaleTransactionId LIKE 'RTr[0-9][0-9][0-9]'),
	StaffId CHAR (5) 
		REFERENCES MsStaff ON UPDATE CASCADE ON DELETE CASCADE,
--	RefreshmentTypeId CHAR(5) REFERENCES MsRefreshmentType ON UPDATE CASCADE ON DELETE CASCADE,
	RefreshmentSoldQuantity INT
)

CREATE TABLE DetailRefreshmentTransaction(
	RefreshmentTransactionId CHAR(6)
		REFERENCES HeaderRefreshmentTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	RefreshmentTypeId CHAR(5)
		REFERENCES MsRefreshmentType ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(RefreshmentTransactionId, RefreshmentTypeId)
)

--CREATE TABLE DetailRefreshmentTransaction(
--	RefreshmentTransactionId CHAR(6)
--		REFERENCES HeaderRefreshmentTransaction,
--	RefreshmentTypeId CHAR(5)
--		REFERENCES MsRefreshmentType
--	PRIMARY KEY(RefreshmentTransactionId, RefreshmentTypeId)
--)

DROP TABLE DetailRefreshmentTransaction

/*

INI MSSTAFF

select * from MsStaff

--<18 thn
begin tran
insert into MsStaff
values ('SF016','Ricco occiri','2001-01-22','08121102670','jln U10 dias','Male','riccooccir@gmail.com')
rollback


begin tran
insert into MsStaff
values ('SF001','Ricco occir','2000-01-22','08121102670','jln U10 dias','Male','riccooccir@gmail.com')

begin tran
insert into MsStaff
values ('SF002','Willy Chandra','1997-02-15','08121101500','jln ASD argh','Male','willychandra@gmail.com')

begin tran
insert into MsStaff
values ('SF003','Kevin Aditya','1995-01-01','081291102400','jln U21 m3','Male','kevinaditya@gmail.com')

begin tran
insert into MsStaff
values ('SF004','Derren Delano S','2000-04-22','081291102601','jln sadar 10','Male','derrendelano@gmail.com')

begin tran
insert into MsStaff
values ('SF005','Akmal Faudzan','1999-03-10','081284172424','jln sana sini','Male','akmalfaudzan@gmail.com')

begin tran
insert into MsStaff
values ('SF006','Alif Winanda','1998-02-16','081291102677','jln dimanamana','Male','alifwinanda@gmail.com')

begin tran
insert into MsStaff
values ('SF007','Arsyandra','1999-01-12','081291102700','jln begini begitu','Male','arsyandra@gmail.com')

begin tran
insert into MsStaff
values ('SF008','Chandra Tan','2000-02-17','081291102170','jln kangen dia','Male','chandratan@gmail.com')

begin tran
insert into MsStaff
values ('SF009','Dimas Prasetyo','1999-03-12','081271102670','jln kangen aku','Male','dimasprasetyo@gmail.com')

begin tran
insert into MsStaff
values ('SF010','Dimas Aditya','1997-02-11','081241103670','jln kangen gak','Male','dimasaditya@gmail.com')

begin tran
insert into MsStaff
values ('SF011','Edbert Wicohen','2000-01-30','08123102070','jln sendawa','Male','edbertwicohen@gmail.com')

begin tran
insert into MsStaff
values ('SF012','Elliana chang','2001-01-05','081321101660','jln pramuka','Female','ellianachang@gmail.com')

begin tran
insert into MsStaff
values ('SF013','Martha Owen','2000-11-16','08149111270','jln saporjo','Female','marthaowen@gmail.com')

begin tran
insert into MsStaff
values ('SF014','Rishka Anggraeni','2000-01-12','081221109100','jln senayan','Female','rishkaanggraeni@gmail.com')

begin tran
insert into MsStaff
values ('SF015','Abigail Wijaya','1995-12-12','02171102670','jln cengkareng','Female','abigailwijaya@gmail.com')

*/

select * from HeaderMovieSaleTransaction

begin tran
insert into HeaderMovieSaleTransaction
values ('MTr001','SF001','2019/12/19','B22')
