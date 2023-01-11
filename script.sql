USE [master]
GO
/****** Object:  Database [DonationDB]    Script Date: 1/12/2023 5:55:07 AM ******/
CREATE DATABASE [DonationDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DonationDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DonationDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DonationDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DonationDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DonationDB] SET COMPATIBILITY_LEVEL = 150
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
ALTER DATABASE [DonationDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DonationDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DonationDB', N'ON'
GO
ALTER DATABASE [DonationDB] SET QUERY_STORE = OFF
GO
USE [DonationDB]
GO
/****** Object:  User [Amida]    Script Date: 1/12/2023 5:55:08 AM ******/
CREATE USER [Amida] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 1/12/2023 5:55:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[name] [nvarchar](30) NULL,
	[phone] [nvarchar](15) NULL,
	[email] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NULL,
	[registration_date] [date] NULL,
	[account_role] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Donations]    Script Date: 1/12/2023 5:55:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[donation_id] [int] IDENTITY(1,1) NOT NULL,
	[donation_status] [int] NULL,
	[donation_title] [nvarchar](max) NULL,
	[donation_content] [nvarchar](max) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[total_needed] [money] NULL,
 CONSTRAINT [PK__Donation__296B91DC847C71F1] PRIMARY KEY CLUSTERED 
(
	[donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Donation]    Script Date: 1/12/2023 5:55:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Donation](
	[user_donation_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NULL,
	[email] [nvarchar](30) NULL,
	[user_donation_status] [nvarchar](10) NULL,
	[donation_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Donation_detail]    Script Date: 1/12/2023 5:55:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Donation_detail](
	[user_donation_id] [int] IDENTITY(1,1) NOT NULL,
	[donation_id] [int] NULL,
	[bank_name] [nvarchar](30) NULL,
	[bank_account] [nvarchar](10) NULL,
	[donation_amount] [money] NULL,
	[transaction_id] [nvarchar](16) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Donations] ON 

INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed]) VALUES (1, 2, N'sasasa', N'<p>sasasas</p>
', CAST(N'2023-01-14' AS Date), CAST(N'2023-01-21' AS Date), 121212.0000)
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed]) VALUES (2, 2, N'wqwqw', N'<p>sads</p>
', CAST(N'2023-01-13' AS Date), CAST(N'2023-01-14' AS Date), 121212.0000)
INSERT [dbo].[Donations] ([donation_id], [donation_status], [donation_title], [donation_content], [start_date], [end_date], [total_needed]) VALUES (4, 1, N'sasas', N'<p>sasasa</p>
', CAST(N'2023-01-10' AS Date), CAST(N'2023-01-17' AS Date), 121212.0000)
SET IDENTITY_INSERT [dbo].[Donations] OFF
GO
ALTER TABLE [dbo].[User_Donation]  WITH CHECK ADD  CONSTRAINT [FK_User_Donation_Accounts] FOREIGN KEY([email])
REFERENCES [dbo].[Accounts] ([email])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Donation] CHECK CONSTRAINT [FK_User_Donation_Accounts]
GO
ALTER TABLE [dbo].[User_Donation_detail]  WITH CHECK ADD  CONSTRAINT [FK_User_Donation_detail_Donations] FOREIGN KEY([donation_id])
REFERENCES [dbo].[Donations] ([donation_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_Donation_detail] CHECK CONSTRAINT [FK_User_Donation_detail_Donations]
GO
ALTER TABLE [dbo].[User_Donation_detail]  WITH CHECK ADD  CONSTRAINT [FK_User_Donation_detail_User_Donation] FOREIGN KEY([user_donation_id])
REFERENCES [dbo].[User_Donation] ([user_donation_id])
GO
ALTER TABLE [dbo].[User_Donation_detail] CHECK CONSTRAINT [FK_User_Donation_detail_User_Donation]
GO
USE [master]
GO
ALTER DATABASE [DonationDB] SET  READ_WRITE 
GO
