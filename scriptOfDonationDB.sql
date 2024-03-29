USE [master]
GO
/****** Object:  Database [DonationDB]    Script Date: 4/7/2023 2:19:49 PM ******/
CREATE DATABASE [DonationDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DonationDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DonationDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DonationDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DonationDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DonationDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DonationDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DonationDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DonationDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DonationDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DonationDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DonationDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DonationDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DonationDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DonationDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DonationDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DonationDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DonationDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DonationDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DonationDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DonationDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DonationDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DonationDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DonationDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DonationDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DonationDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DonationDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DonationDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DonationDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DonationDB] SET  MULTI_USER 
GO
ALTER DATABASE [DonationDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DonationDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DonationDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DonationDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DonationDB', N'ON'
GO
USE [DonationDB]
GO
/****** Object:  User [Amida]    Script Date: 4/7/2023 2:19:50 PM ******/
CREATE USER [Amida] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Donations]    Script Date: 4/7/2023 2:19:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[donation_id] [int] IDENTITY(1,1) NOT NULL,
	[donation_status] [nvarchar](1) NULL,
	[donation_title] [nvarchar](max) NULL,
	[donation_content] [nvarchar](max) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[total_needed] [money] NULL,
	[use_yn] [nvarchar](1) NULL,
	[thumbnail] [nvarchar](max) NULL,
	[insertDate] [date] NULL,
	[updateDate] [date] NULL,
	[category] [nvarchar](max) NULL,
 CONSTRAINT [PK__Donation__296B91DC847C71F1] PRIMARY KEY CLUSTERED 
