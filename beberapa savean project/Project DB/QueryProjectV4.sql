CREATE DATABASE ProjectDBV4

USE ProjectDBV4

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
/*
CREATE TABLE MsTicketTransaction(
	ScheduleTransactionId CHAR(5) PRIMARY KEY
		CHECK(ScheduleTransactionId LIKE 'MS[0-9][0-9][0-9]'),
	MovieId CHAR(5) REFERENCES MsMovie ON UPDATE CASCADE ON DELETE CASCADE,
	StudioId CHAR(5) REFERENCES MsStudio ON UPDATE CASCADE ON DELETE CASCADE,
	TicketDate DATE
		CHECK(DAY(TicketDate)>=GETDATE()+7),
	TicketTime TIME
)
*/
CREATE TABLE MsTicketTransaction(
 ScheduleTransactionId CHAR(5) PRIMARY KEY
  CHECK(ScheduleTransactionId LIKE 'MS[0-9][0-9][0-9]'),
 MovieId CHAR(5) REFERENCES MsMovie ON UPDATE CASCADE ON DELETE CASCADE,
 StudioId CHAR(5) REFERENCES MsStudio ON UPDATE CASCADE ON DELETE CASCADE,
 TicketDate DATE
  CHECK(DAY(TicketDate)>=DAY(GETDATE())+7),
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

/*
INI HEADER MOVIE SALE TRANSACTION

select * from HeaderMovieSaleTransaction

begin tran
insert into HeaderMovieSaleTransaction
values ('MTr001','SF001','2019/12/19','B22')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr002','SF001','2019/12/19','A15')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr003','SF001','2019/12/19','A12')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr004','SF002','2019/12/17','B10')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr005','SF002','2019/12/17','A17')

begin tran
insert into HeaderMovieSaleTransaction
values ('MTr006','SF002','2019/12/17','G7')

begin tran
insert into HeaderMovieSaleTransaction
values ('MTr007','SF003','2019/12/16','C17')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr008','SF003','2019/12/16','B18')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr009','SF003','2019/12/16','D15')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr010','SF004','2019/12/15','D7')

begin tran
insert into HeaderMovieSaleTransaction
values ('MTr011','SF004','2019/12/15','A4')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr012','SF004','2019/12/15','A20')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr013','SF005','2019/12/14','G20')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr014','SF005','2019/12/14','B12')


begin tran
insert into HeaderMovieSaleTransaction
values ('MTr015','SF005','2019/12/14','C20')
*/


/* ini judul movie


select * from MsMovie

begin tran
insert into MsMovie
values('MV001','Frozen 2','6022889378','103')

begin tran
insert into MsMovie
values('MV002','Jeritan malam','1327373701','119')

begin tran
insert into MsMovie
values('MV003','Knives Out','7545762635','130')

begin tran
insert into MsMovie
values('MV004','Tokyo Ghoul S','2458596072','101')

begin tran
insert into MsMovie
values('MV005','Once Upon a Time','9016502306','160')

begin tran
insert into MsMovie
values('MV006','Avengers: Endgame','1491117835','182')

begin tran
insert into MsMovie
values('MV007','Parasite','5048750945','132')


begin tran
insert into MsMovie
values('MV008','Marriage Story','7334991828','137')

begin tran
insert into MsMovie
values('MV009','Jumanji: The Next Level','7972787576','123')

begin tran
insert into MsMovie
values('MV010','Joker','7898227861','122')

begin tran
insert into MsMovie
values('MV011','Ad Astra','4799342737','124')

begin tran
insert into MsMovie
values('MV012','The Irishman','5629050885','210')

begin tran
insert into MsMovie
values('MV013','Captain Marvel','1629455605','125')

begin tran
insert into MsMovie
values('MV014','Midsommar','9511186626','138')

begin tran
insert into MsMovie
values('MV015','Booksmart','8179756457','95')

*/

/*

Ini refreshment info gw samaain sama refreshment type names. cth kalo di refreshment type names "coffee" gw taro 2 product kopi dst
dan RE013 kelewat tapi ga masalah


select * from RefreshmentInfo

begin tran
insert into RefreshmentInfo
values('RE001','KopiKu','96','7000')

begin tran
insert into RefreshmentInfo
values('RE002','KopiNya','53','8000')

begin tran
insert into RefreshmentInfo
values('RE003','Sprite','59','10000')

begin tran
insert into RefreshmentInfo
values('RE004','Coca-cola','80','10000')

begin tran
insert into RefreshmentInfo
values('RE005','Juicetruitu','52','12000')

begin tran
insert into RefreshmentInfo
values('RE006','Juicebuah','68','12000')

begin tran
insert into RefreshmentInfo
values('RE007','Tehbotol','78','9000')

begin tran
insert into RefreshmentInfo
values('RE008','Tehkotjok','60','9000')

begin tran
insert into RefreshmentInfo
values('RE009','Redbull','73','20000')

begin tran
insert into RefreshmentInfo
values('RE010','katrindeng','96','17000')

begin tran
insert into RefreshmentInfo
values('RE010','katrindeng','96','17000')

begin tran
insert into RefreshmentInfo
values('RE010','katrindeng','96','17000')

begin tran
insert into RefreshmentInfo
values('RE011','Lemon herb roasted potatoes','54','32000')

begin tran
insert into RefreshmentInfo
values('RE012','Sapo tahu','71','27000')

begin tran
insert into RefreshmentInfo
values('RE014','Salted Caramel Corn','65','40000')

begin tran
insert into RefreshmentInfo
values('RE015','Chicken and waffler slider','68','37000')

begin tran
insert into RefreshmentInfo
values('RE016','Mie Aceh','80','25000')

begin tran
insert into RefreshmentInfo
values('RE017','Sate Padang','92','30000')

begin tran
insert into RefreshmentInfo
values('RE018','Hummus','72','45000')

begin tran
insert into RefreshmentInfo
values('RE019','Tahini','90','42000')

begin tran
insert into RefreshmentInfo
values('RE020','Kale chips','82','20000')

begin tran
insert into RefreshmentInfo
values('RE021','Mixed Nuts','52','15000')

*/


/*

Ms harus ada 15 data tapi di DOC cuman ada 10 data jdi wa bikin 10 aja deh~~

select * from MsRefreshmentType

begin tran
insert into MsRefreshmentType
values('RT001','Coffee','RE001')

begin tran
insert into MsRefreshmentType
values('RT002','Soda','RE003')

begin tran
insert into MsRefreshmentType
values('RT003','Juice','RE005')

begin tran
insert into MsRefreshmentType
values('RT004','Tea','RE007')

begin tran
insert into MsRefreshmentType
values('RT005','Other Beverages','RE009')

begin tran
insert into MsRefreshmentType
values('RT006','Western Food','RE011')

begin tran
insert into MsRefreshmentType
values('RT007','Heavy Snacks','RE014')

begin tran
insert into MsRefreshmentType
values('RT008','Traditional Food','RE016')

begin tran
insert into MsRefreshmentType
values('RT009','Eastern Food','RE018')

begin tran
insert into MsRefreshmentType
values('RT010','Light Snacks','RE020')

*/

/*

MS STUDIO

select * from MsStudio

begin tran
insert into MsStudio
values('ST001','Grand Indonesia','50000')


begin tran
insert into MsStudio
values('ST002','Pacific Place','55000')

begin tran
insert into MsStudio
values('ST003','Central Park','50000')

begin tran
insert into MsStudio
values('ST004','Slipi Jaya','45000')

begin tran
insert into MsStudio
values('ST005','Green Pramuka','40000')

begin tran
insert into MsStudio
values('ST006','Bella Terra','50000')

begin tran
insert into MsStudio
values('ST007','Aeon Mall JGC','45000')

begin tran
insert into MsStudio
values('ST008','Buaran Plaza','55000')

begin tran
insert into MsStudio
values('ST009','Sunter Mall','50000')

begin tran
insert into MsStudio
values('ST010','FX Sudirman','60000')

begin tran
insert into MsStudio
values('ST011','Paris Van Java','55000')

begin tran
insert into MsStudio
values('ST012','Miko Mall','50000')

begin tran
insert into MsStudio
values('ST013','BEC Mall','52000')

begin tran
insert into MsStudio
values('ST014','Metro Indah Mall','45000')

begin tran
insert into MsStudio
values('ST015','Kings Shopping','40000')

*/

/*

satu id , 1 movie, 1 studio, biar gampang

select * from MsTicketTransaction

begin tran
insert into MsTicketTransaction
values('MS001','MV001','ST001','2019/12/26','17:00')

begin tran
insert into MsTicketTransaction
values('MS002','MV002','ST002','2019/12/25','13:00')

begin tran
insert into MsTicketTransaction
values('MS003','MV003','ST003','2019/12/24','14:00')

begin tran
insert into MsTicketTransaction
values('MS004','MV004','ST004','2019/12/23','07:00')

begin tran
insert into MsTicketTransaction
values('MS005','MV005','ST005','2019/12/22','09:00')

begin tran
insert into MsTicketTransaction
values('MS006','MV006','ST006','2019/12/30','19:00')

begin tran
insert into MsTicketTransaction
values('MS007','MV007','ST007','2019/12/27','20:00')

begin tran
insert into MsTicketTransaction
values('MS008','MV008','ST008','2019/12/29','21:00')

begin tran
insert into MsTicketTransaction
values('MS009','MV009','ST009','2019/12/27','17:00')

begin tran
insert into MsTicketTransaction
values('MS010','MV010','ST010','2019/12/25','13:00')

begin tran
insert into MsTicketTransaction
values('MS011','MV011','ST011','2019/12/22','11:00')

begin tran
insert into MsTicketTransaction
values('MS012','MV012','ST012','2019/12/23','13:00')

begin tran
insert into MsTicketTransaction
values('MS013','MV013','ST013','2019/12/25','10:00')

begin tran
insert into MsTicketTransaction
values('MS014','MV014','ST014','2019/12/23','12:00')

begin tran
insert into MsTicketTransaction
values('MS015','MV015','ST015','2019/12/30','19:00')
*/


/*

select * from DetailMovieSaleTransaction

begin tran 
insert into DetailMovieSaleTransaction
values('MS001','MTr001')

begin tran 
insert into DetailMovieSaleTransaction
values('MS001','MTr002')

begin tran 
insert into DetailMovieSaleTransaction
values('MS002','MTr002')

begin tran 
insert into DetailMovieSaleTransaction
values('MS002','MTr003')

begin tran 
insert into DetailMovieSaleTransaction
values('MS003','MTr003')

begin tran 
insert into DetailMovieSaleTransaction
values('MS003','MTr004')

begin tran 
insert into DetailMovieSaleTransaction
values('MS004','MTr004')

begin tran 
insert into DetailMovieSaleTransaction
values('MS004','MTr005')

begin tran 
insert into DetailMovieSaleTransaction
values('MS005','MTr005')

begin tran 
insert into DetailMovieSaleTransaction
values('MS005','MTr006')

begin tran 
insert into DetailMovieSaleTransaction
values('MS006','MTr006')

begin tran 
insert into DetailMovieSaleTransaction
values('MS006','MTr007')

begin tran 
insert into DetailMovieSaleTransaction
values('MS007','MTr007')

begin tran 
insert into DetailMovieSaleTransaction
values('MS007','MTr008')

begin tran 
insert into DetailMovieSaleTransaction
values('MS008','MTr008')


begin tran 
insert into DetailMovieSaleTransaction
values('MS008','MTr009')

begin tran 
insert into DetailMovieSaleTransaction
values('MS009','MTr009')

begin tran 
insert into DetailMovieSaleTransaction
values('MS009','MTr010')

begin tran 
insert into DetailMovieSaleTransaction
values('MS010','MTr010')

begin tran 
insert into DetailMovieSaleTransaction
values('MS010','MTr011')

begin tran 
insert into DetailMovieSaleTransaction
values('MS011','MTr011')

begin tran 
insert into DetailMovieSaleTransaction
values('MS012','MTr012')

begin tran 
insert into DetailMovieSaleTransaction
values('MS013','MTr013')

begin tran 
insert into DetailMovieSaleTransaction
values('MS014','MTr014')

begin tran 
insert into DetailMovieSaleTransaction
values('MS015','MTr015')

*/


/*
1 staff 3 transaction

select *from HeaderRefreshmentTransaction

begin tran
insert into HeaderRefreshmentTransaction
values('RTr001','SF006','33')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr002','SF006','38')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr003','SF006','40')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr004','SF007','27')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr005','SF007','44')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr006','SF007','50')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr007','SF008','39')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr008','SF008','44')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr009','SF008','29')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr010','SF009','70')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr011','SF009','67')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr012','SF010','36')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr013','SF011','20')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr014','SF011','31')

begin tran
insert into HeaderRefreshmentTransaction
values('RTr015','SF011','60')
*/


/*
random yg penting 25

select * from DetailRefreshmentTransaction

begin tran
insert into DetailRefreshmentTransaction
values('RTr001','RT001')

begin tran
insert into DetailRefreshmentTransaction
values('RTr001','RT002')

begin tran
insert into DetailRefreshmentTransaction
values('RTr002','RT002')

begin tran
insert into DetailRefreshmentTransaction
values('RTr002','RT003')

begin tran
insert into DetailRefreshmentTransaction
values('RTr003','RT003')

begin tran
insert into DetailRefreshmentTransaction
values('RTr003','RT004')

begin tran
insert into DetailRefreshmentTransaction
values('RTr004','RT004')

begin tran
insert into DetailRefreshmentTransaction
values('RTr004','RT005')

begin tran
insert into DetailRefreshmentTransaction
values('RTr005','RT005')

begin tran
insert into DetailRefreshmentTransaction
values('RTr005','RT006')

begin tran
insert into DetailRefreshmentTransaction
values('RTr006','RT006')

begin tran
insert into DetailRefreshmentTransaction
values('RTr006','RT007')

begin tran
insert into DetailRefreshmentTransaction
values('RTr007','RT007')

begin tran
insert into DetailRefreshmentTransaction
values('RTr007','RT008')

begin tran
insert into DetailRefreshmentTransaction
values('RTr008','RT008')

begin tran
insert into DetailRefreshmentTransaction
values('RTr008','RT009')

begin tran
insert into DetailRefreshmentTransaction
values('RTr009','RT009')

begin tran
insert into DetailRefreshmentTransaction
values('RTr009','RT010')

begin tran
insert into DetailRefreshmentTransaction
values('RTr009','RT007')

begin tran
insert into DetailRefreshmentTransaction
values('RTr010','RT010')

begin tran
insert into DetailRefreshmentTransaction
values('RTr011','RT010')

begin tran
insert into DetailRefreshmentTransaction
values('RTr012','RT009')

begin tran
insert into DetailRefreshmentTransaction
values('RTr013','RT008')

begin tran
insert into DetailRefreshmentTransaction
values('RTr014','RT007')

begin tran
insert into DetailRefreshmentTransaction
values('RTr015','RT006')

*/