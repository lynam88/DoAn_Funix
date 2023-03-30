CREATE TABLE User_Donation_detail (
	user_donation_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	donation_id int,
	bank_name NVARCHAR(30),
	bank_user NVARCHAR(10),
	donation_amount money,
	transaction_id NVARCHAR(16),
);
GO

INSERT INTO [dbo].[User_Donation_Detail]
			([donation_id]
			,[bank_name]
			,[bank_user]
			,[donation_amount]
			,[transaction_id])
     VALUES
			('1', 'Sacombank', '36364867', 10000000, 'FT13165756069655'),
			('2', 'Vietcombank', '69705104', 5000000, 'FT18127951977601'),
			('2', 'ACB', '57834374', 7000000, 'FT13918688274757'),
			('4', 'Techcombank', '10669155', 5000000, 'FT15847170889071'),
			('5', 'TPBank', '79556546', 5000000, 'FT15385141865565'),
			('3', 'Techcombank', '81930067', 2000000, 'FT12918312148140'),
			('6', 'TPBank', '76242682', 5000000, 'FT11144986083444'),
			('5', 'Vietcombank', '01165149', 10000000, 'FT17508749752719'),
			('1', 'TPBank', '71753640', 15000000, 'FT17246072730674'),
			('7', 'Techcombank', '58450867', 4000000, 'FT11606795130886'),
			('9', 'Vietcombank', '74687314', 10000000, ''),
			('10', 'TPBank', '90813273', 7000000, ''),
			('11', 'Sacombank', '72178437', 3000000, ''),
			('8', 'Vietcombank', '31780540', 5000000, ''),
			('14', 'ACB', '13471584', 2000000, '')
GO

DBCC CHECKIDENT ('[User_Donation_Detail]', RESEED, 0);
GO

DELETE FROM User_Donation_Detail;
GO

DROP TABLE User_Donation_Detail;
GO

CREATE TABLE User_Donation (
	user_donation_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(30),
	email NVARCHAR(30),	
	donation_status NVARCHAR(10),
	donation_date date
);
GO

INSERT INTO [dbo].[User_Donation]
           ([name]
           ,[email]          
           ,[user_donation_status]
           ,[donation_date])
     VALUES
           ('Thanh Kim', 'khuat.trinh@yahoo.com', 'completed', '2022-10-15'),
           ('Quyen Diem', 'han.buu@yahoo.com', 'completed', '2022-10-20'),
          ('Kieu Kha', 'sang.luu@lo.net.vn', 'completed', '2022-10-28'),
          ('Manh Hoai', 'ocan@be.net.vn', 'completed', '2022-10-28'),
          ('Trần Lý Nam', 'tranlynam@gmail.com', 'completed', '2022-11-04'),
          ('Lien Cat', 'ithao@thieu.gov.vn', 'completed', '2022-11-05'),
          ('Toan Thong', 'linh.tang@hotmail.com', 'completed', '2022-11-10'),
          ('Hung Sy', 'du.kieu@nguy.pro.vn', 'completed', '2022-11-10'),
          ('Kim Thu', 'namtranly49@gmail.com', 'completed', '2022-11-11'),
          ('Kiet The', 'trang80@da.info', 'completed', '2022-11-30'),
          ('Cong Nguyen', 'namtlFX17215@funix.edu.vn', 'pending', '2022-11-30'),
          ('Khoi Hoa', 'hai61@du.com', 'pending', '2022-12-02'),
          ('Tri Đinh', 'ethieu@luong.com', 'pending', '2022-12-05'),
          ('Tien Tuyet', 'dang.tuong@giao.gov.vn', 'pending', '2022-12-10'),
          ('Đieu Huynh', 'thi.dao@bang.org.vn', 'pending', '2022-12-15'),
		  ('Nam Tran Ly', 'tranlynam@gmail.cn', 'pending', '2022-12-15')
GO

DBCC CHECKIDENT ('[User_Donation]', RESEED, 0);
GO

ALTER TABLE User_Donation
ADD CONSTRAINT df_user_donation_status
DEFAULT 'pending' FOR user_donation_status;
GO

DELETE FROM User_Donation;
GO

DROP TABLE User_Donation;
GO

CREATE TABLE Donations (
	donation_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	donation_name NVARCHAR(MAX),
	donation_content NVARCHAR(MAX),
	start_date date,
	end_date date,
	total_needed money,
);
GO