(
	[donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/7/2023 2:19:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[name] [nvarchar](30) NULL,
	[phone] [nvarchar](15) NULL,
	[email] [nvarchar](30) NOT NULL,
	[avatar_path] [nvarchar](max) NULL,
	[address] [nvarchar](30) NULL,
	[password] [nvarchar](max) NULL,
	[registration_date] [date] NULL,
	[user_role] [nvarchar](1) NULL,
	[status] [nvarchar](1) NULL,
	[feedback] [nvarchar](max) NULL,
 CONSTRAINT [PK__Users__AB6E616591C042E8] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users_Donation]    Script Date: 4/7/2023 2:19:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_Donation](
	[user_donation_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NULL,
	[email] [nvarchar](30) NULL,
	[phone] [nvarchar](15) NULL,
	[bank] [nvarchar](max) NULL,
	[transaction_id] [nvarchar](30) NULL,
	[donation_amount] [money] NULL,
	[user_donation_status] [nvarchar](1) NULL,
	[donation_id] [int] NULL,
	[donation_date] [date] NULL,
 CONSTRAINT [PK__User_Don__A862CEF4943027B4] PRIMARY KEY CLUSTERED 
(
	[user_donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Donations] ON 

INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (1, N'1', N'Hỗ trợ mái che, sân trường cho học sinh vùng xa Bình Thuận.', N'<p>❤️&nbsp;Mỗi một tấm l&ograve;ng của cộng đồng MoMo sẽ gi&uacute;p c&aacute;c em học sinh v&ugrave;ng qu&ecirc; c&oacute; m&aacute;i che nắng che mưa v&agrave; s&acirc;n chơi tốt hơn để c&aacute;c b&eacute; c&oacute; cơ hội học tập v&agrave; ph&aacute;t triển to&agrave;n diện.</p>

<p><strong>Ho&agrave;n cảnh kh&oacute; khăn thiếu thốn về cơ sở vật chất của c&aacute;c em học sinh v&ugrave;ng xa</strong></p>

<p>Ở những v&ugrave;ng qu&ecirc; ngh&egrave;o, c&aacute;c em học sinh lu&ocirc;n phải chịu những thiệt th&ograve;i về điều kiện cơ sở vật chất. Trường Mẫu gi&aacute;o H&agrave;m Mỹ v&agrave; trường Tiểu học T&acirc;n Thuận 3 thuộc huyện H&agrave;m Thuận Nam, tỉnh B&igrave;nh Thuận l&agrave; một trong nhiều ng&ocirc;i trường c&ograve;n nhiều thiếu thốn. Điều đ&oacute; khiến cho việc học tập v&agrave; r&egrave;n luyện sức khỏe của c&aacute;c em học sinh nơi đ&acirc;y gặp nhiều trở ngại.&nbsp;&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112544-638000475440260194.jpg" style="height:346px; width:650px" /></p>

<p><em>S&acirc;n trường ngập nước trong m&ugrave;a mưa của trường Tiểu học T&acirc;n Thuận 3</em></p>

<ul>
	<li>&ldquo;C&ocirc; ơi! Nắng chiếu v&agrave;o ph&ograve;ng nắng qu&aacute;!&rdquo;,&nbsp;</li>
	<li>&ldquo;Thầy ơi! H&ocirc;m nay s&acirc;n trường nước nhiều n&ecirc;n em mang d&eacute;p đi học được kh&ocirc;ng ạ?&rdquo;.</li>
</ul>

<p>L&agrave; những c&acirc;u m&agrave; gi&aacute;o vi&ecirc;n ở trường Tiểu học T&acirc;n Thuận 3 c&oacute; thể nghe nhiều lần mỗi m&ugrave;a nắng gắt đến hay m&ugrave;a mưa về. Ở ng&ocirc;i trường m&agrave; c&aacute;c em đang theo học, m&ugrave;a h&egrave; đến s&acirc;n trường nắng ch&oacute;i chang, kh&ocirc;ng c&oacute; kh&ocirc;ng gian cho học sinh vui chơi, n&ocirc; đ&ugrave;a. Khi m&ugrave;a mưa về th&igrave; những ng&agrave;y thứ 2 đầu tuần, học sinh sẽ phải ngồi ch&agrave;o cờ với một s&acirc;n trường đầy nước c&oacute; lẽ cũng trở n&ecirc;n quen thuộc. H&igrave;nh ảnh học sinh v&agrave; gi&aacute;o vi&ecirc;n đến trường với những chiếc ống quần được xắn cao ng&agrave;y mưa đ&atilde; qu&aacute; đỗi b&igrave;nh thường. Thế nhưng c&aacute;c gi&aacute;o vi&ecirc;n ở trường vẫn lu&ocirc;n ki&ecirc;n tr&igrave; t&igrave;m c&aacute;ch chắn mưa, che m&aacute;t để c&aacute;c em học sinh c&oacute; thể y&ecirc;n t&acirc;m theo đuổi con chữ.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112626-638000475866509703.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112641-638000476018331732.jpg" style="height:346px; width:650px" /></p>

<p><em>C&aacute;c em phải ch&agrave;o cờ v&agrave; vui chơi dưới s&acirc;n trường kh&ocirc;ng m&aacute;i che&nbsp;</em></p>

<p>Mặc d&ugrave; c&aacute;c trường học ở huyện H&agrave;m Thuận Nam, tỉnh B&igrave;nh Thuận đ&atilde; được hỗ trợ nhiều về cơ sở vật chất, nhưng vẫn c&ograve;n đ&oacute; rất nhiều thứ cần phải x&atilde; hội ho&aacute;. Đặc biệt tại v&ugrave;ng n&ocirc;ng th&ocirc;n, nơi m&agrave; việc vận động phụ huynh c&ograve;n nhiều kh&oacute; khăn. Bởi v&igrave; cuộc sống họ c&ograve;n v&ocirc; v&agrave;n kh&oacute; khăn phải đối mặt. Hơn nữa tại địa phương cũng kh&ocirc;ng c&oacute; nhiều doanh nghiệp để vận động, n&ecirc;n những kh&oacute; khăn của c&aacute;c trường ở v&ugrave;ng s&acirc;u v&ugrave;ng xa vẫn chưa được ho&agrave;n to&agrave;n cải thiện.</p>

<p><strong>Chung tay mang lại điều kiện cơ sở vật chất tốt hơn cho c&aacute;c b&eacute; mầm non v&agrave; tiểu học</strong></p>

<p>Từ một tấm l&ograve;ng hảo t&acirc;m của cộng đồng Tr&aacute;i Tim MoMo, sẽ gi&uacute;p trung b&igrave;nh 426 em học sinh mỗi năm tại trường Tiểu học T&acirc;n Thuận 3 c&oacute; được một s&acirc;n trường cao r&aacute;o sạch sẽ hơn, 55 em nhỏ tại trường Mẫu gi&aacute;o H&agrave;m Mỹ (cơ sở Ph&uacute; Sơn) c&oacute; được m&aacute;i che cho những ng&agrave;y nắng mưa. Th&agrave;nh quả đ&oacute; sẽ tạo điều kiện tốt nhất cho c&aacute;c em được học tập v&agrave; ph&aacute;t triển.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112709-638000476295949668.jpg" style="height:346px; width:650px" /></p>

<p><em>Chung tay gi&uacute;p c&aacute;c em học sinh c&oacute; được m&aacute;i che ở s&acirc;n trường cho những ng&agrave;y nắng mưa</em></p>

<p>Trường Tiểu học T&acirc;n Thuận 3 v&agrave; trường Mẫu gi&aacute;o H&agrave;m Mỹ (cơ sở Ph&uacute; Sơn) sẽ được hỗ trợ 16 triệu đồng cho mỗi ng&ocirc;i trường. V&agrave; phần chi ph&iacute; c&ograve;n lại của c&aacute;c c&ocirc;ng tr&igrave;nh tr&ecirc;n sẽ được nh&agrave; trường tiếp tục vận động x&atilde; hội ho&aacute;.</p>

<p>Thay mặt ban gi&aacute;m hiệu nh&agrave; trường, Thiện Ch&iacute; biết ơn những tấm l&ograve;ng của cộng đồng người d&ugrave;ng MoMo đ&atilde; lu&ocirc;n quan t&acirc;m, gi&uacute;p đỡ để c&aacute;c b&eacute; được y&ecirc;n t&acirc;m học tập dưới một ng&ocirc;i trường c&oacute; điều kiện cơ sở vật chất khang trang hơn.&nbsp;</p>
', CAST(N'2022-10-12' AS Date), CAST(N'2022-12-12' AS Date), 21212120.0000, N'1', N'admin/media/thumbnail/1.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'1')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (2, N'1', N'Cùng CEO HN6 xây dựng Điểm trường Bản Nà Hò, tỉnh Sơn La', N'<p>❤️&nbsp;C&ugrave;ng CEO HN6 x&acirc;y dựng Điểm trường Bản N&agrave; H&ograve;, tỉnh Sơn La để c&aacute;c con c&oacute; ph&ograve;ng học ki&ecirc;n cố, đảm bảo an to&agrave;n, y&ecirc;n t&acirc;m học tập</p>

<p>Nằm ở v&ugrave;ng bi&ecirc;n giới của Tổ Quốc, x&atilde; Mường Sai l&agrave; x&atilde; v&ugrave;ng III gi&aacute;p với nước bạn L&agrave;o. X&atilde; c&oacute; 13 bản, người d&acirc;n chủ yếu l&agrave; đồng b&agrave;o d&acirc;n tộc H M&ocirc;ng, Th&aacute;i, Xinh Mun &hellip; c&ugrave;ng nhau sinh sống. Tỉ lệ hộ ngh&egrave;o của bản chiếm tỉ lệ cao. Trường Mầm non Bi&ecirc;n Cương Mường Sai thuộc địa b&agrave;n x&atilde; Mường Sai, với 9 điểm trường. C&aacute;c điểm trường đều c&aacute;ch xa khu trung t&acirc;m, đường đi lại v&ocirc; c&ugrave;ng kh&oacute; khăn. Hiện nay trường c&oacute; tổng 19 lớp với 471 học sinh theo học.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221128160735-638052484552128456.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221128160749-638052484698331923.jpg" style="height:346px; width:650px" /></p>

<p><em>Điểm trường bản N&agrave; H&ograve; đ&atilde; xuống cấp v&agrave; kh&ocirc;ng c&ograve;n đủ an to&agrave;n cho c&aacute;c em học sinh theo học</em></p>

<p>Trong đ&oacute; điểm trường bản N&agrave; H&ograve; l&agrave; một trong 9 điểm trường, l&agrave; bản đặc biệt kh&oacute; khăn của x&atilde;. Điểm trường được x&acirc;y dựng từ năm 2010, c&aacute;ch trung t&acirc;m x&atilde; khoảng 3.5km, v&agrave; c&oacute; hiện tại c&oacute; 5 ph&ograve;ng học. Trong đ&oacute; 2 ph&ograve;ng học mượn nh&agrave; kho dựng tạm với m&aacute;i proximang được d&acirc;n bản tự l&agrave;m v&agrave; đưa v&agrave;o sử dụng từ năm 2020. V&agrave; c&ograve;n 1 ph&ograve;ng học tạm đ&atilde; xuống cấp hư hỏng nặng, kh&ocirc;ng đảm bảo an to&agrave;n cho c&ocirc;ng t&aacute;c dạy v&agrave; học của thầy tr&ograve; điểm trường N&agrave; H&ograve;. Với cơ sở vật chất ngh&egrave;o n&agrave;n v&agrave; xuống cấp c&aacute;c em học sinh phải học tập trong c&aacute;i lạnh gi&aacute; của m&ugrave;a đ&ocirc;ng v&agrave; c&aacute;i n&oacute;ng nực của m&ugrave;a h&egrave;. D&ugrave; vậy thầy v&agrave; tr&ograve; của điểm trường bản N&agrave; H&ograve; vẫn ki&ecirc;n tr&igrave; b&aacute;m trường b&aacute;m lớp.</p>

<p>D&acirc;n tộc sinh sống tại bản 100% l&agrave; d&acirc;n tộc Th&aacute;i. Nghề nghiệp của người d&acirc;n chủ yếu l&agrave;m nương, 60% hộ ngh&egrave;o. Nằm ở v&ugrave;ng s&acirc;u v&ugrave;ng xa của đất nước n&ecirc;n tr&igrave;nh d&acirc;n độ d&acirc;n tr&iacute; của họ chưa được n&acirc;ng cao. Thế nhưng người d&acirc;n vẫn chăm chỉ l&agrave;m lụng v&agrave; tiết kiệm để c&aacute;c con c&oacute; thể đến trường học tập, n&acirc;ng cao kiến thức.&nbsp;</p>

<p>Năm học mới dự kiến điểm trường sẽ c&oacute; th&ecirc;m 101 học sinh với độ tuổi từ 1 đến 5 tuổi. Thế nhưng cơ sở vật chất kh&oacute; c&oacute; thể đảm bảo an to&agrave;n cho c&aacute;c em tiếp tục theo học. V&igrave; thế nhằm củng cố v&agrave; n&acirc;ng cao chất lượng gi&aacute;o dục, cũng như tạo dựng một m&ocirc;i trường giảng dạy v&agrave; học tập an to&agrave;n, th&acirc;n thiện cho gi&aacute;o vi&ecirc;n v&agrave; c&aacute;c em học sinh, V&iacute; MoMo kết hợp c&ugrave;ng Trung t&acirc;m t&igrave;nh nguyện Quốc gia, Sức Mạnh 2000 v&agrave; CEO HN6 x&acirc;y dựng lớp học mới cho điểm trường N&agrave; H&ograve; với 2 ph&ograve;ng học, 2 ph&ograve;ng c&ocirc;ng vụ v&agrave; 2 nh&agrave; vệ sinh.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221128160829-638052485092265652.jpg" style="height:346px; width:650px" /></p>

<p><em>Lớp học lợp m&aacute;i t&ocirc;n v&ocirc; c&ugrave;ng nắng n&oacute;ng v&agrave;o h&egrave; v&agrave; lạnh gi&aacute; v&agrave;o m&ugrave;a đ&ocirc;ng của c&aacute;c em học sinh ngh&egrave;o</em></p>

<p>Hiện nay bản đ&atilde; c&oacute; diện t&iacute;ch đất để khởi c&ocirc;ng dự &aacute;n, v&igrave; thế để dự &aacute;n c&oacute; thể tiến h&agrave;nh ch&uacute;ng t&ocirc;i mong muốn cộng đồng chung tay quy&ecirc;n g&oacute;p 860.000 Heo V&agrave;ng. Số Heo V&agrave;ng n&agrave;y sẽ được nh&agrave; t&agrave;i trợ CEO HN6 quy đổi tương đương với 430.000.000 đồng tiền mặt. Tập thể L&atilde;nh đạo Trường Mầm non Bi&ecirc;n Cương Mường Sai huyện S&ocirc;ng M&atilde;, tỉnh Sơn La rất tr&acirc;n trọng, biết ơn v&agrave; ghi nhận &ldquo;tấm l&ograve;ng v&agrave;ng của c&aacute;c mạnh thường qu&acirc;n&rdquo; chung tay hỗ trợ, gi&uacute;p đỡ c&aacute;c em học sinh v&agrave; nh&agrave; trường.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221128160854-638052485344164493.jpg" style="height:346px; width:650px" /></p>

<p><em>Chung tay x&acirc;y dựng lớp học mới, an to&agrave;n để c&aacute;c em nhỏ y&ecirc;n t&acirc;m tiếp tục l&ecirc;n lớp theo đuổi b&agrave;i giảng</em></p>

<p><em>*Sau khi ho&agrave;n tất chiến dịch k&ecirc;u gọi đ&oacute;ng g&oacute;p, to&agrave;n bộ số Heo V&agrave;ng sẽ được CEO HN6 quy đổi th&agrave;nh 430.000.000 đồng để triển khai thực hiện chương tr&igrave;nh. Ch&uacute;ng t&ocirc;i sẽ cập nhật th&ecirc;m th&ocirc;ng tin về tiến độ dự &aacute;n đến Qu&yacute; vị trong thời gian sớm nhất.</em></p>
', CAST(N'2022-10-20' AS Date), CAST(N'2023-01-20' AS Date), 86000000.0000, N'1', N'admin/media/thumbnail/2.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'1')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (3, N'1', N'Đào tạo chăm sóc trực tuyến, kỹ năng số cho người khuyết tật và người chăm sóc tại Bình Định, Quảng Nam và Kon Tum.', N'<p>❤️&nbsp;C&ugrave;ng chung tay quy&ecirc;n g&oacute;p kinh ph&iacute; t&agrave;i trợ điện thoại th&ocirc;ng minh để thay đổi cuộc sống người khuyết tật v&agrave; người chăm s&oacute;c tại B&igrave;nh Định, Quảng Nam v&agrave; Kon Tum, gi&uacute;p người khuyết tật được chăm s&oacute;c tốt hơn, được kết nối, giảm g&aacute;nh nặng cho người chăm s&oacute;c.</p>

<p>Kh&ocirc;ng được may mắn như những người kh&aacute;c, cuộc đời của những người khuyết tật (NKT) trải qua nhiều kh&oacute; khăn v&agrave; vất vả. Họ phải tự m&igrave;nh đối mặt v&agrave; l&agrave;m quen với mọi điều trong cuộc sống. Thế nhưng khi c&ocirc;ng nghệ ng&agrave;y c&agrave;ng ph&aacute;t triển, mọi th&ocirc;ng tin v&agrave; kiến thức đều c&oacute; thể sử dụng những thiết bị cầm tay như điện thoại di động để tra cứu th&igrave; thiệt th&ograve;i của NKT sẽ c&ograve;n nh&acirc;n l&ecirc;n nhiều lần hơn.&nbsp;</p>

<p><strong>Những kh&oacute; khăn bất cập khi Người khuyết tật v&agrave; Người chăm s&oacute;c kh&ocirc;ng c&oacute; thiết bị di động</strong></p>

<p>C&ocirc; Nguyễn Thị Thủy, NKT tại x&atilde; Ho&agrave;i Thanh T&acirc;y, thị x&atilde; Ho&agrave;i Nhơn, tỉnh B&igrave;nh Định từng chia sẻ với ch&uacute;ng t&ocirc;i: &ldquo;Người khuyết tật như c&ocirc; rất cần điện thoại để biết tra cứu l&uacute;c n&agrave;o b&atilde;o đến con &agrave;. Mấy ng&agrave;y nay c&ocirc; kh&ocirc;ng biết th&ocirc;ng tin n&ecirc;n khổ lắm, c&ocirc; muốn biết l&uacute;c mưa gi&oacute;, nơi n&agrave;o gi&uacute;p được c&ocirc; kh&ocirc;ng, với lại gọi người gi&uacute;p đỡ nữa. C&ocirc; tự chăm s&oacute;c m&igrave;nh chứ kh&ocirc;ng c&oacute; ai chăm s&oacute;c cả, n&ecirc;n nếu c&oacute; điện thoại, c&ocirc; cũng c&oacute; thể xem tập huấn chăm s&oacute;c ở nh&agrave; v&igrave; c&ocirc; kh&ocirc;ng tự đi được, rồi c&oacute; g&igrave; c&oacute; thể theo d&otilde;i th&ocirc;ng tin từ trạm y tế, hiểu hơn, biết hơn về bệnh tật m&igrave;nh đang gặp phải. C&ocirc; đi đứng kh&ocirc;ng được, nhiều khi gọi anh em qua gi&uacute;p nhưng kh&ocirc;ng c&oacute; h&igrave;nh ảnh để họ hiểu t&igrave;nh trạng đang ra sao. C&ocirc; cũng đang nhận l&agrave;m nhựa cho nh&agrave; m&aacute;y, đang kết nối mấy người khuyết tật để c&ugrave;ng l&agrave;m đ&acirc;y. C&ocirc; nghĩ điện thoại sẽ gi&uacute;p c&ocirc; nhiều lắm.&rdquo;&nbsp;</p>

<p>Kh&ocirc;ng chỉ c&oacute; c&ocirc; Thủy, những người chăm s&oacute;c (NCS) người khuyết tật cũng gặp nhiều kh&oacute; khăn khi kh&ocirc;ng c&oacute; thiết bị để tra cứu th&ocirc;ng tin khi cần thiết. C&ocirc; Nguyễn Thị Nguyệt NCS của ch&uacute; Huỳnh Bời, NKT tại x&atilde; Ho&agrave;i Hảo cho biết: &ldquo;Gi&aacute; như gia đ&igrave;nh c&ocirc; c&oacute; phương tiện để t&igrave;m hiểu, t&igrave;m kiếm trợ gi&uacute;p về y tế, rồi tra cứu, t&igrave;m kiếm những th&ocirc;ng tin, kiến thức về chăm s&oacute;c mọi thời điểm cần thiết. Đối với c&ocirc;, đ&acirc;y l&agrave; nhu cầu thiết thực, cần thiết v&ocirc; c&ugrave;ng. C&oacute; hướng dẫn th&igrave; những l&uacute;c đau ốm mới biết xử l&yacute; sao. Rồi nhiều khi c&oacute; bệnh t&igrave;nh, bối rối kh&ocirc;ng biết c&oacute; thể m&ocirc; tả, chỉ lại cho mọi người sao, kh&ocirc;ng biết ghi lại ở đ&acirc;u để xem.&rdquo;</p>

<p><strong>Chung tay thay đổi cuộc đời của nhiều Người khuyết tật tại B&igrave;nh Định, Quảng Nam v&agrave; Kon Tum</strong></p>

<p>C&ocirc; Thủy, c&ocirc; Nguyệt l&agrave; hai trong số nhiều NKT v&agrave; NCS đ&atilde; b&agrave;y tỏ với Dự &aacute;n &ldquo;H&atilde;y nắm tay t&ocirc;i&rdquo; nguyện vọng được c&oacute; một thiết bị kết nối, lưu trữ h&igrave;nh ảnh v&agrave; xem được hướng dẫn về chăm s&oacute;c tại nh&agrave;, để gi&uacute;p họ x&oacute;a bỏ r&agrave;o cản về khả năng đi lại trong việc học hỏi về chăm s&oacute;c v&agrave; t&igrave;m kiếm kết nối x&atilde; hội, y tế. Đ&acirc;y l&agrave; những chức năng m&agrave; một chiếc điện thoại th&ocirc;ng minh c&oacute; thể mang lại. Điện thoại th&ocirc;ng minh &ndash; một thiết bị tưởng như kh&ocirc;ng thể thiếu trong cuộc sống của mỗi người hiện nay, lại l&agrave; ước mơ của những người khuyết tật tại c&aacute;c v&ugrave;ng qu&ecirc; ở B&igrave;nh Định, Quảng Nam v&agrave; Kon Tum - c&aacute;c tỉnh bị ảnh hưởng nặng bởi chất độc m&agrave;u da cam.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221122204209-638047465294073428.jpg" style="height:346px; width:650px" /><em>Ước mơ của nhiều Người khuyết tật l&agrave; c&oacute; chiếc điện thoại th&ocirc;ng minh để tiếp cận với nhiều th&ocirc;ng tin hơn</em></p>

<p>Tr&ecirc;n thực tế, kh&ocirc;ng chỉ cải thiện đ&aacute;ng kể về chăm s&oacute;c, nhiều trường hợp cuộc sống v&agrave; sinh kế của NKT đ&atilde; được cải thiện đ&aacute;ng kể nhờ việc c&oacute; điện thoại th&ocirc;ng minh v&agrave; Internet. C&oacute; những trường hợp ti&ecirc;u biểu như anh Nguyễn Ch&aacute;nh T&iacute;n tại Ho&agrave;i Nhơn - B&igrave;nh Định, ch&agrave;ng trai khuyết tật từ việc nằm liệt giường đến trở th&agrave;nh trụ cột kinh tế của gia đ&igrave;nh v&agrave; nguồn cảm hứng của h&agrave;ng triệu người nhờ kinh doanh v&agrave; chia sẻ c&acirc;u chuyện của ch&iacute;nh m&igrave;nh tr&ecirc;n Internet. Anh T&iacute;n từng n&oacute;i: &ldquo;Tôi đã giam thân xác của mình trong bốn bức tường suốt 10 năm qua, nhưng tôi chưa hề giam tâm hồn, tinh thần. Tôi hướng ra thế giới bên ngoài bằng internet. Tôi kết nối với mọi người bằng Facebook, Zalo. Đối với tôi đằng sau mỗi rào cản của cuộc đời là mỗi một cách giải quyết thú vị&rdquo;. Ở v&ugrave;ng địa b&agrave;n dự &aacute;n, do ảnh hưởng thường xuy&ecirc;n của b&atilde;o lũ, c&aacute;c thiết bị th&ocirc;ng minh sẽ gi&uacute;p người khuyết tật c&oacute; thể chủ động tiếp cận th&ocirc;ng tin ph&ograve;ng chống thi&ecirc;n tai, b&atilde;o lũ, tr&aacute;nh được rất nhiều trường hợp đ&aacute;ng tiếc xảy ra, cũng như c&oacute; thể t&igrave;m kiếm sự trợ gi&uacute;p khi gặp kh&oacute; khăn, khi cần hỗ trợ về y tế. Người kh&ocirc;ng khuyết tật cần điện thoại một, người khuyết tật c&ograve;n cần điện thoại gấp 10, 100 lần như thế.</p>

<p><strong>Chung tay hỗ trợ người khuyết tật c&oacute; một cơ hội tiếp cận với đ&agrave;o tạo - t&igrave;m kiếm th&ocirc;ng tin về chăm s&oacute;c, t&igrave;m kiếm trợ gi&uacute;p về y tế v&agrave; kết nối x&atilde; hội</strong></p>

<p>Tại Việt Nam, khoảng 6.2 triệu người tr&ecirc;n hai tuổi sống với khuyết tật, trong đ&oacute; 28,3% l&agrave; trẻ em v&agrave; gần 29% l&agrave; người khuyết tật nặng v&agrave; đặc biệt nặng. Người khuyết tật phải đối mặt với những th&aacute;ch thức như kh&oacute; khăn trong tiếp cận y tế cơ bản v&agrave; hạn chế trong kỹ năng chăm s&oacute;c bản th&acirc;n. Đ&atilde; c&oacute; những quan s&aacute;t v&agrave; ghi nhận về chăm s&oacute;c kh&ocirc;ng đạt ti&ecirc;u chuẩn, chất lượng thấp, c&aacute;c h&agrave;nh vi kh&ocirc;ng ph&ugrave; hợp hoặc lạm dụng. C&aacute;c hậu quả hoặc biến chứng về sức khỏe như tai nạn, ng&atilde;, v&agrave; đ&ocirc;i khi l&agrave; c&aacute;c vụ tự tử đ&atilde; được b&aacute;o c&aacute;o.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221209110908-638061809483725542.jpg" style="height:346px; width:650px" /></p>

<p><em>Ph&aacute;t dụng cụ trợ gi&uacute;p cho NKT tại Ho&agrave;i Nhơn - B&igrave;nh Định</em></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221209110935-638061809754556231.jpg" style="height:346px; width:650px" /></p>

<p><em>Đ&agrave;o tạo cho NCS tại Ho&agrave;i Nhơn - B&igrave;nh Định</em></p>

<p>Dự &aacute;n &ldquo;H&atilde;y nắm tay t&ocirc;i&rdquo; với mục ti&ecirc;u ch&iacute;nh l&agrave; cải thiện cuộc sống NKT v&agrave; NCS th&ocirc;ng qua cải thiện về chăm s&oacute;c v&agrave; kết nối x&atilde; hội cho NKT đ&atilde; hỗ trợ cho 2600 NKT nặng ở c&aacute;c tỉnh bị ảnh hưởng bởi chất độc m&agrave;u da cam (B&igrave;nh Định, Quảng Nam, Kon Tum). Dự &aacute;n x&acirc;y dựng nền tảng đ&agrave;o tạo trực tuyến cho chăm s&oacute;c tại nh&agrave; (CSTN) v&agrave; thực h&agrave;nh kết nối x&atilde; hội. Với nền tảng trực tuyến, nhiều NCS sẽ c&oacute; cơ hội tiếp cận với đ&agrave;o tạo về chăm s&oacute;c hơn, x&oacute;a đi r&agrave;o cản từ khả năng đi lại. Đồng thời, dự &aacute;n cũng x&acirc;y dựng hệ thống cộng t&aacute;c vi&ecirc;n chăm s&oacute;c tại nh&agrave;.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221122204253-638047465735691779.jpg" style="height:346px; width:650px" /></p>

<p><em>C&ugrave;ng dự &aacute;n &ldquo;H&atilde;y nắm tay t&ocirc;i&rdquo; trao tặng điện thoại th&ocirc;ng tin cho NKT v&agrave; NCS tại B&igrave;nh Định, Quảng Nam v&agrave; Kon Tum</em></p>

<p>Tuy nhi&ecirc;n, đa số NKT v&agrave; NCS đều thuộc diện kinh tế ngh&egrave;o hoặc cận ngh&egrave;o v&agrave; r&agrave;o cản về đi lại khiến họ kh&ocirc;ng thể tham gia đ&agrave;o tạo về chăm s&oacute;c trực tiếp lẫn trực tuyến, cũng như gặp kh&oacute; khăn trong việc kết nối với người chăm s&oacute;c v&agrave; những người c&oacute; thể gi&uacute;p đỡ khi cần. Để mang đến cơ hội thay đổi cuộc sống cho NKT, dự &aacute;n &ldquo;H&atilde;y nắm tay t&ocirc;i&rdquo; đưa ra chương tr&igrave;nh trao tặng điện thoại th&ocirc;ng minh cho khoảng 750 NKT v&agrave; NCS tại B&igrave;nh Định, Quảng Nam v&agrave; Kon Tum. Dự &aacute;n đ&atilde; lựa chọn mẫu điện thoại với gi&aacute; th&agrave;nh hợp l&yacute; nhất (khoảng hơn 2 triệu đồng/chiếc). Sau khi NKT v&agrave; NCS được nhận điện thoại, dự &aacute;n sẽ hỗ trợ kinh ph&iacute; viễn th&ocirc;ng v&agrave; đ&agrave;o tạo 4 kỹ năng số cần thiết theo bộ ti&ecirc;u chuẩn của UNESCO để đảm bảo NKT v&agrave; NCS tận dụng được mọi chức năng của điện thoại th&ocirc;ng minh để thay đổi cuộc sống. Ngo&agrave;i ra, NKT sẽ được hỗ trợ cải thiện sinh kế v&agrave; sống độc lập.</p>

<p>Để l&agrave;m được điều n&agrave;y, dự &aacute;n mong muốn c&oacute; thể g&acirc;y quỹ 3.125.000 Heo V&agrave;ng từ cộng đồng Heo Đất MoMo. Số Heo V&agrave;ng n&agrave;y sẽ được quy đổi tương đương th&agrave;nh 500.000.000 VNĐ. V&igrave; vậy, dự &aacute;n mong muốn nhận được sự hỗ trợ từ cộng đồng Y&ecirc;u Heo Đất để c&oacute; thể t&agrave;i trợ thiết bị điện thoại th&ocirc;ng minh với chức năng cơ bản cho người chăm s&oacute;c hoặc người khuyết tật.&nbsp;</p>

<p>Dựa tr&ecirc;n kinh nghiệm, dự &aacute;n cam kết sử dụng tất cả kinh ph&iacute; quy&ecirc;n g&oacute;p cho việc mua thiết bị điện thoại, trao điện thoại. Tất cả điện thoại đ&atilde; được trao tặng sẽ được c&ocirc;ng khai, minh bạch với m&atilde; số cụ thể v&agrave; c&oacute; thể tra cứu, mọi hoạt động của dự &aacute;n sẽ được cập nhật cụ thể tr&ecirc;n website. Th&ocirc;ng tin người nhận cũng sẽ được c&ocirc;ng khai dưới sự đồng &yacute; của mỗi người nhận cụ thể.</p>
', CAST(N'2022-10-28' AS Date), CAST(N'2022-12-28' AS Date), 31250000.0000, N'1', N'admin/media/thumbnail/3.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'2')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (4, N'1', N'Hoàn thiện cơ sở vật chất Quán trọ Sài Gòn bao dung để các cụ sinh sống', N'<p>❤️&nbsp;C&ugrave;ng chung tay với Trăng Khuyết ho&agrave;n thiện cơ sở vật chất Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung để c&aacute;c cụ gi&agrave; neo đơn c&oacute; th&ecirc;m một ng&ocirc;i nh&agrave; mới để ở, để được chăm s&oacute;c.</p>

<p><strong>Nhiều mảnh đời đang chờ được nương n&aacute;u Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung</strong></p>

<p>Sau thời gian d&agrave;i thi c&ocirc;ng, Qu&aacute;n trọ S&agrave;i G&ograve;n đ&atilde; ho&agrave;n th&agrave;nh phần x&acirc;y dựng cơ bản. Vậy l&agrave; sẽ c&oacute; th&ecirc;m một qu&aacute;n trọ với sức chứa 40 giường sắp đưa v&agrave;o hoạt động. Trăng Khuyết đ&atilde; nhận được rất nhiều hồ sơ đăng k&iacute; gửi về với mong mỏi t&igrave;m nơi chốn dừng ch&acirc;n sau những năm d&agrave;i th&aacute;ng rộng sống vất vả khổ sở của c&aacute;c cụ gi&agrave;.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140003-638012664032165825.jpg" style="height:346px; width:650px" /></p>

<p><br />
<img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140025-638012664252481370.jpg" style="height:346px; width:650px" /></p>

<p><em>Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung đ&atilde; ho&agrave;n thiện phần x&acirc;y dựng cơ bản</em></p>

<p>D&ugrave; vậy, số lượng đăng k&yacute; nhiều khiến Trăng Khuyết vừa mừng vừa lo. Mừng v&igrave; sẽ c&oacute; th&ecirc;m nhiều mảnh đời được gi&uacute;p đỡ, lo v&igrave; c&ocirc;ng tr&igrave;nh chỉ mới ho&agrave;n thiện phần sửa chữa, x&acirc;y dựng cơ bản. Trăng Khuyết dự t&iacute;nh rằng Qu&aacute;n trọ sẽ ho&agrave;n thiện v&agrave; được đưa v&agrave;o sử dụng trong qu&yacute; 4 năm 2022. B&agrave;i to&aacute;n kinh ph&iacute; v&agrave; việc chạy đua với thời gian l&agrave; thử th&aacute;ch rất lớn với Trăng Khuyết trong thời điểm n&agrave;y. Bởi v&igrave; b&ecirc;n trong cơ sở vật chất để phục vụ cho nhu cầu nghỉ ngơi, sinh hoạt, nấu nướng, vệ sinh&hellip; đều chưa được thực hiện.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140103-638012664632595131.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140113-638012664732120302.jpg" style="height:346px; width:650px" /></p>

<p><br />
<img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140126-638012664861874868.jpg" style="height:346px; width:650px" /></p>

<p><em>Sơ đồ bố tr&iacute; giường ngủ cho c&aacute;c cụ tại Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung</em></p>

<p>V&igrave; ngo&agrave;i phần cơ bản th&igrave; cơ sở vật chất b&ecirc;n trong đ&oacute;ng một vai tr&ograve; quan trọng để tạo n&ecirc;n kh&ocirc;ng gian sống thoải m&aacute;i, đầy đủ nhất đảm bảo mọi sinh hoạt của c&aacute;c cụ. Nguồn kinh ph&iacute; cho dự &aacute;n lần n&agrave;y l&agrave; phục vụ cho việc mua sắm trang thiết bị cơ sở vật chất thiết yếu cho Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung như: giường, nệm&hellip; đảm bảo một giấc ngủ ngon,&nbsp; tủ, b&agrave;n ghế, đồ d&ugrave;ng c&aacute; nh&acirc;n, hệ thống đ&egrave;n, quạt, tivi, vật dụng nh&agrave; bếp&hellip; phục vụ được mọi nhu cầu ăn uống, sinh hoạt v&agrave; nghỉ ngơi&hellip;&nbsp;</p>

<p><strong>C&ugrave;ng chung tay ho&agrave;n thiện cơ sở vật chất Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung để c&aacute;c cụ gi&agrave; neo đơn c&oacute; nơi nương tựa</strong></p>

<p>M&ugrave;a mưa đ&atilde; về với S&agrave;i G&ograve;n, sự khắc nghiệt của thời tiết sẽ khiến cuộc sống của c&aacute;c cụ trở n&ecirc;n kh&oacute; khăn hơn rất nhiều. Với mong muốn Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung của Trăng Khuyết sớm ho&agrave;n tất, sớm để c&aacute;c cụ c&oacute; nơi nương tựa, V&iacute; MoMo phối hợp với Quỹ Từ Thiện &amp; BTXH Trăng Khuyết k&ecirc;u gọi sự chung tay hỗ trợ của c&aacute;c nh&agrave; hảo t&acirc;m th&ocirc;ng qua chương tr&igrave;nh ho&agrave;n thiện cơ sở vật chất cho Qu&aacute;n Trọ S&agrave;i G&ograve;n bao dung, đem lại m&aacute;i nh&agrave; ấm c&uacute;ng, y&ecirc;n b&igrave;nh mới cho những cụ gi&agrave; bất hạnh.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140215-638012665350627176.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140237-638012665577175299.jpg" style="height:346px; width:650px" /></p>

<p><br />
<img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221013140250-638012665707550030.jpg" style="height:346px; width:650px" /></p>

<p><em>C&aacute;c cụ gi&agrave; neo đơn tại qu&aacute;n trọ Trăng Khuyết rất cần sự gi&uacute;p đỡ từ cộng đồng</em></p>

<p>Để l&agrave;m được điều n&agrave;y, Trăng Khuyết k&ecirc;u gọi sự gi&uacute;p đỡ từ cộng đồng Heo Đất MoMo quy&ecirc;n g&oacute;p 5.000.000 Heo V&agrave;ng tr&ecirc;n Heo Đất MoMo. To&agrave;n bộ số Heo V&agrave;ng n&agrave;y sẽ được nh&agrave; t&agrave;i trợ quy đổi th&agrave;nh 600.000.000 đồng. Ngo&agrave;i ra, ch&uacute;ng t&ocirc;i c&ograve;n k&ecirc;u gọi sự chung tay của c&aacute;c mạnh thường qu&acirc;n, c&aacute;c nh&agrave; hảo t&acirc;m số tiền l&agrave; 160.000.000 đồng tr&ecirc;n Tr&aacute;i Tim MoMo. Trăng Khuyết dự kiến số tiền đạt được 760.000.000 đồng sẽ l&agrave; chi ph&iacute; để mua sắm cơ sở vật chất cho Qu&aacute;n trọ S&agrave;i G&ograve;n bao dung.</p>

<p>Rất mong c&aacute;c mạnh thường qu&acirc;n, c&aacute;c nh&agrave; hảo t&acirc;m sẽ đồng h&agrave;nh c&ugrave;ng chiến dịch lần n&agrave;y của MoMo v&agrave; Trăng Khuyết để c&oacute; thể gi&uacute;p đỡ được nhiều hơn nữa những cụ gi&agrave; sống lang thang. D&ugrave; số tiền c&oacute; l&agrave; bao nhi&ecirc;u cũng đều đ&aacute;ng tr&acirc;n qu&yacute;, d&ugrave; đ&oacute;ng g&oacute;p n&agrave;o cũng y&ecirc;u thương để c&ugrave;ng chung tay x&acirc;y dựng n&ecirc;n ng&ocirc;i nh&agrave; che nắng che mưa cho c&aacute;c cụ</p>
', CAST(N'2022-10-28' AS Date), CAST(N'2022-12-28' AS Date), 50000000.0000, N'1', N'admin/media/thumbnail/4.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'2')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (5, N'2', N'Cùng chung tay quyên góp xây mới phòng học ở trường TH và THCS Chiềng Lương - tỉnh Sơn La', N'<p>❤️&nbsp;Chung tay ủng hộ tiền, x&acirc;y mới ph&ograve;ng học trường TH và THCS Chiềng Lương - tỉnh Sơn La để c&aacute;c b&eacute; c&oacute; ph&ograve;ng học ki&ecirc;n cố, an to&agrave;n v&agrave; tr&agrave;n ngập &aacute;nh s&aacute;ng.</p>

<p><strong>Từ ước mơ lớp học mới của c&aacute;c em học sinh x&atilde; Chiềng Lương</strong></p>

<p>Trường TH v&agrave; THCS Chiềng Lương được đặt tr&ecirc;n địa b&agrave;n x&atilde; Chiềng Lương - huyện Mai Sơn - tỉnh Sơn La, c&aacute;ch trung t&acirc;m huyện lỵ đến 21 c&acirc;y số. Đ&acirc;y l&agrave; x&atilde; thuộc khu vực III kh&oacute; khăn với 19 bản v&agrave; 5 d&acirc;n tộc: Th&aacute;i, M&ocirc;ng, Khơ M&uacute;, Sinh Mun v&agrave; Kinh c&ugrave;ng sinh sống.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220906145235-637980727550727698.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220906145248-637980727683952288.jpg" style="height:346px; width:650px" /></p>

<p><em>H&igrave;nh ảnh từ 1 lớp học của Điểm trường x&atilde; Chiềng Lương.&nbsp;</em></p>

<p>Trong năm học 2021 &ndash; 2022, nh&agrave; trường c&oacute; 36 lớp với 1.092 học sinh. Trong đ&oacute;, c&oacute; 09 ph&ograve;ng b&aacute;n ki&ecirc;n cố v&agrave; 02 ph&ograve;ng học tạm do d&acirc;n bản chung tay đ&oacute;ng g&oacute;p x&acirc;y dựng. Trải qua hơn 17 năm tuổi, t&igrave;nh trạng c&aacute;c ph&ograve;ng học ấy đều đang xuống cấp trầm trọng. M&aacute;i thấm dột, tường sập đổ, nhiều vị tr&iacute; phải tận dụng c&aacute;c loại vật liệu kh&aacute;c để che chắn tạm thời. C&aacute;c v&aacute;n gỗ l&agrave;m v&aacute;ch theo thời gian đ&atilde; trở n&ecirc;n mục n&aacute;t, tạo n&ecirc;n nhiều kẽ hở lớn, kh&ocirc;ng c&ograve;n đủ sức che chắn cho c&aacute;c em. Cột gỗ chống nh&agrave; th&igrave; li&ecirc;u xi&ecirc;u, kh&ocirc;ng đảm bảo an to&agrave;n cho thầy tr&ograve; x&atilde; Chiềng Lương học tập.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220906145319-637980727998525683.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220906145333-637980728133566877.jpg" style="height:346px; width:650px" /></p>

<p><em>C&aacute;c ph&ograve;ng học tối tăm, đổ n&aacute;t v&agrave; v&ocirc; c&ugrave;ng sơ s&agrave;i.&nbsp;</em></p>

<p>Khu k&yacute; t&uacute;c x&aacute; của c&aacute;c em cũng v&ocirc; c&ugrave;ng sơ s&agrave;i. Khu k&yacute; t&uacute;c được x&acirc;y trong khu nh&agrave; đ&atilde; cũ, tường ẩm mốc, tối tăm v&agrave; b&iacute; b&aacute;ch. Cơ sở vật chất cũng thiếu thốn v&ocirc; c&ugrave;ng. Trường kh&ocirc;ng c&oacute; g&igrave; nhiều ngo&agrave;i v&agrave;i chiếc giường tầng v&agrave; một v&agrave;i vật dụng cơ bản để trẻ c&oacute; thể sinh hoạt.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220906145400-637980728404597443.jpg" style="height:346px; width:650px" /></p>

<p><em>C&aacute;c v&aacute;n gỗ nứt vỡ v&agrave; bung ra, kh&ocirc;ng đủ an to&agrave;n cho c&aacute;c em học tập.&nbsp;</em></p>

<p>Trong tương lai gần, trẻ nhỏ x&atilde; Chiềng Lương đến tuổi đi học sẽ tăng l&ecirc;n, điều kiện học tập sinh hoạt của c&aacute;c em cũng theo đ&oacute; m&agrave; ng&agrave;y c&agrave;ng kh&oacute; khăn chồng chất. Niềm y&ecirc;u th&iacute;ch học tập, ước mơ được học tập trong những lớp học ki&ecirc;n cố, sạch sẽ v&agrave; tr&agrave;n ngập &aacute;nh s&aacute;ng như c&aacute;c bạn đồng trang lứa, giờ đ&acirc;y cũng thật xa vời.&nbsp;</p>

<p><strong>Đến nỗ lực chung tay g&oacute;p sức, hiện thực h&oacute;a những lớp học mới cho học sinh x&atilde; Chiềng Lương</strong></p>

<p>Thấu hiểu ho&agrave;n cảnh của c&aacute;c em nhỏ x&atilde; Chiềng Lương, cũng như giấc mơ học tập của c&aacute;c em, V&iacute; MoMo hợp t&aacute;c c&ugrave;ng Trung t&acirc;m T&igrave;nh nguyện Quốc Gia, Dự &aacute;n Sức mạnh 2000 v&agrave; dự &aacute;n Nu&ocirc;i em l&ecirc;n kế hoạch x&acirc;y dựng 02 ph&ograve;ng học để khắc phục điều kiện học tập cho trẻ nhỏ.&nbsp;</p>

<p>Tổng chi ph&iacute; của dự &aacute;n l&agrave; 350 triệu VND. Trong chiến dịch lần n&agrave;y, ch&uacute;ng t&ocirc;i chia th&agrave;nh 2 đợt g&acirc;y quỹ. Hiện nay, Anh Chị nu&ocirc;i Dự &aacute;n Nu&ocirc;i Em sẽ quy đổi số tiền tương ứng 150.000.000 đồng cho dự &aacute;n đ&atilde; diễn ra tr&ecirc;n Heo Đất MoMo. Ch&uacute;ng t&ocirc;i mong muốn c&oacute; thể g&acirc;y quỹ th&ecirc;m 200.000.000 đồng tr&ecirc;n Tr&aacute;i Tim MoMo để ph&ograve;ng học mới sớm được khởi c&ocirc;ng x&acirc;y dựng.&nbsp;</p>

<p>Mọi sự đ&oacute;ng g&oacute;p của c&aacute;c bạn đều g&oacute;p phần kh&ocirc;ng nhỏ x&acirc;y n&ecirc;n ước mơ ph&ograve;ng học khang trang, an to&agrave;n cho c&aacute;c b&eacute; x&atilde; Chiềng Lương - huyện Mai Sơn - tỉnh Sơn La. H&atilde;y c&ugrave;ng ch&uacute;ng t&ocirc;i chung tay g&oacute;p sức cổ vũ c&aacute;c em học tập!&nbsp;</p>
', CAST(N'2022-11-01' AS Date), CAST(N'2023-02-01' AS Date), 100000000.0000, N'1', N'admin/media/thumbnail/5.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'1')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (6, N'2', N'Cùng Ba Đình Cares, Ford Motor Company Fund và Vemba góp Heo Vàng xây dựng điểm trường TH Pa Phang 2, tỉnh Lai Châu', N'<p>❤️&nbsp;C&ugrave;ng Ba Đ&igrave;nh Cares, Ford Motor Company Fund v&agrave; Vemba g&oacute;p Heo v&agrave;ng x&acirc;y dựng điểm trường TH Pa Phang 2, tỉnh Lai Ch&acirc;u để c&aacute;c b&eacute; c&oacute; ph&ograve;ng học khang trang, sạch sẽ hơn.</p>

<p><strong>Ước mơ ph&ograve;ng học khang trang của thầy tr&ograve; bản Pa Phang 2</strong></p>

<p>Điểm trường TH Pa Phang 2 thuộc PTDTBT Tiểu học Ph&igrave;n Hồ, tọa lạc tại x&atilde; Ph&igrave;n Hồ, huyện S&igrave;n Hồ, tỉnh Lai Ch&acirc;u. Đ&acirc;y ch&iacute;nh l&agrave; nơi cư tr&uacute; của 166 hộ d&acirc;n với 882 nh&acirc;n khẩu đều l&agrave; đồng b&agrave;o người M&ocirc;ng. Tr&igrave;nh độ d&acirc;n tr&iacute; của người d&acirc;n vẫn c&ograve;n nhiều hạn chế, nghề nghiệp chủ yếu l&agrave; l&agrave;m nương. Dẫu lu&ocirc;n chịu kh&oacute; l&agrave;m ăn nhưng tỷ lệ hộ ngh&egrave;o vẫn l&ecirc;n tới 55,4% tương đương với 92 hộ; hộ cận ngh&egrave;o l&agrave; 24,7% tương đương với 41 hộ. Tuy kh&oacute; khăn, vất vả l&agrave; thế nhưng con người nơi đ&acirc;y hiền l&agrave;nh, thật th&agrave;, chất ph&aacute;t, chịu kh&oacute; l&agrave;m ăn đặc biệt lu&ocirc;n nu&ocirc;i dưỡng tinh thần hiếu học cho con em ngay từ thuở b&eacute;.&nbsp;&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220914114837-637987529171874245.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220914114850-637987529306796611.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220914114900-637987529407451039.jpg" style="height:346px; width:650px" /></p>

<p><em>Ph&ograve;ng học xuống cấp Điểm trường TH Pa Phang 2 thuộc PTDTBT Tiểu học Ph&igrave;n Hồ.</em></p>

<p>Điểm trường hiện nay c&oacute; 2 ph&ograve;ng học với 80 HS từ lớp 1, lớp 2 v&agrave; lớp 3 v&agrave; c&oacute; 2 ph&ograve;ng học nh&agrave; x&acirc;y dựng cấp 4 v&agrave; 1 ph&ograve;ng học nh&agrave; tạm l&agrave;m bằng gỗ, do nh&acirc;n d&acirc;n đ&oacute;ng g&oacute;p l&agrave;m từ năm học 2002 - 2003. Ph&ograve;ng học chắp v&aacute; từ gỗ miếng, t&ocirc;n miếng, tr&ecirc;n che bạt, dưới nền đất th&ocirc; sơ v&agrave; thiếu thốn. Điểm trường c&aacute;ch trung t&acirc;m x&atilde; l&ecirc;n tới 27 km n&ecirc;n chặng đường đến với con chữ của c&aacute;c em nhỏ v&ocirc; c&ugrave;ng gian lao, vất vả.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220914114926-637987529666547949.jpg" style="height:346px; width:650px" /></p>

<p><em>Nhỏ hẹp, chật chội, kh&ocirc;ng c&ograve;n đảm bảo ki&ecirc;n cố cho c&aacute;c b&eacute; học tập.&nbsp;</em></p>

<p>H&igrave;nh ảnh ph&ograve;ng học tạm đơn sơ, xuống cấp, dường như kh&ocirc;ng thể sử dụng khiến đo&agrave;n khảo s&aacute;t Heo Đất thấy x&oacute;t xa v&ocirc; c&ugrave;ng. Tường được l&agrave;m từ 2 lớp, bằng t&ocirc;n b&ecirc;n ngo&agrave;i v&agrave; bằng gỗ gh&eacute;p tạm b&ecirc;n trong. Tất cả đều đ&atilde; rỉ s&eacute;t, mục ruỗng v&agrave; nứt nẻ. M&ugrave;a đ&ocirc;ng th&igrave; gi&oacute; lạnh l&ugrave;a v&agrave;o lạnh ảnh hưởng rất lớn đến việc hoạt động dạy v&agrave; học v&agrave; nghỉ ăn bữa trưa của học sinh...&nbsp; Đặc biệt khi trời mưa b&atilde;o lớn, dường như gi&oacute; c&oacute; thể cuốn phăng cả ph&ograve;ng học. Nền l&agrave; đất n&ecirc;n mỗi khi tới m&ugrave;a mưa, kh&ocirc;ng chỉ bẩn m&agrave; c&ograve;n trơn trượt, kh&ocirc;ng đảm bảo an to&agrave;n.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220914114953-637987529936689446.jpg" style="height:346px; width:650px" /></p>

<p><em>M&ugrave;a đ&ocirc;ng th&igrave; gi&oacute; lạnh l&ugrave;a v&agrave;o ảnh hưởng rất lớn đến việc hoạt động dạy v&agrave; học v&agrave; nghỉ ăn bữa trưa của học sinh...&nbsp;</em></p>

<p>Hơn thế nữa, d&ugrave; đ&atilde; c&oacute; điện lưới nhưng cơ sở vật chất sập xệ kh&ocirc;ng thể chăng d&acirc;y, c&aacute;c em vẫn phải sử dụng &aacute;nh nắng mặt trời để học tập, l&uacute;c mờ l&uacute;c ảo, kh&ocirc;ng đạt ti&ecirc;u chuẩn trường lớp. B&ecirc;n trong ph&ograve;ng học gần như mọi đồ đạc, cơ sở vật chất phục vụ giảng dạy đều được sử dụng trong khoảng thời gian d&agrave;i n&ecirc;n mang vẻ ngo&agrave;i cũ kỹ. B&agrave;n học nhuốm m&agrave;u thời gian, c&aacute;c đinh v&iacute;t đang dần bung ra, thầy tr&ograve; phải k&ecirc; gạch b&ecirc;n dưới để cố gắng khắc phục.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220914115018-637987530184989357.jpg" style="height:346px; width:650px" /></p>

<p><em>B&agrave;n học nhuốm m&agrave;u thời gian, c&aacute;c đinh v&iacute;t đang dần bung ra, thầy tr&ograve; phải k&ecirc; gạch b&ecirc;n dưới để cố gắng khắc phục.</em></p>

<p><strong>Chung tay g&oacute;p Heo V&agrave;ng x&acirc;y th&ecirc;m ph&ograve;ng học mới cho c&aacute;c em nhỏ điểm trường Pa Phang 2</strong></p>

<p>Thấu hiểu ho&agrave;n cảnh của c&aacute;c em nhỏ bản Pa Phang, x&atilde; Ph&igrave;n Hồ cũng như giấc mơ học tập của c&aacute;c em, Heo Đất MoMo hợp t&aacute;c c&ugrave;ng Dự &aacute;n Sức mạnh 2000, Ba Đ&igrave;nh Cares, Ford Motor Company Fund v&agrave; Vemba l&ecirc;n kế hoạch x&acirc;y dựng trường học mới khang trang để gi&uacute;p c&aacute;c em nhỏ c&oacute; m&ocirc;i trường học tập tốt hơn.&nbsp;</p>

<p>Để l&agrave;m được điều n&agrave;y, Heo Đất MoMo đặt mục ti&ecirc;u 2.300.000 Heo V&agrave;ng quy&ecirc;n g&oacute;p từ cộng đồng người d&ugrave;ng Heo Đất MoMo. Số Heo V&agrave;ng n&agrave;y sẽ được nh&agrave; t&agrave;i trợ Ba Đ&igrave;nh Cares, Ford Motor Company Fund v&agrave; Vemba quy đổi th&agrave;nh 230.000.000 đồng tiền mặt chi trả mọi chi ph&iacute; x&acirc;y dựng trường.</p>

<p>Mọi Heo V&agrave;ng của c&aacute;c bạn đều g&oacute;p phần gi&uacute;p c&aacute;c em nhỏ điểm trường Pa Phang 2 đến gần hơn với ước mơ trường mới. H&atilde;y chung tay c&ugrave;ng Heo Đất MoMo quy&ecirc;n g&oacute;p đủ Heo V&agrave;ng gi&uacute;p c&aacute;c em y&ecirc;n t&acirc;m học h&agrave;nh ngay!</p>
', CAST(N'2022-11-10' AS Date), CAST(N'2023-02-10' AS Date), 70000000.0000, N'1', N'admin/media/thumbnail/6.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'1')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (7, N'1', N'Góp Heo Vàng cùng AVAKids tặng 80 ca phẫu thuật trong Chiến dịch “Nụ Cười AVAKids"', N'<p>❤️&nbsp;C&aacute;c em nhỏ sinh ra đ&atilde; bị những khiếm khuyết tr&ecirc;n khu&ocirc;n mặt v&agrave; cơ thể, đang rất cần sự chung tay của cộng đồng Heo Đất MoMo c&ugrave;ng AVAKids, để c&oacute; thể tự tin trưởng th&agrave;nh như bao bạn nhỏ kh&aacute;c.</p>

<p><strong>C&acirc;u Chuyện Của Sớ - Cảm Ơn V&igrave; Một Lần Tin Tưởng</strong></p>

<p>Năm 2020, người thầy gi&aacute;o trẻ tuổi t&ecirc;n Quyết thuyết phục 2 gia đ&igrave;nh ở x&atilde; v&ugrave;ng cao Trung Chải, L&agrave;o Cai để đưa hai em nhỏ người đồng b&agrave;o d&acirc;n tộc thiểu số - Đ&agrave;i v&agrave; Sớ, sinh ra đ&atilde; bị những khiếm khuyết tr&ecirc;n khu&ocirc;n mặt v&agrave; cơ thể đến chương tr&igrave;nh phẫu thuật của Operation Smile. Những ng&agrave;y trong viện, thầy Quyết tần tảo chăm s&oacute;c từ miếng ăn, giấc ngủ đến tắm rửa cho c&aacute;c em như con m&igrave;nh. Với Sớ, thầy hẳn ưu tư v&agrave; lo lắng hơn v&igrave; em bị khe hở m&ocirc;i rất lớn, đ&atilde; 5 tuổi m&agrave; vẫn chưa được đi học phần v&igrave; gia đ&igrave;nh kh&oacute; khăn, phần v&igrave; em bị dị tật. Thầy t&acirc;m sự: &ldquo;Sớ m&agrave; cứ để thế n&agrave;y, kh&ocirc;ng được phẫu thuật th&igrave; tr&ecirc;n đ&oacute; người ta k&igrave; thị lắm.&rdquo;</p>

<p>May mắn thay, cả hai em b&eacute; đều được phẫu thuật th&agrave;nh c&ocirc;ng trong lần đầu ti&ecirc;n đến với chương tr&igrave;nh của Operation Smile. 3 thầy tr&ograve; dắt nhau trở về L&agrave;o Cai với niềm h&acirc;n hoan của những nụ cười mới. Người thầy qu&ecirc; Ph&uacute; Thọ vẫn quyết b&aacute;m bản để hỗ trợ việc học tập cho c&aacute;c em nhỏ v&agrave; gi&uacute;p đỡ c&aacute;c gia đ&igrave;nh c&ograve;n kh&oacute; khăn tr&ecirc;n ấy.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130153757-638054194771529950.jpg" style="height:346px; width:650px" /></p>

<p><em>Mang lại nụ cười - mang lại nhiều niềm tin hơn trong cuộc sống cho những em nhỏ kh&ocirc;ng may mắn</em></p>

<p>Th&aacute;ng 9/2021, một năm sau ng&agrave;y phẫu thuật, cả hai em nhỏ được đến trường c&ugrave;ng c&aacute;c bạn. Thầy Quyết gửi cho ch&uacute;ng t&ocirc;i những h&igrave;nh ảnh mới của Sớ l&ecirc;n lớp 1. Nh&igrave;n thấy &aacute;nh mắt trong veo lấp l&aacute;nh hy vọng c&ugrave;ng nụ cười tr&ecirc;n đ&ocirc;i m&ocirc;i đ&atilde; được chữa l&agrave;nh, ch&uacute;ng t&ocirc;i thấy một em Sớ tự tin, hạnh ph&uacute;c với trường mới, bạn mới.</p>

<p>Một ng&agrave;y th&aacute;ng 7/2022, đội ngũ Operation Smile Vietnam c&oacute; dịp đến thăm nh&agrave; của Sớ v&agrave; Đ&agrave;i với sự gi&uacute;p đỡ của thầy Quyết. Vượt xa khỏi h&igrave;nh dung của ch&uacute;ng t&ocirc;i, nh&agrave; c&aacute;c em nằm tr&ecirc;n những đồi n&uacute;i cheo leo, băng qua những &ldquo;con đường&rdquo; kh&ocirc;ng c&oacute; đường đi. Ch&uacute;ng ta c&oacute; những l&uacute;c tắc đường ch&aacute;n chường nơi đ&ocirc; thị, nhưng c&oacute; lẽ chừng đ&oacute; chưa đủ để ch&uacute;ng ta h&igrave;nh dung được kh&oacute; khăn của những em nhỏ như Đ&agrave;i v&agrave; Sớ tr&ecirc;n nẻo T&acirc;y Bắc xa x&ocirc;i kia. C&aacute;c em thậm ch&iacute; c&ograve;n kh&ocirc;ng c&oacute; đường để đi, d&ugrave; đ&oacute; chỉ l&agrave; đường tới trường hay đường sang nh&agrave; b&agrave; ngoại.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130153824-638054195041808619.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130153839-638054195198836140.jpg" style="height:346px; width:650px" /></p>

<p><em>Mỗi một đ&oacute;ng g&oacute;p của bạn d&ugrave; lớn hay nhỏ đều mang lại &aacute;nh s&aacute;ng hy vọng cho c&aacute;c em nhỏ k&eacute;m may mắn</em></p>

<p><strong>Nối d&agrave;i h&agrave;nh tr&igrave;nh y&ecirc;u thương, g&oacute;p Heo V&agrave;ng c&ugrave;ng AVAKids g&acirc;y quỹ phẫu thuật 8 nụ cười</strong></p>

<p>V&igrave; thế m&agrave; ch&uacute;ng t&ocirc;i tin rằng m&igrave;nh mới l&agrave; người phải gửi lời cảm ơn đến Đ&agrave;i, Sớ, gia đ&igrave;nh c&aacute;c em, cảm ơn thầy Quyết v&agrave; cảm ơn h&agrave;ng ng&agrave;n gia đ&igrave;nh sinh sống từ những v&ugrave;ng s&acirc;u, v&ugrave;ng xa. Họ đ&atilde; d&aacute;m đặt niềm tin v&agrave;o l&ograve;ng tốt tuyệt vời như thầy Quyết, d&agrave;nh sự tin tưởng cho Operation Smile v&agrave; c&aacute;c y b&aacute;c sĩ, gạt đi những ho&agrave;i nghi v&agrave; lo lắng, vượt qua những h&agrave;nh tr&igrave;nh đầy kh&oacute; khăn trắc trở để đến th&agrave;nh phố t&igrave;m cơ hội điều trị y tế cho con em m&igrave;nh.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130153901-638054195413156655.jpg" style="height:346px; width:650px" /></p>

<p><em>H&atilde;y tiếp tục c&ugrave;ng Operation Smile tạo n&ecirc;n điều kỳ diệu&nbsp;</em></p>

<p>V&agrave; cộng đồng ch&uacute;ng ta cũng h&atilde;y tin tưởng rằng, mỗi sự đ&oacute;ng g&oacute;p của c&aacute;c bạn h&ocirc;m nay ch&iacute;nh l&agrave; nh&acirc;n tố tạo n&ecirc;n điều k&igrave; diệu đưa những đứa trẻ k&eacute;m may mắn, sinh ra với những dị tật đến với một cuộc đời mới, một tương lai tươi s&aacute;ng hơn.</p>

<p>Trong chương tr&igrave;nh th&aacute;ng 11, nh&agrave; t&agrave;i trợ AVAKids v&agrave; Operation Smile rất mong sẽ nhận được sự đồng h&agrave;nh c&ugrave;ng cộng đồng Heo Đất MoMo g&acirc;y quỹ phẫu thuật cho 80 em b&eacute; hở m&ocirc;i, h&agrave;m ếch. To&agrave;n bộ 4.000.000 Heo V&agrave;ng quy&ecirc;n g&oacute;p sẽ được AVAKids quy đổi tương đương với 800.000.000 đồng, tương đương 80 ca phẫu thuật tại Operation Smile.&nbsp;</p>
', CAST(N'2022-11-20' AS Date), CAST(N'2023-01-20' AS Date), 40000000.0000, N'1', N'admin/media/thumbnail/7.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'1')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (8, N'1', N'Mừng Sinh Nhật Heo Đất – Chung tay gây quỹ Mặt trời Hy Vọng', N'<p>❤️&nbsp;C&ugrave;ng Quỹ Hy vọng hỗ trợ cậu b&eacute; ung thư xương phải mổ 6 lần.</p>

<p><strong>X&oacute;t xa cậu b&eacute; mắc ung thư xương mổ 5 lần vẫn chưa th&agrave;nh c&ocirc;ng</strong></p>

<p>Trần Hậu Mạnh l&agrave; cậu b&eacute; 12 tuổi ở Cẩm Xuy&ecirc;n, H&agrave; Tĩnh. Th&aacute;ng 5/2021, em bị đau ch&acirc;n, ra bệnh viện tỉnh kh&aacute;m ph&aacute;t c&oacute; bệnh l&yacute; về xương. Sau đ&oacute;, chị Nguyễn Thị Duy&ecirc;n, mẹ b&eacute; đưa ra em đi Bệnh viện Việt Đức v&agrave; được chỉ định mổ, ph&aacute;t hiện bị ung thư xương.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220923135825-637995383058286505.jpg" style="height:346px; width:650px" /></p>

<p><em>Cậu b&eacute; Trần Hậu Mạnh 12 tuổi kh&ocirc;ng may mang trong m&igrave;nh căn bệnh ung thư xương.</em></p>

<p>Mạnh chuyển sang bệnh viện Nhi Trung ương điều trị ho&aacute; chất, đến th&aacute;ng 9 tiến h&agrave;nh mổ lần 2, sau đ&oacute; ho&aacute; trị tiếp đến th&aacute;ng 7/2022 chuyển sang bệnh viện Xanh P&ocirc;n H&agrave; Nội. Hơn 1 th&aacute;ng em được mổ gh&eacute;p xương nh&acirc;n tạo, nhưng bị nhiễm tr&ugrave;ng n&ecirc;n mổ đến 3 lần ở Xanh P&ocirc;n, v&agrave; vừa trải qua ca mổ lần 4 tại đ&acirc;y. Tuy nhi&ecirc;n, b&aacute;c sĩ th&ocirc;ng b&aacute;o thời gian tới Mạnh sẽ tiếp tục phải mổ nối g&acirc;n để c&oacute; thể đi lại.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220923135844-637995383246004475.jpg" style="height:346px; width:650px" /></p>

<p><em>Trải qua 4 lần mổ thế nhưng Mạnh vẫn phải mổ nối g&acirc;n tiếp tục để c&oacute; thể đi lại được.</em></p>

<p>Mạnh hiện ở với &ocirc;ng b&agrave; nội. Trước đ&oacute; b&agrave; em cũng điều trị ung thư phổi ở Bệnh viện Bạch Mai. Năm 2021, b&agrave; mất th&igrave; Mạnh ph&aacute;t bệnh. Kể từ đ&oacute;, chị Duy&ecirc;n phải nghỉ việc đến viện chăm con. Anh Trần Quốc H&ugrave;ng ở qu&ecirc; l&agrave;m ruộng v&agrave; l&agrave;m thu&ecirc; nu&ocirc;i &ocirc;ng gi&agrave; yếu v&agrave; chăm cậu em ng&agrave;y ng&agrave;y đi học. Điều kiện gia đ&igrave;nh kh&oacute; khăn nay c&agrave;ng vất vả hơn khi Mạnh nằm viện li&ecirc;n tục, chi ph&iacute; tốn k&eacute;m. Nhiều đợt phải mua ho&aacute; chất đến h&agrave;ng chục triệu đồng. Hiện Mạnh cần mổ gh&eacute;p xương chi ph&iacute; lớn, gia đ&igrave;nh vay mượn cũng kh&ocirc;ng lo nổi.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220923135859-637995383399083922.jpg" style="height:346px; width:650px" /></p>

<p><em>Ho&agrave;n cảnh gia đ&igrave;nh vốn đ&atilde; kh&oacute; khăn, nay lại phải lo viện ph&iacute;, thuốc thang li&ecirc;n tục khiến gia đ&igrave;nh em gần nhưng rơi v&agrave;o cảnh chật vật, t&uacute;ng thiếu.</em></p>

<p><strong>C&ugrave;ng Quỹ Hy vọng hỗ trợ cậu b&eacute; ung thư xương phải mổ 5&nbsp;lần</strong></p>

<p>Nh&acirc;n dịp sinh nhật Heo Đất MoMo, nhằm hỗ trợ Mạnh v&agrave; gia đ&igrave;nh giảm bớt g&aacute;nh nặng t&agrave;i ch&iacute;nh, Quỹ Hy Vọng mong muốn sẽ g&acirc;y quỹ được 10.000.000 VNĐ từ cộng đồng người d&ugrave;ng Tr&aacute;i Tim MoMo.</p>

<p>To&agrave;n bộ số tiền nhận được sẽ được d&ugrave;ng l&agrave;m kinh ph&iacute; để hỗ trợ thuốc thang, viện ph&iacute; cho em Mạnh những ng&agrave;y sắp tới, hay chung tay gi&uacute;p cậu b&eacute; Mạnh vượt qua bệnh tật, để em c&oacute; thể đi lại b&igrave;nh thường như bao đứa trẻ kh&aacute;c.</p>

<p>Mọi sự đ&oacute;ng g&oacute;p d&ugrave; &iacute;t hay nhiều điều c&oacute; &yacute; nghĩa to lớn đối với những ho&agrave;n cảnh kh&oacute; khăn, h&atilde;y chung tay c&ugrave;ng ch&uacute;ng t&ocirc;i để đem lại nhiều sự đổi thay cho cuộc sống th&ecirc;m tốt đẹp!</p>
', CAST(N'2022-11-20' AS Date), CAST(N'2022-12-30' AS Date), 10000000.0000, N'1', N'admin/media/thumbnail/8.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'3')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (9, N'2', N'Gây quỹ trồng 20.000 cây xanh chống biến đổi khí hậu và ô nhiễm môi trường', N'<p>❤️&nbsp;Mỗi người chỉ cần g&oacute;p một c&acirc;y xanh, ch&uacute;ng ta sẽ c&oacute; thể phủ xanh đ&ocirc; thị v&agrave; chung tay hạn chế &ocirc; nhiễm m&ocirc;i trường. H&atilde;y đồng h&agrave;nh c&ugrave;ng GreenViet để trồng th&ecirc;m 20.000 c&acirc;y xanh.</p>

<p>Chương tr&igrave;nh &ldquo;Một triệu c&acirc;y xanh Đ&ocirc; thị&rdquo; (MTIC) ra đời từ thực trạng thiếu diện t&iacute;ch che phủ c&acirc;y xanh trong 3 đ&ocirc; thị lớn ở Việt Nam l&agrave; H&agrave; Nội, Đ&agrave; Nẵng v&agrave; th&agrave;nh phố Hồ Ch&iacute; Minh, k&eacute;o theo đ&oacute; l&agrave; những hệ quả t&aacute;c động đến m&ocirc;i trường, x&atilde; hội, sức khỏe v&agrave; chất lượng sống của con người. Chương tr&igrave;nh được thực hiện trong thời gian 10 năm (từ 2020 đến 2030), đặt ra mục ti&ecirc;u trồng một triệu c&acirc;y xanh đ&ocirc; thị tr&ecirc;n to&agrave;n quốc, trong đ&oacute; Đ&agrave; Nẵng, H&agrave; Nội v&agrave; TP. Hồ Ch&iacute; Minh l&agrave; c&aacute;c th&agrave;nh phố trọng điểm.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221208103915-638060927559388117.jpg" style="height:346px; width:650px" /></p>

<p>Trung t&acirc;m bảo tồn đa dạng sinh học Nước Việt Xanh (GreenViet) k&ecirc;u gọi cộng đồng chung tay trồng 20.000 c&acirc;y xanh đ&ocirc; thị, hướng đến tăng mật độ c&acirc;y xanh tại c&aacute;c c&ocirc;ng vi&ecirc;n, trường học, k&yacute; t&uacute;c x&aacute;, đường giao th&ocirc;ng&hellip;của c&aacute;c th&agrave;nh phố lớn. Sự đ&oacute;ng g&oacute;p của mỗi c&aacute; nh&acirc;n sẽ mang lại những thay đổi t&iacute;ch cực cho m&ocirc;i trường đ&ocirc; thị, từ mảng xanh th&agrave;nh phố đến kh&ocirc;ng kh&iacute; sạch v&agrave; chống biến đổi kh&iacute; hậu.</p>

<p>Dự &aacute;n thuộc Chương tr&igrave;nh &ldquo;Một triệu c&acirc;y xanh Đ&ocirc; thị&rdquo; (MTIC), được GreenViet thực hiện trong thời gian 10 năm (từ 2020 đến 2030), đặt ra mục ti&ecirc;u trồng một triệu c&acirc;y xanh đ&ocirc; thị tr&ecirc;n to&agrave;n quốc, trong đ&oacute; Đ&agrave; Nẵng, H&agrave; Nội v&agrave; TP. Hồ Ch&iacute; Minh l&agrave; c&aacute;c th&agrave;nh phố trọng điểm.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221208103937-638060927771072906.jpg" style="height:346px; width:650px" /></p>

<p>Trong gần 3 năm qua thực hiện chương tr&igrave;nh, với sự g&oacute;p sức của cộng đồng v&agrave; nh&agrave; t&agrave;i trợ, GreenViet đ&atilde; trồng hơn 32.000 c&acirc;y xanh tr&ecirc;n 72 điểm của c&aacute;c th&agrave;nh phố lớn. Với chương tr&igrave;nh MTIC, trung t&acirc;m GreenViet đ&atilde; lan tỏa th&ocirc;ng điệp trồng c&acirc;y xanh bảo vệ m&ocirc;i trường đến với cộng đồng, đo&agrave;n thể, doanh nghiệp... Song song với việc huy động nguồn lực trồng c&acirc;y xanh, GreenViet đ&atilde; ph&aacute;t triển dự &aacute;n I-tree tại Việt Nam để quản l&yacute;, đ&aacute;nh gi&aacute; lợi &iacute;ch c&acirc;y xanh v&agrave; kh&ocirc;ng gian xanh đ&ocirc; thị đối với c&aacute;c vấn đề m&ocirc;i trường, kinh tế v&agrave; c&aacute;c t&aacute;c động đến sức khỏe con người.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221208103950-638060927903104557.jpg" style="height:346px; width:650px" /></p>

<p>Chương tr&igrave;nh k&ecirc;u gọi cộng đồng, c&aacute;c nh&agrave; hảo t&acirc;m c&ugrave;ng chung tay g&acirc;y quỹ 200.000.000 đồng. Chiến dịch g&acirc;y quỹ &ldquo;V&igrave; một Việt Nam Xanh&rdquo; nhằm mở rộng 30ha diện t&iacute;ch rừng l&agrave;m nơi ở cho quần thể Voọc Ch&agrave; V&aacute; Ch&acirc;n X&aacute;m tại x&atilde; Tam Mỹ T&acirc;y, trồng th&ecirc;m 20.000 c&acirc;y xanh tại c&aacute;c th&agrave;nh phố lớn nhằm hướng đến mục ti&ecirc;u trong chương tr&igrave;nh &ldquo;Một triệu c&acirc;y xanh đ&ocirc; thị - MTIC&rdquo; v&agrave; mang đến h&agrave;nh tr&igrave;nh gi&aacute;o dục trải nghiệm thi&ecirc;n nhi&ecirc;n Sơn Tr&agrave; miễn ph&iacute; cho 1.000 trẻ em yếu thế.</p>

<p>Mọi sự đ&oacute;ng g&oacute;p của bạn sẽ g&oacute;p phần ho&agrave;n th&agrave;nh mục ti&ecirc;u trồng 20.000 c&acirc;y xanh để phủ xanh đ&ocirc; thị v&agrave; chung tay hạn chế &ocirc; nhiễm m&ocirc;i trường.&nbsp;</p>
', CAST(N'2022-11-30' AS Date), CAST(N'2023-02-20' AS Date), 200000000.0000, N'1', N'admin/media/thumbnail/9.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'5')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (10, N'2', N'Cùng góp Heo Vàng xây cầu dân sinh tại  huyện Tân Sơn, tỉnh Phú Thọ', N'<p>❤️&nbsp;Chung tay gi&uacute;p b&agrave; con đồng b&agrave;o người Mường tại Khu Quẽ để nơi đ&acirc;y c&oacute; c&acirc;y cầu ki&ecirc;n cố, an to&agrave;n đi lại, giao thương</p>

<p><strong>C&acirc;y cầu gỗ dựng tạm ảnh hưởng kh&ocirc;ng nhỏ tới đời sống của người d&acirc;n v&agrave; c&aacute;c em nhỏ</strong></p>

<p>Thu C&uacute;c l&agrave; một x&atilde; thuộc huyện v&ugrave;ng cao T&acirc;n Sơn, tỉnh Ph&uacute; Thọ, nằm ở ng&atilde; ba giữa quốc lộ 32 l&ecirc;n Y&ecirc;n B&aacute;i v&agrave; 32B sang Sơn La. Trong đ&oacute;, Khu Quẽ l&agrave; khu kh&oacute; khăn của x&atilde; Thu C&uacute;c với c&aacute;c hộ d&acirc;n đa phần l&agrave; đồng b&agrave;o người Mường. C&aacute;c hộ d&acirc;n sinh sống chủ yếu trong khu vực rừng sản xuất. Mặc d&ugrave; chăm lo sản xuất, nhưng v&igrave; sản xuất n&ocirc;ng nghiệp chậm ph&aacute;t triển n&ecirc;n cuộc sống của b&agrave; con c&ograve;n nhiều kh&oacute; khăn.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130155447-638054204878351445.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130155459-638054204992626000.jpg" style="height:346px; width:650px" /></p>

<p><em>C&acirc;y cầu nối 2 cụm d&acirc;n cư của Khu Quẽ được người d&acirc;n dựng tạm bằng tre để đi lại</em></p>

<p>Khu Quẽ l&agrave; khu c&oacute; địa h&igrave;nh hiểm trở, đồng thời bị chia cắt bởi nhiều con suối nhỏ. Thế nhưng, kinh tế kh&oacute; khăn n&ecirc;n họ chưa thể x&acirc;y dựng được một c&acirc;y cầu ki&ecirc;n cố. Việc n&agrave;y ảnh hưởng đến giao thương v&agrave; di chuyển của hơn 30 hộ d&acirc;n v&agrave; khoảng 70 em học sinh của 2 cụm d&acirc;n cư ở Khu Quẽ. V&igrave; thế để thuận tiện đi lại, c&aacute;c hộ d&acirc;n đ&atilde; dựng tạm chiếc cầu d&acirc;n sinh bằng tre, song kh&ocirc;ng đảm bảo an to&agrave;n. Người d&acirc;n, học sinh nhiều lần phải lội qua khe để đi lại. D&ugrave; c&oacute; cầu tạm l&agrave; vậy, nhưng những l&uacute;c mưa to, nước từ thượng nguồn đổ về rất lớn, chảy siết n&ecirc;n người d&acirc;n kh&ocirc;ng thể đi lại được, học sinh kh&ocirc;ng thể đến trường, c&aacute;c hộ d&acirc;n gặp nhiều kh&oacute; khăn.&nbsp;</p>

<p>Trải qua thời gian sử dụng d&agrave;i l&acirc;u, c&acirc;y cầu dựng tạm vốn đ&atilde; kh&ocirc;ng an to&agrave;n, nay lại c&agrave;ng th&ecirc;m nguy hiểm c&oacute; thể sập v&agrave; g&acirc;y tai nạn kh&ocirc;ng mong muốn bất cứ l&uacute;c n&agrave;o. Mọi hoạt động của người d&acirc;n dường như sẽ bị đ&igrave;nh trệ nếu c&acirc;y cầu gặp vấn đề v&agrave; cần phải sửa chữa. Người d&acirc;n tại Khu Quẽ, X&atilde; Thu C&uacute;c, Huyện T&acirc;n Sơn, Ph&uacute; Thọ lu&ocirc;n mong muốn c&oacute; một c&acirc;y cầu mới ki&ecirc;n cố để y&ecirc;n t&acirc;m sản xuất, di chuyển. Khi c&acirc;y cầu mới được x&acirc;y dựng sẽ gi&uacute;p gần 100 học sinh trong khu vực thuận lợi hơn trong việc tới trường.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130155518-638054205184026644.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221130155539-638054205390155046.jpg" style="height:346px; width:650px" /></p>

<p><em>C&acirc;y cầu mới an to&agrave;n hơn v&agrave; ki&ecirc;n cố hơn sẽ l&agrave; động lực gi&uacute;p b&agrave; con v&agrave; c&aacute;c em nhỏ ở Khu Quẽ an t&acirc;m l&agrave;m việc, tới trường</em></p>

<p><strong>Chung tay quy&ecirc;n g&oacute;p Heo V&agrave;ng x&acirc;y cầu mới ki&ecirc;n cố tặng b&agrave; con Khu Quẽ</strong></p>

<p>Hiểu được kh&oacute; khăn v&agrave; nguyện vọng của người d&acirc;n v&agrave; địa phương Khu Quẽ, Trung t&acirc;m T&igrave;nh nguyện Quốc gia, Dự &aacute;n Sức Mạnh 2000 kết hợp c&ugrave;ng V&iacute; MoMo l&ecirc;n kế hoạch x&acirc;y dựng một c&acirc;y cầu mới, khang trang cho bản. Để l&agrave;m được điều n&agrave;y, ch&uacute;ng t&ocirc;i k&ecirc;u gọi cộng đồng Heo Đất MoMo chung tay quy&ecirc;n g&oacute;p 900.000 Heo V&agrave;ng. Số Heo V&agrave;ng n&agrave;y sẽ được chị Tr&acirc;m Anh quy đổi th&agrave;nh 450.000.00.000 đồng. C&acirc;y cầu dự kiến sẽ d&agrave;i 6m, chiều rộng xe chạy 4.5m, kết cấu phần tr&ecirc;n l&agrave; cầu b&ecirc; t&ocirc;ng cốt th&eacute;p với hệ thống lan can đầy đủ, an to&agrave;n.&nbsp;</p>

<p>Mỗi một đ&oacute;ng g&oacute;p d&ugrave; lớn hay nhỏ của bạn cũng c&oacute; thể gi&uacute;p cho người d&acirc;n Khu Quẽ thuận tiện hơn trong việc đi l&agrave;m, v&agrave; c&aacute;c em nhỏ tới trường. Đ&oacute; sẽ l&agrave; động lực để người d&acirc;n v&agrave; c&aacute;c em vươn l&ecirc;n trong cuộc sống.</p>
', CAST(N'2022-11-30' AS Date), CAST(N'2023-03-02' AS Date), 90000000.0000, N'1', N'admin/media/thumbnail/10.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'4')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (11, N'1', N'Đóng góp “Một bữa sáng” vì động vật hoang dã có nguy cơ tuyệt chủng tại Việt Nam', N'<p>❤️&nbsp;Nhiều c&aacute; thể động vật hoang d&atilde; đang c&oacute; nguy cơ tuyệt chủng, h&atilde;y c&ugrave;ng ch&uacute;ng t&ocirc;i chung tay bảo vệ v&agrave; phục hồi c&aacute;c lo&agrave;i động vật hoang d&atilde; tr&ecirc;n khắp l&atilde;nh thổ Việt Nam.</p>

<p>Mỗi lo&agrave;i động thực vật l&agrave; một mắt x&iacute;ch quan trọng trong thế giới tự nhi&ecirc;n v&agrave; c&oacute; vai tr&ograve; đảm bảo sự đa dạng sinh học v&agrave; c&acirc;n bằng cho hệ sinh th&aacute;i. Nếu chỉ bị thiếu đi một yếu tố cũng sẽ dẫn tới sự mất c&acirc;n bằng. N&oacute; sẽ l&agrave; hậu quả ảnh hưởng về l&acirc;u d&agrave;i tới đời sống của ch&uacute;ng ta v&agrave; tương lai của con ch&aacute;u ch&uacute;ng ta.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221012111426-638011700665843112.jpg" style="height:346px; width:650px" /></p>

<p><em>Đ&oacute;ng g&oacute;p &ldquo;một bữa s&aacute;ng&rdquo; v&igrave; động vật hoang d&atilde;</em></p>

<p><strong>Bảo vệ động vật hoang d&atilde; l&agrave; một h&agrave;nh động v&ocirc; c&ugrave;ng cấp thiết</strong></p>

<p>&ldquo;T&ocirc;i thực sự đau x&oacute;t khi chứng kiến cảnh những con t&ecirc; t&ecirc; mẹ bị bắt, cố cuộn con trong l&ograve;ng để bảo vệ, nhưng kh&ocirc;ng tho&aacute;t được những kẻ thợ săn, hay cảnh những con khỉ, con voọc con &ocirc;m lấy bố mẹ đ&atilde; bị bắn chết dưới c&aacute;c gốc c&acirc;y... Những cảnh tượng đ&oacute; th&ocirc;i th&uacute;c t&ocirc;i muốn l&agrave;m một c&aacute;i g&igrave; đ&oacute; để bảo vệ những c&aacute;nh rừng, c&aacute;c lo&agrave;i động vật v&agrave; thay đổi suy nghĩ của mọi người.&rdquo; &ndash; &Ocirc;ng Nguyễn Văn Th&aacute;i &ndash; Founder v&agrave; Gi&aacute;m đốc điều h&agrave;nh của tổ chức h&agrave;ng đầu Việt Nam về bảo vệ động vật hoang d&atilde;, Save Vietnam&rsquo;s Wildlife đ&atilde; chia sẻ nỗi đau của những lo&agrave;i vật hoang d&atilde; phải chịu sự săn bắt của con người. Thi&ecirc;n nhi&ecirc;n, rừng v&agrave; động vật hoang d&atilde; l&agrave; t&agrave;i sản của ch&uacute;ng ta. Tất cả mọi người đều đang hưởng lợi từ ch&iacute;nh thi&ecirc;n nhi&ecirc;n: Kh&ocirc;ng kh&iacute; ch&uacute;ng ta thở, vẻ đẹp của động vật trong tự nhi&ecirc;n, tiếng chim h&oacute;t, bầu trời xanh&hellip;Thế nhưng con người lại trở th&agrave;nh mối đe dọa lớn nhất với thi&ecirc;n nhi&ecirc;n.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221012111451-638011700918067332.jpg" style="height:346px; width:650px" /></p>

<p><em>Nhiều lo&agrave;i động vật hoang d&atilde; tại Việt Nam c&oacute; nguy cơ tuyệt chủng</em></p>

<p>T&igrave;nh đến nay đ&atilde; c&oacute; hơn 40.000 lo&agrave;i thực vật v&agrave; động vật c&oacute; thể biến mất khỏi h&agrave;nh tinh của ch&uacute;ng ta vĩnh viễn (Theo s&aacute;ch đỏ của IUCN). Hơn một triệu lo&agrave;i động thực vật đang phải đối mặt với nguy cơ tuyệt chủng do c&aacute;c hoạt động của con người (B&aacute;o c&aacute;o của LHQ năm 2019). Đặc biệt tại Việt Nam, h&agrave;ng trăm lo&agrave;i động vật hoang d&atilde; vẫn đ&atilde; v&agrave; đang bị săn bắt v&agrave; vận chuyển tr&aacute;i ph&eacute;p phục vụ cho nhiều mục đ&iacute;ch kh&aacute;c nhau.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221012111526-638011701265999539.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221012111548-638011701484198632.jpg" style="height:346px; width:650px" /></p>

<p><em>H&agrave;ng trăm lo&agrave;i động vật hoang d&atilde; bị săn bắn v&agrave; vận chuyển tr&aacute;i ph&eacute;p</em></p>

<p>L&agrave; một trong 16 quốc gia c&oacute; độ đa dạng sinh học cao nhất tr&ecirc;n thế giới (Theo Cơ quan Ph&aacute;t triển Quốc tế Hoa Kỳ - USAID, 2013), tuy nhi&ecirc;n, Việt Nam hiện cũng l&agrave; điểm n&oacute;ng, l&agrave; quốc gia trung chuyển v&agrave; cũng l&agrave; thị trường ti&ecirc;u thụ động vật hoang d&atilde; (ĐVHD) lớn nhất tr&ecirc;n thế giới (UNODC, 2017). C&ugrave;ng với t&igrave;nh trạng bu&ocirc;n b&aacute;n, săn bắt, ti&ecirc;u thụ sản phẩm ĐVHD v&agrave; mất sinh cảnh sống l&agrave; c&aacute;c nguy&ecirc;n nh&acirc;n ch&iacute;nh đang đẩy nhiều lo&agrave;i ĐVHD đến nguy cơ tuyệt chủng cũng như việc đ&atilde; x&oacute;a sổ một số lo&agrave;i khỏi c&aacute;nh rừng nguy&ecirc;n sinh của ch&uacute;ng ta trong đ&oacute; c&oacute; t&ecirc; gi&aacute;c.</p>

<p><strong>Chung tay đ&oacute;ng g&oacute;p &ldquo;Một bữa s&aacute;ng&rdquo; v&igrave; động vật hoang d&atilde; Việt Nam</strong></p>

<p>SVW đ&atilde; trực tiếp cứu hộ được 2.189 c&aacute; thể động vật hoang d&atilde; thuộc 45 lo&agrave;i kh&aacute;c nhau. V&agrave; SVW đ&atilde; cứu được 1.591 c&aacute; thể t&ecirc; t&ecirc; khỏi c&aacute;c vụ săn bắn, bu&ocirc;n b&aacute;n tr&aacute;i ph&eacute;p. T&ecirc; t&ecirc; l&agrave; lo&agrave;i động vật c&oacute; v&uacute; bị săn bắt nhiều nhất tr&ecirc;n thế giới v&agrave; đang đối mặt với nguy cơ tuyệt chủng. SVW tự h&agrave;o l&agrave; trung t&acirc;m cứu hộ t&ecirc; t&ecirc; nhiều nhất tr&ecirc;n thế giới. Ngo&agrave;i ra, hơn 60% c&aacute; thể động vật hoang d&atilde; đ&atilde; được SVW t&aacute;i thả th&agrave;nh c&ocirc;ng về với tự nhi&ecirc;n.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221012111633-638011701930170557.jpg" style="height:346px; width:650px" /></p>

<p><br />
<img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221012111648-638011702083015301.jpg" style="height:346px; width:650px" /></p>

<p><em>Chung tay ngăn chặn c&aacute;c mối đe dọa với c&aacute;c lo&agrave;i động vật hoang d&atilde;</em></p>

<p>Chiến dịch &ldquo;Một bữa s&aacute;ng&rdquo; đ&aacute;nh dấu th&ecirc;m nỗ lực của SVW &ndash; l&agrave; nơi để mỗi người Việt ch&uacute;ng ta c&oacute; thể chung tay ngăn chặn c&aacute;c mối đe dọa dẫn tới nguy cơ tuyệt chủng với c&aacute;c lo&agrave;i ĐVHD của Việt Nam:</p>

<ul>
	<li>Một bữa s&aacute;ng để g&oacute;p phần cứu ĐVHD bị bu&ocirc;n b&aacute;n tr&aacute;i ph&eacute;p</li>
	<li>Một bữa s&aacute;ng để phục hồi c&aacute;c c&aacute; thể ĐVHD</li>
	<li>Một bữa s&aacute;ng để t&aacute;i thả ĐVHD về với tự nhi&ecirc;n</li>
</ul>

<p>Ch&uacute;ng t&ocirc;i gọi t&ecirc;n chiến dịch Một bữa s&aacute;ng với th&ocirc;ng điệp &yacute; nghĩa: Bữa s&aacute;ng kh&ocirc;ng phải l&agrave; bữa ăn lớn nhất trong ng&agrave;y nhưng lại c&oacute; vai tr&ograve; rất quan trọng với sự ph&aacute;t triển của cơ thể mỗi con người. H&agrave;nh động bảo vệ ĐVHD kh&ocirc;ng nhất thiết phải l&agrave; những việc l&agrave;m lớn th&igrave; mới mang lại hiệu quả. H&atilde;y bắt đầu từ những việc nhỏ nhất, trong khả năng của m&igrave;nh. Trong đợt k&ecirc;u gọi quy&ecirc;n g&oacute;p n&agrave;y, ch&uacute;ng t&ocirc;i mong muốn cộng đồng c&ugrave;ng chung tay g&acirc;y quỹ số tiền 50.000.000 đồng. Số tiền n&agrave;y sẽ d&ugrave;ng l&agrave;m chi ph&iacute; cho c&aacute;c bữa ăn của ĐVHD đ&atilde; được giải cứu v&agrave; quan trọng nhất l&agrave; đưa ch&uacute;ng TRỞ VỀ NH&Agrave;.</p>

<p>H&agrave;nh động ngay v&igrave; c&aacute;c lo&agrave;i nguy cấp khi c&oacute; cơ hội bạn nh&eacute;!</p>
', CAST(N'2022-12-05' AS Date), CAST(N'2023-01-20' AS Date), 50000000.0000, N'1', N'admin/media/thumbnail/11.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'5')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (12, N'2', N'Kiến tạo công viên dành cho cộng đồng nuôi chó tại Công viên Yên Sở', N'<p>❤️&nbsp;Chung tay c&ugrave;ng với Think Playgrounds để kiến tạo một kh&ocirc;ng gian vui chơi th&acirc;n thiện d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute; tại c&ocirc;ng vi&ecirc;n Y&ecirc;n Sở</p>

<p><strong>Đừng để th&uacute; cưng của m&igrave;nh th&agrave;nh nỗi kinh ho&agrave;ng cho người kh&aacute;c</strong></p>

<p>Tại c&aacute;c đ&ocirc; thị lớn, việc c&aacute;c gia đ&igrave;nh nu&ocirc;i ch&oacute; kh&ocirc;ng c&ograve;n hiếm gặp, đặc biệt l&agrave; c&aacute;c gia đ&igrave;nh c&oacute; trẻ em. Việc được đồng h&agrave;nh với th&uacute; cưng gi&uacute;p trẻ em nu&ocirc;i dưỡng t&igrave;nh y&ecirc;u với động vật cũng như ph&aacute;t triển nhận thức, tr&iacute; tuệ cảm x&uacute;c v&agrave; h&agrave;nh vi t&iacute;ch cực. Tuy nhi&ecirc;n, tại H&agrave; Nội cũng như nhiều đ&ocirc; thị kh&aacute;c ở Việt Nam, c&aacute;c c&ocirc;ng vi&ecirc;n chưa c&oacute; kh&ocirc;ng gian vui chơi th&acirc;n thiện ri&ecirc;ng biệt. Việc thiếu hụt n&agrave;y đ&atilde; dẫn đến nhiều xung đột, m&acirc;u thuẫn khi việc dắt ch&oacute; đi dạo hoặc thả r&ocirc;ng tại c&aacute;c kh&ocirc;ng gian chung ảnh hưởng v&agrave; g&acirc;y nguy hiểm cho những người kh&aacute;c trong c&ocirc;ng vi&ecirc;n.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220505102249-637873429696827599.jpg" style="height:346px; width:650px" /></p>

<p><em>Trẻ em chơi với ch&oacute; gi&uacute;p nu&ocirc;i dưỡng t&igrave;nh y&ecirc;u động vật</em></p>

<p><strong>Cần lắm c&ocirc;ng vi&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute;!</strong></p>

<p>C&ocirc;ng vi&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute; mang lại kh&ocirc;ng gian an to&agrave;n cho c&aacute;c ch&uacute; ch&oacute; vận động v&agrave; l&agrave;m quen với c&aacute;c ch&uacute; ch&oacute; kh&aacute;c. Người nu&ocirc;i ch&oacute; cũng được tham gia hoạt động c&ugrave;ng c&aacute;c ch&uacute; ch&oacute; của m&igrave;nh với cảm gi&aacute;c y&ecirc;n t&acirc;m trong kh&ocirc;ng gian được thiết kế ri&ecirc;ng. Việc thiếu vận động c&oacute; thể khiến ch&oacute; trở n&ecirc;n dữ dằn v&agrave; dễ bệnh tật. C&aacute;c ch&uacute; ch&oacute; hạnh ph&uacute;c cũng khiến cho người nu&ocirc;i ch&oacute; hạnh ph&uacute;c v&agrave; an t&acirc;m hơn.&nbsp;</p>

<p>C&aacute;c lợi &iacute;ch ch&iacute;nh của c&ocirc;ng vi&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute;:</p>

<ul>
	<li>L&agrave;m cho c&ocirc;ng vi&ecirc;n trở n&ecirc;n an to&agrave;n hơn cho những người sử dụng</li>
	<li>G&oacute;p phần đảm bảo vệ sinh m&ocirc;i trường trong c&ocirc;ng vi&ecirc;n</li>
	<li>X&acirc;y dựng cộng đồng th&acirc;n thiện v&agrave; văn m&igrave;nh</li>
	<li>Chi ph&iacute; vận h&agrave;nh thấp</li>
</ul>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220505102337-637873430173674993.jpg" style="height:346px; width:650px" /></p>

<p><em>Chung tay x&acirc;y dựng c&ocirc;ng vi&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute;</em></p>

<p><strong>Chung tay g&acirc;y quỹ x&acirc;y dựng c&ocirc;ng vi&ecirc;n cho cộng đồng nu&ocirc;i ch&oacute; tại C&ocirc;ng vi&ecirc;n xanh Y&ecirc;n Sở</strong></p>

<p>Để kiến tạo một m&ocirc; h&igrave;nh c&ocirc;ng vi&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute; đầu ti&ecirc;n tại H&agrave; Nội, Tr&aacute;i tim MoMo hợp t&aacute;c c&ugrave;ng Think Playgrounds đ&atilde; phối hợp với &ocirc;ng Gabe No v&agrave; c&ocirc;ng vi&ecirc;n Y&ecirc;n Sở H&agrave; Nội trao đổi, ph&aacute;t triển thiết kế v&agrave; x&acirc;y dựng c&ocirc;ng vi&ecirc;n cho cộng đồng nu&ocirc;i ch&oacute;. Nhằm tạo một m&ocirc;i trường vui chơi, đảm bảo an to&agrave;n giữa con người v&agrave; th&uacute; cưng.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220505102409-637873430497526053.jpg" style="height:346px; width:650px" /></p>

<p><em>C&ocirc;ng vi&ecirc;n Y&ecirc;n Sở - Khu vực dự kiến l&agrave;m c&ocirc;ng vi&ecirc;n</em></p>

<p>Dự kiến, vị tr&iacute; x&acirc;y dựng l&agrave; c&ocirc;ng vi&ecirc;n Y&ecirc;n Sở (Ho&agrave;ng Mai, H&agrave; Nội, 2014) tọa lạc tại cửa ng&otilde; ph&iacute;a nam thủ đ&ocirc; v&agrave; được v&iacute; như &ldquo;l&aacute; phổi xanh&rdquo; của th&agrave;nh phố. C&ocirc;ng vi&ecirc;n Y&ecirc;n Sở đ&atilde; đ&oacute;n nhận h&agrave;ng ngh&igrave;n lượt kh&aacute;ch, đa phần l&agrave; trẻ em tới vui chơi v&agrave; thăm quan mỗi ng&agrave;y. Nơi đ&acirc;y đ&atilde; đồng thuận cho việc sử dụng kh&ocirc;ng gian c&oacute; diện t&iacute;ch 1650 m2 để x&acirc;y dựng c&ocirc;ng vi&ecirc;n đầu ti&ecirc;n cho cộng đồng nu&ocirc;i ch&oacute; bao gồm c&aacute;c hạng mục ch&iacute;nh: h&agrave;ng r&agrave;o, cổng v&agrave;o, c&aacute;c thiết bị vận động cho th&uacute; nu&ocirc;i, b&agrave;n ghế v&agrave; c&aacute;c bảng th&ocirc;ng tin. Kh&ocirc;ng gian c&ocirc;ng vi&ecirc;n n&agrave;y dự kiến phục vụ được từ 100 - 200&nbsp; lượt th&uacute; nu&ocirc;i c&ugrave;ng chủ sở hữu, trẻ em mỗi ng&agrave;y.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220505102503-637873431032185997.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220505102515-637873431154607599.jpg" style="height:346px; width:650px" /></p>

<p><em>Phối cảnh thiết kế của c&ocirc;ng vi&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute;</em></p>

<p>Dự kiến tổng kinh x&acirc;y dựng của dự &aacute;n l&agrave; 460.000.000 VNĐ. Hiện tại, &ocirc;ng Gabe No đ&atilde; cam kết hỗ trợ 320 triệu th&ocirc;ng qua chương tr&igrave;nh Heo Đất MoMo sẽ được sử dụng v&agrave;o việc x&acirc;y dựng c&aacute;c hạng mục:</p>

<ul>
	<li>H&agrave;ng r&agrave;o, cổng ra v&agrave;o</li>
	<li>B&agrave;n ghế, bảng th&ocirc;ng tin, th&ugrave;ng r&aacute;c</li>
	<li>C&aacute;c hạng mục kh&aacute;c (hộp đựng t&uacute;i ni l&ocirc;ng, treo b&aacute;t&hellip;)</li>
</ul>

<p>Để dự &aacute;n được đi v&agrave;o hoạt động, ch&uacute;ng t&ocirc;i rất mong muốn g&acirc;y quỹ th&ecirc;m 140 triệu từ c&aacute;c mạnh thường qu&acirc;n th&ocirc;ng qua chương tr&igrave;nh Tr&aacute;i Tim MoMo. Nguồn kinh ph&iacute; sẽ được sử dụng v&agrave;o việc x&acirc;y dựng c&aacute;c hạng mục:</p>

<ul>
	<li>Khu vực cung cấp nước&nbsp;</li>
	<li>Kho chứa đồ</li>
	<li>Hệ chướng ngại tăng khả năng vận động</li>
</ul>

<p>Kh&ocirc;ng gian vui chơi th&acirc;n thiện đầu ti&ecirc;n d&agrave;nh cho cộng đồng nu&ocirc;i ch&oacute; sẽ l&agrave; niềm mong đợi của rất nhiều c&aacute;c bạn nhỏ, c&aacute;c gia đ&igrave;nh v&agrave; những người sở hữu th&uacute; cưng. Tr&aacute;i Tim MoMo v&agrave; c&aacute;c đối t&aacute;c rất mong muốn nhận được sự hỗ trợ từ những mạnh thường qu&acirc;n để sớm kiến tạo kh&ocirc;ng gian n&agrave;y g&oacute;p phần tạo dựng th&agrave;nh phố H&agrave; Nội th&acirc;n thiện v&agrave; đ&aacute;ng sống.&nbsp;&nbsp;</p>
', CAST(N'2022-12-10' AS Date), CAST(N'2023-03-10' AS Date), 140000000.0000, N'1', N'admin/media/thumbnail/12.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'4')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (13, N'2', N'“Giữ nhà” cho Voọc Chà Vá chân xám tại Núi Thành, Quảng Nam', N'<p>❤️&nbsp;C&ugrave;ng chung tay mở rộng 30 ha rừng tự nhi&ecirc;n l&agrave;m nh&agrave; ở cho 69 c&aacute; thể Voọc Ch&agrave; v&aacute; ch&acirc;n x&aacute;m tại Tam Mỹ T&acirc;y đang bị chia cắt nơi ở, thiếu thức ăn, suy tho&aacute;i nguồn gen do giao phối cận huyết v&agrave; cả t&aacute;c động từ con người.</p>

<p>Về Tam Mỹ T&acirc;y, N&uacute;i Th&agrave;nh, Quảng Nam, người ta kh&ocirc;ng chỉ bị thu h&uacute;t bởi thi&ecirc;n nhi&ecirc;n hữu t&igrave;nh m&agrave; c&ograve;n bị &ldquo;giữ ch&acirc;n&rdquo; bởi c&acirc;u chuyện giữ nh&agrave; cho Voọc của cộng đồng nơi đ&acirc;y. Với tất cả t&igrave;nh y&ecirc;u như những người th&acirc;n trong gia đ&igrave;nh, họ đ&atilde; canh giữ từng mảnh rừng để Voọc sinh sống, họ hiểu về tập t&iacute;nh, v&ugrave;ng sống v&agrave; đặc điểm của từng gia đ&igrave;nh Voọc ở cả 4 khu vực n&uacute;i. Để từ đ&oacute; mỗi khi c&oacute; một du kh&aacute;ch phương xa n&agrave;o gh&eacute; thăm họ lại say sưa kể chuyện nh&agrave; Vọọc cũng như nhiệt t&igrave;nh dắt đi thăm nơi ở của ch&uacute;ng.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221208104602-638060931627324047.jpg" style="height:346px; width:650px" /></p>

<p>Chưa dừng lại ở đ&oacute;, c&acirc;u chuyện giữ nh&agrave; cho Voọc c&ograve;n được t&ocirc; điểm bởi c&aacute;c cuộc h&agrave;nh tr&igrave;nh ly kỳ của những người thực hiện c&ocirc;ng t&aacute;c bảo tồn. Từ chuyện chiếc xe mất thắng (phanh) lao dốc tr&ecirc;n đường t&aacute;c nghiệp của anh c&aacute;n bộ, đến chuyện c&ocirc; nghi&ecirc;n cứu sinh trẻ tuổi với niềm đam m&ecirc; nghi&ecirc;n cứu bị sảy ch&acirc;n trong chuyến đi H&ograve;n &Ocirc;ng khảo s&aacute;t Voọc, hay chuyện về con chiến m&atilde; th&acirc;n thương kh&ocirc;ng quản ngại gian kh&oacute; c&ugrave;ng th&agrave;nh vi&ecirc;n tổ tuần tra ho&agrave;n th&agrave;nh tốt c&aacute;c nhiệm vụ được giao. Bạn biết kh&ocirc;ng, đối với nhiều c&aacute;n bộ l&agrave;m c&ocirc;ng t&aacute;c bảo tồn th&igrave; h&agrave;nh trang cho chuyến đi l&agrave; một g&oacute;i cơm trắng c&ugrave;ng v&agrave;i con c&aacute; kho mặn được g&oacute;i gh&eacute;m cẩn thận trong chiếc ba l&ocirc; nhỏ. Chỉ thế đ&oacute; bao năm nay họ vẫn tiếp tục đi tiếp chặng đường bảo vệ đ&agrave;n con thơ giữa rừng gi&agrave; được b&igrave;nh y&ecirc;n.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221208104620-638060931804052357.jpg" style="height:346px; width:650px" /><br />
&nbsp;</p>

<p>H&agrave;nh tr&igrave;nh bảo tồn 69 c&aacute; thể Voọc ch&agrave; v&aacute; ch&acirc;n x&aacute;m ở Tam Mỹ T&acirc;y sẽ l&agrave; một một cuộc h&agrave;nh tr&igrave;nh d&agrave;i, đầy cam go ch&iacute;nh v&igrave; thế cần hơn nữa sự chung tay g&oacute;p sức của cả cộng đồng để c&ugrave;ng mở rộng 30ha rừng tự nhi&ecirc;n l&agrave;m NH&Agrave; cho Voọc th&ocirc;ng qua Chiến dịch g&acirc;y quỹ &ldquo;V&igrave; một Việt Nam xanh&rdquo;. Sự ủng hộ của c&aacute;c bạn l&agrave; động lực th&uacute;c đẩy chiến dịch đi đến điểm đ&iacute;ch nhanh hơn.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-221208104648-638060932084626678.jpg" style="height:346px; width:650px" /></p>

<p>Chiến dịch g&acirc;y quỹ &quot;V&igrave; một Việt Nam Xanh&quot;, thuộc khu&ocirc;n khổ dự &aacute;n Quỹ Bảo tồn do GreenViet v&agrave; GSI phối hợp thực hiện v&agrave; Ph&aacute;i đo&agrave;n Li&ecirc;n minh ch&acirc;u&nbsp; u tại Việt Nam đồng t&agrave;i trợ. Chiến dịch g&acirc;y quỹ &quot;V&igrave; một Việt Nam Xanh&quot; với mục ti&ecirc;u g&acirc;y quỹ 100.000.000 đồng. Với mục đ&iacute;ch nhằm mở rộng 30ha diện t&iacute;ch rừng l&agrave;m nơi ở cho quần thể Voọc Ch&agrave; V&aacute; Ch&acirc;n X&aacute;m tại x&atilde; Tam Mỹ T&acirc;y; trồng th&ecirc;m 20.000 c&acirc;y xanh tại c&aacute;c th&agrave;nh phố lớn nhằm hướng đến mục ti&ecirc;u trong chương tr&igrave;nh &ldquo;Một triệu c&acirc;y xanh đ&ocirc; thị - MTIC&rdquo; v&agrave; mang đến h&agrave;nh tr&igrave;nh gi&aacute;o dục trải nghiệm thi&ecirc;n nhi&ecirc;n Sơn Tr&agrave; miễn ph&iacute; cho 1.000 trẻ em yếu thế.&nbsp;</p>
', CAST(N'2022-12-10' AS Date), CAST(N'2023-03-10' AS Date), 100000000.0000, N'1', N'admin/media/thumbnail/13.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'5')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (14, N'2', N'Chung tay phủ xanh đất trống đồi trọc tại huyện Cam Lộ - Quảng Trị', N'<p>❤️&nbsp;C&ugrave;ng chung tay khắc phục bảo vệ mảng xanh nhằm hạn chế biến đổi kh&iacute; hậu v&agrave; suy tho&aacute;i m&ocirc;i trường, giảm thiểu thi&ecirc;n tai v&agrave; hạn h&aacute;n đối với c&aacute;c v&ugrave;ng đồng b&agrave;o.</p>

<p><strong>Những ảnh hưởng đau thương do mất rừng tại Cam Lộ - Quảng Trị</strong></p>

<p>&ldquo;Mưa lũ đến nhấn ch&igrave;m kh&uacute;c ruột<br />
Thấy đau l&ograve;ng &ecirc; buốt tim ta<br />
Nước d&acirc;ng l&ecirc;n ngập m&aacute;i nh&agrave;<br />
Phận người trong lũ x&oacute;t xa khốn c&ugrave;ng.&rdquo;</p>

<p>Những c&acirc;u thơ ấy của t&aacute;c giả Anh Đại V&otilde; đ&atilde; mi&ecirc;u tả rất r&otilde; cảnh ngập lụt ở Miền Trung trong thời gian gần đ&acirc;y. Ai trong ch&uacute;ng ta đều thấy r&otilde;, mỗi m&ugrave;a mưa lũ qua đi đều để lại cho người d&acirc;n Quảng Trị n&oacute;i ri&ecirc;ng, người d&acirc;n miền Trung n&oacute;i chung những đau thương mất m&aacute;t. Kh&uacute;c ruột Miền Trung th&acirc;n thương của ch&uacute;ng ta rất nhiều lần đ&atilde; phải oằn m&igrave;nh hứng chịu cơn thịnh nộ khủng khiếp từ mẹ thi&ecirc;n nhi&ecirc;n.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220622124028-637914984289421946.jpg" style="height:346px; width:650px" /></p>

<p><em>H&igrave;nh ảnh mưa b&atilde;o, lũ lụt tại đất tại miền Trung, g&acirc;y ra nhiều mất m&aacute;t về người v&agrave; của.</em></p>

<p>Năm 2020, đợt mưa lũ lịch sử tại miền Trung đ&atilde; g&acirc;y thiệt hại nặng nề về người v&agrave; t&agrave;i sản. Hơn 249 người chết v&agrave; mất t&iacute;ch, 1.531 nh&agrave; sập, 239.341 nh&agrave; bị hư hại, tốc m&aacute;i, nhiều c&ocirc;ng tr&igrave;nh ph&ograve;ng, chống thi&ecirc;n tai, cơ sở hạ tầng, d&acirc;n sinh bị hư hỏng, sạt lở.&nbsp;H&igrave;nh ảnh người d&acirc;n phải mất nh&agrave; cửa, mất cơ nghiệp cả đời, thậm ch&iacute; mất đi cả gia đ&igrave;nh do lũ lụt kh&ocirc;ng khỏi khiến ch&uacute;ng ta cảm thấy x&oacute;t xa v&agrave; quặn thắt.&nbsp;</p>

<p>Khi thi&ecirc;n tai xảy ra, c&aacute;c phương ph&aacute;p ph&ograve;ng chống v&agrave; giảm thiểu thiệt hại l&agrave; v&ocirc; c&ugrave;ng quan trọng. Một trong những giải ph&aacute;p hữu hiệu để giảm thiểu ảnh hưởng từ lũ lụt ch&iacute;nh l&agrave; trồng nhiều c&acirc;y xanh, phủ k&iacute;n đồi trọc, tạo n&ecirc;n v&agrave;nh đai xanh điều h&ograve;a kh&iacute; hậu. Tạo v&agrave;nh đai xanh sẽ gi&uacute;p bảo vệ m&ocirc;i trường sinh th&aacute;i, bảo đảm cho sự ph&aacute;t triển bền vững v&agrave; to&agrave;n diện của x&atilde; hội. Đ&acirc;y l&agrave; việc l&agrave;m kh&ocirc;ng chỉ c&oacute; &yacute; nghĩa v&agrave; tầm quan trọng lớn cho ng&agrave;y h&ocirc;m nay m&agrave; c&ograve;n cho cả mai sau.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220622124058-637914984581866854.jpg" style="height:346px; width:650px" /></p>

<p><em>Trồng rừng gi&uacute;p tạo n&ecirc;n v&agrave;nh đai xanh, điều h&ograve;a kh&iacute; hậu.</em></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220622124127-637914984875473212.jpg" style="height:346px; width:650px" /></p>

<p><em>Trồng rừng kh&ocirc;ng chỉ c&oacute; &yacute; nghĩa v&agrave; tầm quan trọng lớn cho ng&agrave;y h&ocirc;m nay m&agrave; c&ograve;n cho cả mai sau.</em></p>

<p><strong>Chung tay trồng rừng, phủ xanh đồi trọc để ph&ograve;ng chống thi&ecirc;n tai tại Cam Lộ - Quảng Trị</strong></p>

<p>Hiểu r&otilde; được tầm quan trọng của việc trồng c&acirc;y xanh - phủ k&iacute;n đồi trọc, Quỹ Hoa Chia Sẻ phối hợp với Tr&aacute;i Tim MoMo ph&aacute;t động chương tr&igrave;nh &ldquo;Phủ xanh đất trống đồi trọc&rdquo;. Đ&acirc;y l&agrave; chiến dịch nhằm phục hồi mảng xanh, x&acirc;y dựng hệ sinh th&aacute;i bền vững nhằm hạn chế c&aacute;c t&aacute;c động từ biến đổi kh&iacute; hậu. Dự &aacute;n hướng đến trồng rừng v&agrave; đi đ&ocirc;i với bảo vệ rừng.&nbsp;</p>

<p>Ch&uacute;ng t&ocirc;i mong muốn c&oacute; thể k&ecirc;u gọi từ cộng đồng 200.000.000 VND th&ocirc;ng qua Tr&aacute;i Tim MoMo để c&ugrave;ng chung tay trồng rừng, phủ xanh gần 2 ha đất trống, tiếp tục chặng đường chống lại biến đổi kh&iacute; hậu. Qũy Hoa Chia Sẻ rất mong nhận được sự ủng hộ nhiệt t&igrave;nh của c&aacute;c vị mạnh thường qu&acirc;n.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220622124202-637914985226168740.jpg" style="height:346px; width:650px" /></p>

<p><em>H&atilde;y c&ugrave;ng Quỹ Hoa Chia Sẻ chung tay quy&ecirc;n g&oacute;p trồng rừng tại Quảng Trị để ph&ograve;ng chống thi&ecirc;n tai lũ lụt miền Trung.</em></p>

<p>Mỗi đ&oacute;ng g&oacute;p của qu&yacute; vị sẽ g&oacute;p phần gi&uacute;p cho cuộc sống trở n&ecirc;n b&igrave;nh ổn với bầu kh&ocirc;ng kh&iacute; trong l&agrave;nh, giảm bớt thiệt hại từ thi&ecirc;n tai, cũng l&agrave; g&oacute;p sức x&acirc;y dựng cho một tương lai bền vững của ch&iacute;nh ch&uacute;ng ta sau n&agrave;y!</p>

<p><em>*Sau khi nhận đủ số tiền quy&ecirc;n g&oacute;p từ cộng đồng, Tr&aacute;i Tim MoMo sẽ chuyển to&agrave;n bộ 200 triệu VND đến Quỹ Hoa Chia Sẻ để triển khai dự &aacute;n. Ch&uacute;ng t&ocirc;i sẽ cập nhật th&ecirc;m th&ocirc;ng tin về tiến độ dự &aacute;n đến qu&yacute; vị trong thời gian sớm nhất.&nbsp;</em></p>
', CAST(N'2022-12-15' AS Date), CAST(N'2023-03-15' AS Date), 200000000.0000, N'1', N'admin/media/thumbnail/14.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-14' AS Date), N'5')
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed], [use_yn], [thumbnail], [insertDate], [updateDate], [category]) VALUES (15, N'2', N'Chung tay vá rừng trên núi đá tại Hòa Bình – Sơn La', N'<p>❤️&nbsp;H&agrave;nh lang núi đá v&ocirc;i Sơn La - Hòa Bình với h&ecirc;̣ động thực v&acirc;̣t phong ph&uacute; đang bị suy giảm. Đóng góp của bạn sẽ góp sức phục hồi rừng, bảo vệ nguồn nước, sinh k&ecirc;́ và kh&ocirc;ng gian văn hóa của b&agrave; con v&ugrave;ng cao.</p>

<p>Khu vực v&ugrave;ng n&uacute;i gi&aacute;p ranh giữa hai huyện Mai Ch&acirc;u (H&ograve;a B&igrave;nh) v&agrave; V&acirc;n Hồ (Sơn La) từ l&acirc;u được biết đến l&agrave; một v&ugrave;ng kh&iacute; hậu m&aacute;t mẻ quanh năm với những c&aacute;nh rừng gi&agrave; tr&ecirc;n n&uacute;i đ&aacute; v&ocirc;i, n&uacute;i đất tươi đẹp. Kh&iacute; hậu &aacute; nhiệt đới v&agrave; địa h&igrave;nh địa chất ri&ecirc;ng biệt n&agrave;y l&agrave; nơi sinh sống của một hệ động thực vật đa dạng, với những c&acirc;y t&ugrave;ng, b&aacute;ch, th&ocirc;ng v&agrave; phong lan qu&yacute; hiếm, hay lo&agrave;i Vượn đen m&aacute; trắng đặc hữu và nguy c&acirc;́p nằm trong S&aacute;ch đỏ của Tổ chức Bảo tồn Thi&ecirc;n nhi&ecirc;n Quốc tế (IUCN). Đồng b&agrave;o H&rsquo;m&ocirc;ng nơi đ&acirc;y c&oacute; nền văn h&oacute;a v&agrave; sinh kế mang đậm dấu ấn của rừng, từ nghề dệt vải lanh đến những nghi lễ văn h&oacute;a truyền thống. Những n&eacute;t đẹp thi&ecirc;n nhi&ecirc;n v&agrave; văn h&oacute;a độc đ&aacute;o đ&atilde; thu h&uacute;t h&agrave;ng ngh&igrave;n lượt kh&aacute;ch tham quan, ngắm rừng v&agrave; trải nghiệm cuộc sống bản địa mỗi năm, mang lại nguồn thu nhập phụ cho người địa phương, gi&uacute;p giảm &aacute;p lực l&ecirc;n nguồn t&agrave;i nguy&ecirc;n rừng.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-211124174105-637733724653228019.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-211124174118-637733724780644551.jpg" style="height:346px; width:650px" /></p>

<p><em>Khung cảnh thi&ecirc;n nhi&ecirc;n tươi đẹp tại khu vực gi&aacute;p ranh Mai Ch&acirc;u - V&acirc;n Hồ</em></p>

<p>Mặc d&ugrave; nằm s&aacute;t khu BTTN Hang Kia &ndash; P&agrave; C&ograve;, dải n&uacute;i đ&aacute; v&ocirc;i n&agrave;y kh&ocirc;ng thuộc diện được bảo vệ do diện t&iacute;ch khu bảo tồn được x&aacute;c định dựa tr&ecirc;n ranh giới h&agrave;nh ch&iacute;nh thay v&igrave; sự liền mảnh của rừng. Thiếu biện ph&aacute;p bảo vệ, địa h&igrave;nh nơi đ&acirc;y đ&atilde; v&agrave; đang bị chia cắt mạnh như một tấm &aacute;o r&aacute;ch. Ước t&iacute;nh, gần 200ha rừng nguy&ecirc;n sinh trước đ&acirc;y bị khai ph&aacute;, khai th&aacute;c lấy gỗ hay l&agrave;m cảnh, hoặc lấn chiếm l&agrave;m nương rẫy. Hiện nay, mặc d&ugrave; người d&acirc;n đ&atilde; nhận thức tốt hơn về việc bảo vệ rừng để duy tr&igrave; nguồn nước v&agrave; phát tri&ecirc;̉n du lịch, nhiều mảng rừng bị chia cắt cần rất nhiều thời gian để c&oacute; thể phục hồi tự nhi&ecirc;n. Với sự hỗ trợ của con người, qu&aacute; tr&igrave;nh phục hồi rừng sẽ diễn ra nhanh ch&oacute;ng v&agrave; hiệu quả hơn.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-211124174154-637733725142009476.jpg" style="height:346px; width:650px" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-211124174203-637733725238307953.jpg" style="height:346px; width:650px" /></p>

<p><em>Dải rừng tr&ecirc;n n&uacute;i đ&aacute; v&ocirc;i tương quan với Khu BTTN Hang Kia &ndash; P&agrave; C&ograve;</em></p>

<p>Bạn kh&ocirc;ng thể mặc &aacute;o r&aacute;ch, rừng cũng vậy. V&igrave; vậy, V&iacute; MoMo phối hợp c&ugrave;ng Trung t&acirc;m Con người v&agrave; Thi&ecirc;n nhi&ecirc;n (PanNature) tổ chức chương tr&igrave;nh&nbsp;<strong>&ldquo;V&aacute; rừng tr&ecirc;n n&uacute;i đ&aacute;&rdquo;</strong>&nbsp;với mục ti&ecirc;u trồng phục hồi rừng tr&ecirc;n dải n&uacute;i đ&aacute; v&ocirc;i nối hai huyện V&acirc;n H&ocirc;̀ &ndash; Mai Ch&acirc;u. Rừng được phục hồi sẽ gi&uacute;p bảo vệ nguồn nước, giảm nguy cơ sạt lở n&uacute;i đ&aacute;, đảm bảo thu nhập từ c&aacute;c hoạt động du lịch sinh th&aacute;i tại địa phương và duy tr&igrave; kh&ocirc;ng gian thực h&agrave;nh c&aacute;c nghi lễ văn h&oacute;a của đồng b&agrave;o H&rsquo;m&ocirc;ng. Giống c&acirc;y trồng lựa chọn l&agrave; c&aacute;c lo&agrave;i bản địa theo cấu tr&uacute;c tầng t&aacute;n rừng v&agrave; tốc độ ph&aacute;t triển đan xen nhằm đảm bảo thời gian kh&eacute;p t&aacute;n rừng tự nhi&ecirc;n sớm nhất. Trong d&agrave;i hạn, chương tr&igrave;nh hướng tới kết nối dải rừng tự nhi&ecirc;n n&agrave;y với Khu Bảo tồn Thi&ecirc;n nhi&ecirc;n Hang Kia-P&agrave; C&ograve;, mở rộng sinh cảnh cho c&aacute;c lo&agrave;i động thực vật qu&yacute; hiếm, trong đ&oacute; c&oacute; lo&agrave;i Vượn đen m&aacute; trắng.</p>

<p>Ch&uacute;ng t&ocirc;i mong muốn huy động 100.000.000 VNĐ từ cộng đồng c&aacute;c nh&agrave; hảo t&acirc;m đang sử dụng v&iacute; MoMo. Nguồn vốn k&ecirc;u gọi được sẽ hỗ trợ nh&acirc;n giống c&acirc;y rừng bản địa, tập huấn kỹ thuật trồng v&agrave; chăm s&oacute;c cho cộng đồng, thiết kế, quản l&yacute; v&agrave; gi&aacute;m s&aacute;t m&ocirc; h&igrave;nh phục hồi rừng. Người d&acirc;n địa phương sẽ đ&oacute;ng g&oacute;p dụng cụ, nh&acirc;n c&ocirc;ng, cũng như chăm s&oacute;c v&agrave; bảo vệ khu vực trồng phục hồi. Hoạt động trồng phục hồi sẽ được thực hiện v&agrave;o khoảng th&aacute;ng 4, th&aacute;ng 5 năm 2022 khi bắt đầu m&ugrave;a mưa.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-211124174242-637733725629283414.jpg" style="height:346px; width:650px" /></p>

<p><br />
<img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-211124174254-637733725746963336.jpg" style="height:346px; width:650px" /></p>

<p><em>Chung tay c&ugrave;ng đồng b&agrave;o v&ugrave;ng cao tham gia bảo tồn rừng v&agrave; thi&ecirc;n nhi&ecirc;n hoang d&atilde;</em></p>

<p>Chương tr&igrave;nh rất cần sự chung tay của c&aacute;c bạn c&ugrave;ng hướng tới một tương lai chia sẻ những gi&aacute; trị chung v&agrave; đồng ph&aacute;t triển, nơi người d&acirc;n th&agrave;nh thị v&agrave; cộng đồng vùng cao c&ugrave;ng tham gia bảo tồn rừng v&agrave; thi&ecirc;n nhi&ecirc;n hoang d&atilde;, nơi những mầm xanh của rừng t&aacute;i sinh được gieo n&ecirc;n bởi sự chung tay, g&oacute;p sức của x&atilde; hội.&nbsp;</p>

<p>&nbsp;</p>
', CAST(N'2022-12-20' AS Date), CAST(N'2023-03-20' AS Date), 100000000.0000, N'1', N'admin/media/thumbnail/15.jpg', CAST(N'2023-02-06' AS Date), CAST(N'2023-03-26' AS Date), N'5')
SET IDENTITY_INSERT [dbo].[Donations] OFF
GO
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Tien Tuyet', N'0978553907', N'dang.tuong@giao.gov.vn', NULL, N'Đồng Nai', N'144878d2904918a9d5b204feabe84ac9', CAST(N'2022-12-10' AS Date), N'2', N'2', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Hung Sy', N'0205203100', N'du.kieu@nguy.pro.vn', NULL, N'Hà Nội', N'4ddcf3489a0baed1cd358c3e88fd0891', CAST(N'2022-11-10' AS Date), N'2', N'2', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Nam Tran', N'0931967920', N'namtlFX17215@funix.edu.gg', NULL, N'152 Nguyen Huu Dat Street', N'b4e7c2a162150261a13e84398b90be51', CAST(N'2023-03-23' AS Date), N'1', N'1', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Cong Nguyen', N'01233140105', N'namtlFX17215@funix.edu.vn', N'user/media/avatar/01233140105.jpg', N'Bình Dương', N'a5096dcb4ab3aaef841b642bd5f6ea7', CAST(N'2022-11-30' AS Date), N'1', N'2', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Kim Thu', N'0954101381', N'namtranly49@gmail.com', NULL, N'Kiên Giang', N'cbec050404f87d508ae62671db1bb62c', CAST(N'2022-11-11' AS Date), N'2', N'2', N'sasasa')
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Manh Hoai', N'0918317525', N'ocan@be.net.vn', NULL, N'TP.HCM', N'd57ae7f8', CAST(N'2022-10-28' AS Date), N'2', N'1', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Kieu Kha', N'02102554943', N'sang.luu@lo.net.vn', NULL, N'Cần Thơ', N'90023890', CAST(N'2022-10-28' AS Date), N'2', N'2', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Nam Tran Ly', N'0931967911', N'tranlynam@gmail.cn', N'user/media/avatar/0931967911.jpg', N'152 Nguyen Huu Dat St.', N'b4e7c2a162150261a13e84398b90be51', CAST(N'2023-03-13' AS Date), N'1', N'2', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Trần Lý Nam', N'01625449897', N'tranlynam@gmail.com', N'user/media/avatar/01625449897.jpg', N'TP.HCM', N'b4e7c2a162150261a13e84398b90be51', CAST(N'2022-11-04' AS Date), N'0', N'2', NULL)
INSERT [dbo].[Users] ([name], [phone], [email], [avatar_path], [address], [password], [registration_date], [user_role], [status], [feedback]) VALUES (N'Lý Thị Đẹp', N'0931967923', N'tranlynam@gmail.kg', N'user/media/avatar/0931967923.jpg', N'Kiên Giang', N'b4e7c2a162150261a13e84398b90be51', CAST(N'2023-03-20' AS Date), N'1', N'2', NULL)
GO
SET IDENTITY_INSERT [dbo].[Users_Donation] ON 

INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (1, N'Lý Thị Đẹp', N'tranlynam@gmail.kg', N'0931967923', N'Sacombank', N'FT13165756069655', 10000000.0000, N'3', 1, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (2, N'Thanh Kim', N'thanhkim@yahoo.com', N'0931967921', N'Vietcombank', N'FT18127951977601', 5000000.0000, N'2', 2, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (3, N'Trần Lý Nam', N'tranlynam@gmail.com', N'01625449897', N'ACB', N'FT13918688274757', 7000000.0000, N'3', 2, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (4, N'Quyen Diem', N'QuyenDiem@yahoo.com', N'0931967921', N'Techcombank', N'FT15847170889071', 5000000.0000, N'2', 4, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (5, N'Kieu Kha', N'KieuKha@lo.net.vn', N'0931967922', N'TPBank', N'FT15385141865565', 5000000.0000, N'1', 5, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (6, N'Cong Nguyen', N'namtlFX17215@funix.edu.vn', N'01233140105', N'Techcombank', N'FT12918312148140', 2000000.0000, N'3', 3, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (7, N'Cong Nguyen', N'namtlFX17215@funix.edu.vn', N'01233140105', N'TPBank', N'FT11144986083444', 5000000.0000, N'2', 6, CAST(N'2023-03-30' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (13, N'Nam Tran', N'tranlynam@gmail.hcm', N'0931967444', N'TPBank', N'FT13165756069333', 10000000.0000, N'2', 15, CAST(N'2023-04-05' AS Date))
INSERT [dbo].[Users_Donation] ([user_donation_id], [name], [email], [phone], [bank], [transaction_id], [donation_amount], [user_donation_status], [donation_id], [donation_date]) VALUES (14, N'Lý Thị Đẹp', N'tranlynam@gmail.kg', N'0931967923', N'Techcombank', N'FT12918312148147', 20000000.0000, N'3', 14, CAST(N'2023-04-06' AS Date))
SET IDENTITY_INSERT [dbo].[Users_Donation] OFF
GO
ALTER TABLE [dbo].[Donations] ADD  CONSTRAINT [df_use_yn]  DEFAULT ((1)) FOR [use_yn]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [df_User_role]  DEFAULT ((2)) FOR [user_role]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [df_Status]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Users_Donation] ADD  CONSTRAINT [df_user_donation_status]  DEFAULT ('2') FOR [user_donation_status]
GO
ALTER TABLE [dbo].[Users_Donation]  WITH CHECK ADD  CONSTRAINT [FK_User_Donation_Donations1] FOREIGN KEY([donation_id])
REFERENCES [dbo].[Donations] ([donation_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users_Donation] CHECK CONSTRAINT [FK_User_Donation_Donations1]
GO
EXEC sys.sp_addextendedproperty @name=N'Chưa hoàn thành', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'donation_status'
GO
EXEC sys.sp_addextendedproperty @name=N'Hoàn thành', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'donation_status'
GO
EXEC sys.sp_addextendedproperty @name=N'Delete', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'use_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'Use', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'use_yn'
GO
EXEC sys.sp_addextendedproperty @name=N'Bảo Vệ Môi Trường', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'Bệnh Hiểm Nghèo', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'Đầu Tư Cơ Sở Vật Chất', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'Người Già, Người Khuyết Tật', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'Vì trẻ em', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Donations', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'Admin', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'user_role'
GO
EXEC sys.sp_addextendedproperty @name=N'Admin ban đầu', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'user_role'
GO
EXEC sys.sp_addextendedproperty @name=N'User', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'user_role'
GO
EXEC sys.sp_addextendedproperty @name=N'Bị khoá', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'Đang hoạt động', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'Đang chờ', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users_Donation', @level2type=N'COLUMN',@level2name=N'user_donation_status'
GO
EXEC sys.sp_addextendedproperty @name=N'Từ chối', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users_Donation', @level2type=N'COLUMN',@level2name=N'user_donation_status'
GO
EXEC sys.sp_addextendedproperty @name=N'Xác thực', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users_Donation', @level2type=N'COLUMN',@level2name=N'user_donation_status'
GO
USE [master]
GO
ALTER DATABASE [DonationDB] SET  READ_WRITE 
GO
