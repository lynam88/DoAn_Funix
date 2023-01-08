USE [master]
GO
/****** Object:  Database [DonationDB]    Script Date: 1/9/2023 6:06:26 AM ******/
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
/****** Object:  User [Amida]    Script Date: 1/9/2023 6:06:26 AM ******/
CREATE USER [Amida] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 1/9/2023 6:06:26 AM ******/
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
/****** Object:  Table [dbo].[Donations]    Script Date: 1/9/2023 6:06:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[donation_id] [int] IDENTITY(1,1) NOT NULL,
	[donation_name] [nvarchar](max) NULL,
	[donation_content] [nvarchar](max) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[total_needed] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Donation]    Script Date: 1/9/2023 6:06:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Donation](
	[user_donation_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NULL,
	[email] [nvarchar](30) NULL,
	[donation_status] [nvarchar](10) NULL,
	[donation_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_donation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Donation_detail]    Script Date: 1/9/2023 6:06:26 AM ******/
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

INSERT [dbo].[Donations] ([donation_id], [donation_name], [donation_content], [start_date], [end_date], [total_needed]) VALUES (1, N'N''Chung tay quyÃªn gÃ³p há» trá»£ mÃ¡i che vÃ  sÃ¢n trÆ°á»ng cho cÃ¡c em há»c sinh táº¡i vÃ¹ng xa thuá»c tá»nh BÃ¬nh Thuáº­n''', N'N<p>N</p>

<p><strong>Ho&agrave;n c&aacute;&ordm;&pound;nh kh&oacute; kh&Auml;&Acirc;&Acirc;Ân thi&aacute;&ordm;&iquest;u th&aacute;&raquo;&Acirc;&Acirc;Ân v&aacute;&raquo;&Acirc;&Acirc;Â c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&ordm;&shy;t ch&aacute;&ordm;&yen;t c&aacute;&raquo;&sect;a c&aacute;c em h&aacute;&raquo;&Acirc;&Acirc;Âc sinh v&ugrave;ng xa</strong></p>

<p>&aacute;&raquo;&Acirc;&Acirc;Â nh&aacute;&raquo;&macr;ng v&ugrave;ng qu&ecirc; ngh&egrave;o, c&aacute;c em h&aacute;&raquo;&Acirc;&Acirc;Âc sinh lu&ocirc;n ph&aacute;&ordm;&pound;i ch&aacute;&raquo;&Acirc;&Acirc;Âu nh&aacute;&raquo;&macr;ng thi&aacute;&raquo;&Acirc;&Acirc;Ât th&ograve;i v&aacute;&raquo;&Acirc;&Acirc;Â &Auml;&Acirc;&Acirc;Âi&aacute;&raquo;&Acirc;&Acirc;Âu ki&aacute;&raquo;&Acirc;&Acirc;Ân c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&ordm;&shy;t ch&aacute;&ordm;&yen;t. Tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng M&aacute;&ordm;&laquo;u gi&aacute;o H&agrave;m M&aacute;&raquo;&sup1; v&agrave; tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng Ti&aacute;&raquo;&Acirc;&Acirc;Âu h&aacute;&raquo;&Acirc;&Acirc;Âc T&acirc;n Thu&aacute;&ordm;&shy;n 3 thu&aacute;&raquo;&Acirc;&Acirc;Âc huy&aacute;&raquo;&Acirc;&Acirc;Ân H&agrave;m Thu&aacute;&ordm;&shy;n Nam, t&aacute;&raquo;&Acirc;&Acirc;Ânh B&igrave;nh Thu&aacute;&ordm;&shy;n l&agrave; m&aacute;&raquo;&Acirc;&Acirc;Ât trong nhi&aacute;&raquo;&Acirc;&Acirc;Âu ng&ocirc;i tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng c&ograve;n nhi&aacute;&raquo;&Acirc;&Acirc;Âu thi&aacute;&ordm;&iquest;u th&aacute;&raquo;&Acirc;&Acirc;Ân. &Auml;&Acirc;&Acirc;Âi&aacute;&raquo;&Acirc;&Acirc;Âu &Auml;&Acirc;&Acirc;Â&oacute; khi&aacute;&ordm;&iquest;n cho vi&aacute;&raquo;&Acirc;&Acirc;Âc h&aacute;&raquo;&Acirc;&Acirc;Âc t&aacute;&ordm;&shy;p v&agrave; r&egrave;n luy&aacute;&raquo;&Acirc;&Acirc;Ân s&aacute;&raquo;&copy;c kh&aacute;&raquo;&Acirc;&Acirc;Âe c&aacute;&raquo;&sect;a c&aacute;c em h&aacute;&raquo;&Acirc;&Acirc;Âc sinh n&AElig;&iexcl;i &Auml;&Acirc;&Acirc;Â&acirc;y g&aacute;&ordm;&middot;p nhi&aacute;&raquo;&Acirc;&Acirc;Âu tr&aacute;&raquo;&Acirc;&Acirc;Â ng&aacute;&ordm;&iexcl;i.&nbsp;&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112544-638000475440260194.jpg" /><em>S&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng ng&aacute;&ordm;&shy;p n&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âc trong m&ugrave;a m&AElig;&deg;a c&aacute;&raquo;&sect;a tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng Ti&aacute;&raquo;&Acirc;&Acirc;Âu h&aacute;&raquo;&Acirc;&Acirc;Âc T&acirc;n Thu&aacute;&ordm;&shy;n 3</em></p>

<ul>
	<li>&ldquo;C&ocirc; &AElig;&iexcl;i! N&aacute;&ordm;&macr;ng chi&aacute;&ordm;&iquest;u v&agrave;o ph&ograve;ng n&aacute;&ordm;&macr;ng qu&aacute;!&rdquo;,&nbsp;</li>
	<li>&ldquo;Th&aacute;&ordm;&sect;y &AElig;&iexcl;i! H&ocirc;m nay s&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng n&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âc nhi&aacute;&raquo;&Acirc;&Acirc;Âu n&ecirc;n em mang d&eacute;p &Auml;&Acirc;&Acirc;Âi h&aacute;&raquo;&Acirc;&Acirc;Âc &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c kh&ocirc;ng &aacute;&ordm;&iexcl;?&rdquo;.</li>
</ul>

<p>L&agrave; nh&aacute;&raquo;&macr;ng c&acirc;u m&agrave; gi&aacute;o vi&ecirc;n &aacute;&raquo;&Acirc;&Acirc;Â tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng Ti&aacute;&raquo;&Acirc;&Acirc;Âu h&aacute;&raquo;&Acirc;&Acirc;Âc T&acirc;n Thu&aacute;&ordm;&shy;n 3 c&oacute; th&aacute;&raquo;&Acirc;&Acirc;Â nghe nhi&aacute;&raquo;&Acirc;&Acirc;Âu l&aacute;&ordm;&sect;n m&aacute;&raquo;&Acirc;&Acirc;Âi m&ugrave;a n&aacute;&ordm;&macr;ng g&aacute;&ordm;&macr;t &Auml;&Acirc;&Acirc;Â&aacute;&ordm;&iquest;n hay m&ugrave;a m&AElig;&deg;a v&aacute;&raquo;&Acirc;&Acirc;Â. &aacute;&raquo;&Acirc;&Acirc;Â ng&ocirc;i tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng m&agrave; c&aacute;c em &Auml;&Acirc;&Acirc;Âang theo h&aacute;&raquo;&Acirc;&Acirc;Âc, m&ugrave;a h&egrave; &Auml;&Acirc;&Acirc;Â&aacute;&ordm;&iquest;n s&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng n&aacute;&ordm;&macr;ng ch&oacute;i chang, kh&ocirc;ng c&oacute; kh&ocirc;ng gian cho h&aacute;&raquo;&Acirc;&Acirc;Âc sinh vui ch&AElig;&iexcl;i, n&ocirc; &Auml;&Acirc;&Acirc;Â&ugrave;a. Khi m&ugrave;a m&AElig;&deg;a v&aacute;&raquo;&Acirc;&Acirc;Â th&igrave; nh&aacute;&raquo;&macr;ng ng&agrave;y th&aacute;&raquo;&copy; 2 &Auml;&Acirc;&Acirc;Â&aacute;&ordm;&sect;u tu&aacute;&ordm;&sect;n, h&aacute;&raquo;&Acirc;&Acirc;Âc sinh s&aacute;&ordm;&frac12; ph&aacute;&ordm;&pound;i ng&aacute;&raquo;&Acirc;&Acirc;Âi ch&agrave;o c&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&raquo;&Acirc;&Acirc;Âi m&aacute;&raquo;&Acirc;&Acirc;Ât s&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng &Auml;&Acirc;&Acirc;Â&aacute;&ordm;&sect;y n&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âc c&oacute; l&aacute;&ordm;&frac12; c&Aring;&copy;ng tr&aacute;&raquo;&Acirc;&Acirc;Â n&ecirc;n quen thu&aacute;&raquo;&Acirc;&Acirc;Âc. H&igrave;nh &aacute;&ordm;&pound;nh h&aacute;&raquo;&Acirc;&Acirc;Âc sinh v&agrave; gi&aacute;o vi&ecirc;n &Auml;&Acirc;&Acirc;Â&aacute;&ordm;&iquest;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng v&aacute;&raquo;&Acirc;&Acirc;Âi nh&aacute;&raquo;&macr;ng chi&aacute;&ordm;&iquest;c &aacute;&raquo;&Acirc;&Acirc;Âng qu&aacute;&ordm;&sect;n &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c x&aacute;&ordm;&macr;n cao ng&agrave;y m&AElig;&deg;a &Auml;&Acirc;&Acirc;Â&atilde; qu&aacute; &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âi b&igrave;nh th&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng. Th&aacute;&ordm;&iquest; nh&AElig;&deg;ng c&aacute;c gi&aacute;o vi&ecirc;n &aacute;&raquo;&Acirc;&Acirc;Â tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng v&aacute;&ordm;&laquo;n lu&ocirc;n ki&ecirc;n tr&igrave; t&igrave;m c&aacute;ch ch&aacute;&ordm;&macr;n m&AElig;&deg;a, che m&aacute;t &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Â c&aacute;c em h&aacute;&raquo;&Acirc;&Acirc;Âc sinh c&oacute; th&aacute;&raquo;&Acirc;&Acirc;Â y&ecirc;n t&acirc;m theo &Auml;&Acirc;&Acirc;Âu&aacute;&raquo;&Acirc;&Acirc;Âi con ch&aacute;&raquo;&macr;.&nbsp;</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112626-638000475866509703.jpg" /></p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112641-638000476018331732.jpg" /><em>C&aacute;c em ph&aacute;&ordm;&pound;i ch&agrave;o c&aacute;&raquo;&Acirc;&Acirc;Â v&agrave; vui ch&AElig;&iexcl;i d&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âi s&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng kh&ocirc;ng m&aacute;i che&nbsp;</em></p>

<p>M&aacute;&ordm;&middot;c d&ugrave; c&aacute;c tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng h&aacute;&raquo;&Acirc;&Acirc;Âc &aacute;&raquo;&Acirc;&Acirc;Â huy&aacute;&raquo;&Acirc;&Acirc;Ân H&agrave;m Thu&aacute;&ordm;&shy;n Nam, t&aacute;&raquo;&Acirc;&Acirc;Ânh B&igrave;nh Thu&aacute;&ordm;&shy;n &Auml;&Acirc;&Acirc;Â&atilde; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c h&aacute;&raquo;&Acirc;&Acirc;Â tr&aacute;&raquo;&pound; nhi&aacute;&raquo;&Acirc;&Acirc;Âu v&aacute;&raquo;&Acirc;&Acirc;Â c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&ordm;&shy;t ch&aacute;&ordm;&yen;t, nh&AElig;&deg;ng v&aacute;&ordm;&laquo;n c&ograve;n &Auml;&Acirc;&Acirc;Â&oacute; r&aacute;&ordm;&yen;t nhi&aacute;&raquo;&Acirc;&Acirc;Âu th&aacute;&raquo;&copy; c&aacute;&ordm;&sect;n ph&aacute;&ordm;&pound;i x&atilde; h&aacute;&raquo;&Acirc;&Acirc;Âi ho&aacute;. &Auml;&Acirc;&Acirc;Â&aacute;&ordm;&middot;c bi&aacute;&raquo;&Acirc;&Acirc;Ât t&aacute;&ordm;&iexcl;i v&ugrave;ng n&ocirc;ng th&ocirc;n, n&AElig;&iexcl;i m&agrave; vi&aacute;&raquo;&Acirc;&Acirc;Âc v&aacute;&ordm;&shy;n &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âng ph&aacute;&raquo;&yen; huynh c&ograve;n nhi&aacute;&raquo;&Acirc;&Acirc;Âu kh&oacute; kh&Auml;&Acirc;&Acirc;Ân. B&aacute;&raquo;&Acirc;&Acirc;Âi v&igrave; cu&aacute;&raquo;&Acirc;&Acirc;Âc s&aacute;&raquo;&Acirc;&Acirc;Âng h&aacute;&raquo;&Acirc;&Acirc;Â c&ograve;n v&ocirc; v&agrave;n kh&oacute; kh&Auml;&Acirc;&Acirc;Ân ph&aacute;&ordm;&pound;i &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âi m&aacute;&ordm;&middot;t. H&AElig;&iexcl;n n&aacute;&raquo;&macr;a t&aacute;&ordm;&iexcl;i &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âa ph&AElig;&deg;&AElig;&iexcl;ng c&Aring;&copy;ng kh&ocirc;ng c&oacute; nhi&aacute;&raquo;&Acirc;&Acirc;Âu doanh nghi&aacute;&raquo;&Acirc;&Acirc;Âp &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&ordm;&shy;n &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âng, n&ecirc;n nh&aacute;&raquo;&macr;ng kh&oacute; kh&Auml;&Acirc;&Acirc;Ân c&aacute;&raquo;&sect;a c&aacute;c tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng &aacute;&raquo;&Acirc;&Acirc;Â v&ugrave;ng s&acirc;u v&ugrave;ng xa v&aacute;&ordm;&laquo;n ch&AElig;&deg;a &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c ho&agrave;n to&agrave;n c&aacute;&ordm;&pound;i thi&aacute;&raquo;&Acirc;&Acirc;Ân.</p>

<p><strong>Chung tay mang l&aacute;&ordm;&iexcl;i &Auml;&Acirc;&Acirc;Âi&aacute;&raquo;&Acirc;&Acirc;Âu ki&aacute;&raquo;&Acirc;&Acirc;Ân c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&ordm;&shy;t ch&aacute;&ordm;&yen;t t&aacute;&raquo;&Acirc;&Acirc;Ât h&AElig;&iexcl;n cho c&aacute;c b&eacute; m&aacute;&ordm;&sect;m non v&agrave; ti&aacute;&raquo;&Acirc;&Acirc;Âu h&aacute;&raquo;&Acirc;&Acirc;Âc</strong></p>

<p>T&aacute;&raquo;&laquo; m&aacute;&raquo;&Acirc;&Acirc;Ât t&aacute;&ordm;&yen;m l&ograve;ng h&aacute;&ordm;&pound;o t&acirc;m c&aacute;&raquo;&sect;a c&aacute;&raquo;&Acirc;&Acirc;Âng &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âng Tr&aacute;i Tim MoMo, s&aacute;&ordm;&frac12; gi&uacute;p trung b&igrave;nh 426 em h&aacute;&raquo;&Acirc;&Acirc;Âc sinh m&aacute;&raquo;&Acirc;&Acirc;Âi n&Auml;&Acirc;&Acirc;Âm t&aacute;&ordm;&iexcl;i tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng Ti&aacute;&raquo;&Acirc;&Acirc;Âu h&aacute;&raquo;&Acirc;&Acirc;Âc T&acirc;n Thu&aacute;&ordm;&shy;n 3 c&oacute; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c m&aacute;&raquo;&Acirc;&Acirc;Ât s&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng cao r&aacute;o s&aacute;&ordm;&iexcl;ch s&aacute;&ordm;&frac12; h&AElig;&iexcl;n, 55 em nh&aacute;&raquo;&Acirc;&Acirc;Â t&aacute;&ordm;&iexcl;i tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng M&aacute;&ordm;&laquo;u gi&aacute;o H&agrave;m M&aacute;&raquo;&sup1; (c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â Ph&uacute; S&AElig;&iexcl;n) c&oacute; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c m&aacute;i che cho nh&aacute;&raquo;&macr;ng ng&agrave;y n&aacute;&ordm;&macr;ng m&AElig;&deg;a. Th&agrave;nh qu&aacute;&ordm;&pound; &Auml;&Acirc;&Acirc;Â&oacute; s&aacute;&ordm;&frac12; t&aacute;&ordm;&iexcl;o &Auml;&Acirc;&Acirc;Âi&aacute;&raquo;&Acirc;&Acirc;Âu ki&aacute;&raquo;&Acirc;&Acirc;Ân t&aacute;&raquo;&Acirc;&Acirc;Ât nh&aacute;&ordm;&yen;t cho c&aacute;c em &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c h&aacute;&raquo;&Acirc;&Acirc;Âc t&aacute;&ordm;&shy;p v&agrave; ph&aacute;t tri&aacute;&raquo;&Acirc;&Acirc;Ân.</p>

<p><img alt="" src="https://static.mservice.io/blogscontents/momo-upload-api-220929112709-638000476295949668.jpg" /><em>Chung tay gi&uacute;p c&aacute;c em h&aacute;&raquo;&Acirc;&Acirc;Âc sinh c&oacute; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c m&aacute;i che &aacute;&raquo;&Acirc;&Acirc;Â s&acirc;n tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng cho nh&aacute;&raquo;&macr;ng ng&agrave;y n&aacute;&ordm;&macr;ng m&AElig;&deg;a</em></p>

<p>Tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng Ti&aacute;&raquo;&Acirc;&Acirc;Âu h&aacute;&raquo;&Acirc;&Acirc;Âc T&acirc;n Thu&aacute;&ordm;&shy;n 3 v&agrave; tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng M&aacute;&ordm;&laquo;u gi&aacute;o H&agrave;m M&aacute;&raquo;&sup1; (c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â Ph&uacute; S&AElig;&iexcl;n) s&aacute;&ordm;&frac12; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c h&aacute;&raquo;&Acirc;&Acirc;Â tr&aacute;&raquo;&pound; 16 tri&aacute;&raquo;&Acirc;&Acirc;Âu &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âng cho m&aacute;&raquo;&Acirc;&Acirc;Âi ng&ocirc;i tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng. V&agrave; ph&aacute;&ordm;&sect;n chi ph&iacute; c&ograve;n l&aacute;&ordm;&iexcl;i c&aacute;&raquo;&sect;a c&aacute;c c&ocirc;ng tr&igrave;nh tr&ecirc;n s&aacute;&ordm;&frac12; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c nh&agrave; tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng ti&aacute;&ordm;&iquest;p t&aacute;&raquo;&yen;c v&aacute;&ordm;&shy;n &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âng x&atilde; h&aacute;&raquo;&Acirc;&Acirc;Âi ho&aacute;.</p>

<p>Thay m&aacute;&ordm;&middot;t ban gi&aacute;m hi&aacute;&raquo;&Acirc;&Acirc;Âu nh&agrave; tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng, Thi&aacute;&raquo;&Acirc;&Acirc;Ân Ch&iacute; bi&aacute;&ordm;&iquest;t &AElig;&iexcl;n nh&aacute;&raquo;&macr;ng t&aacute;&ordm;&yen;m l&ograve;ng c&aacute;&raquo;&sect;a c&aacute;&raquo;&Acirc;&Acirc;Âng &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Âng ng&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âi d&ugrave;ng MoMo &Auml;&Acirc;&Acirc;Â&atilde; lu&ocirc;n quan t&acirc;m, gi&uacute;p &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&iexcl; &Auml;&Acirc;&Acirc;Â&aacute;&raquo;&Acirc;&Acirc;Â c&aacute;c b&eacute; &Auml;&Acirc;&Acirc;Â&AElig;&deg;&aacute;&raquo;&pound;c y&ecirc;n t&acirc;m h&aacute;&raquo;&Acirc;&Acirc;Âc t&aacute;&ordm;&shy;p d&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âi m&aacute;&raquo;&Acirc;&Acirc;Ât ng&ocirc;i tr&AElig;&deg;&aacute;&raquo;&Acirc;&Acirc;Âng c&oacute; &Auml;&Acirc;&Acirc;Âi&aacute;&raquo;&Acirc;&Acirc;Âu ki&aacute;&raquo;&Acirc;&Acirc;Ân c&AElig;&iexcl; s&aacute;&raquo;&Acirc;&Acirc;Â v&aacute;&ordm;&shy;t ch&aacute;&ordm;&yen;t khang trang h&AElig;&iexcl;n.&nbsp;</p>
''', CAST(N'2022-01-12' AS Date), CAST(N'2022-01-12' AS Date), 37000000.0000)
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