INSERT INTO [dbo].[Donations]
           ([donation_title]           
           ,[donation_content]
           ,[start_date]
		   ,[end_date]
	       ,[total_needed])
     VALUES
           (N'Chung tay quyên góp hỗ trợ mái che và sân trường cho các em học sinh tại vùng xa thuộc tỉnh Bình Thuận', '', '2022-10-12', '2022-12-12', 37000000),
           (N'Cùng CEO HN6 xây dựng Điểm trường Bản Nà Hò, tỉnh Sơn La', '', '2022-10-20', '2023-01-20', 86000000),
          (N'Trao điện thoại, đào tạo về chăm sóc trực tuyến, đào tạo kỹ năng số cho người khuyết tật và người chăm sóc tại Bình Định, Quảng Nam và Kon Tum', '', '2022-10-28', '2022-12-28', 31250000),
          (N'Góp Heo Vàng hoàn thiện cơ sở vật chất cho Quán trọ Sài Gòn bao dung để các cụ già có nơi ăn chốn ở', '', '2022-10-28', '2022-12-28', 50000000),
          (N'Cùng chung tay quyên góp xây mới phòng học ở trường TH và THCS Chiềng Lương - tỉnh Sơn La', '', '2022-11-01', '2023-02-01', 100000000),
          (N'Cùng Ba Đình Cares, Ford Motor Company Fund và Vemba góp Heo Vàng xây dựng điểm trường TH Pa Phang 2, tỉnh Lai Châu', '', '2022-11-10', '2023-02-10', 70000000),
          (N'Góp Heo Vàng cùng AVAKids tặng 80 ca phẫu thuật trong Chiến dịch “Nụ Cười AVAKids"', '', '2022-11-20', '2023-01-20', 40000000),
          (N'Mừng Sinh Nhật Heo Đất – Chung tay gây quỹ Mặt trời Hy Vọng', '', '2022-11-20', '2022-12-30', 10000000),
          (N'Chung tay gây quỹ trồng 20.000 cây xanh đô thị chống biến đổi khí hậu và hạn chế ô nhiễm môi trường', '', '2022-11-30', '2023-02-20', 200000000),
          (N'Cùng góp Heo Vàng xây cầu dân sinh tại Khu Quẽ, xã Thu Cúc, huyện Tân Sơn, tỉnh Phú Thọ', '', '2022-11-30', '2023-03-02', 90000000),
          (N'Đóng góp “Một bữa sáng” vì động vật hoang dã có nguy cơ tuyệt chủng tại Việt Nam', '', '2022-12-05', '2023-01-20', 50000000),
          (N'Chung tay quyên góp kiến tạo công viên đầu tiên dành cho cộng đồng nuôi chó tại Công viên xanh Yên Sở', '', '2022-12-10', '2023-03-10', 140000000),
          (N'“Giữ nhà” cho Voọc Chà Vá chân xám tại Tam Mỹ Tây, Núi Thành, Quảng Nam', '', '2022-12-10', '2023-03-10', 100000000),
          (N'Chung tay ủng hộ, phủ xanh đất trống đồi trọc tại huyện Cam Lộ - tỉnh Quảng Trị', '', '2022-12-15', '2023-03-15', 200000000),
          (N'Chung tay vá rừng trên núi đá tại Hòa Bình – Sơn La', '', '2022-12-20', '2023-03-20', 100000000)
GO

ALTER TABLE Donations
ADD CONSTRAINT df_use_yn
DEFAULT 1 FOR use_yn;
GO

ALTER TABLE Donations
ADD insertDate date, 
updateDate date;
GO

DBCC CHECKIDENT ('[Donations]', RESEED, 0);
GO

DECLARE @max INT
SELECT @max=max([donation_Id]) FROM [Donations]
if @max IS NULL   --check when max is returned as null
  SET @max = 0
DBCC CHECKIDENT ('[Donations]', RESEED, @max)

DELETE FROM Donations;
GO

DROP TABLE Donations;
GO

CREATE TABLE Users (
	name NVARCHAR(30),
	phone NVARCHAR(15),
	email NVARCHAR(30),
	password NVARCHAR(30),
	registration_date DATE,
	user_role NVARCHAR(1),
	status NVARCHAR(1),
	PRIMARY KEY(email)
);
GO

ALTER TABLE Users
ADD CONSTRAINT df_User_role
DEFAULT 2 FOR user_role;
GO

INSERT INTO [dbo].[Users]
           ([name]
           ,[phone]
           ,[email]
           ,[password]
	       ,[registration_date])
     VALUES
           ('Thanh Kim', '037-480-9686', 'khuat.trinh@yahoo.com', '1cc53b96', '2022-10-15'),
           ('Quyen Diem', '068-548-3154', 'han.buu@yahoo.com', '24fe6201', '2022-10-20'),
          ('Kieu Kha', '0210-255-4943', 'sang.luu@lo.net.vn', '90023890', '2022-10-28'),
          ('Manh Hoai', '091-831-7525', 'ocan@be.net.vn', 'd57ae7f8', '2022-10-28'),
          ('Nam Tran', '0162-544-9897', 'bui.viet@phuong.ac.vn', '0df0b64a', '2022-11-04'),
          ('Lien Cat', '0127-797-7388', 'ithao@thieu.gov.vn', 'e3b0034f', '2022-11-05'),
          ('Toan Thong', '0280-964-0975', 'linh.tang@hotmail.com', 'b43a3d39', '2022-11-10'),
          ('Hung Sy', '020-520-3100', 'du.kieu@nguy.pro.vn', 'e89f5f4e', '2022-11-10'),
          ('Kim Thu', '095-410-1381', 'trinh.trong@hoa.info', 'f4557b40', '2022-11-11'),
          ('Kiet The', '0186-178-1940', 'trang80@da.info', '5e1dfa8c', '2022-11-30'),
          ('Cong Nguyen', '0123-314-0105', 'dan.chau@duong.ac.vn', 'd86972d8', '2022-11-30'), 
          ('Khoi Hoa', '022-472-5906', 'hai61@du.com', 'd51c0684', '2022-12-02'),
          ('Tri Đinh', '059-343-9303', 'ethieu@luong.com', 'f11bf433', '2022-12-05'),
          ('Tien Tuyet', '097-855-3907', 'dang.tuong@giao.gov.vn', 'fc8db7ba', '2022-12-10'),
          ('Đieu Huynh', '0510-169-7389', 'thi.dao@bang.org.vn', '3d4c8a7d', '2022-12-10')
GO

ALTER TABLE Users
ADD CONSTRAINT df_user_role
DEFAULT 1 FOR user_role;
GO

ALTER TABLE Users
ADD CONSTRAINT df_status
DEFAULT 1 FOR status;
GO

UPDATE Users SET status = 1;

DELETE FROM Users;
GO

DROP TABLE Users;
GO