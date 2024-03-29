USE [master]
GO
/****** Object:  Database [SeekingAlpha_db]    Script Date: 02/06/2019 12:03:14 ******/
CREATE DATABASE [SeekingAlpha_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SeekingAlpha_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SeekingAlpha_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SeekingAlpha_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SeekingAlpha_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SeekingAlpha_db] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SeekingAlpha_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SeekingAlpha_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SeekingAlpha_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SeekingAlpha_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SeekingAlpha_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SeekingAlpha_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET RECOVERY FULL 
GO
ALTER DATABASE [SeekingAlpha_db] SET  MULTI_USER 
GO
ALTER DATABASE [SeekingAlpha_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SeekingAlpha_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SeekingAlpha_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SeekingAlpha_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SeekingAlpha_db] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SeekingAlpha_db', N'ON'
GO
ALTER DATABASE [SeekingAlpha_db] SET QUERY_STORE = OFF
GO
USE [SeekingAlpha_db]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [SeekingAlpha_db]
GO
/****** Object:  Schema [SeekingAlphaDB_Schema]    Script Date: 02/06/2019 12:03:14 ******/
CREATE SCHEMA [SeekingAlphaDB_Schema]
GO
/****** Object:  Table [dbo].[FollowingUsers]    Script Date: 02/06/2019 12:03:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FollowingUsers](
	[User_Id] [int] NOT NULL,
	[FollowingUser_Id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 02/06/2019 12:03:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/06/2019 12:03:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Group_Id] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUsersTbl]    Script Date: 02/06/2019 12:03:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_GetUsersTbl] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select tmpTbl.Id, tmpTbl.[Name], tmpTbl.[GroupName] ,tmpTbl2.FollowersList  from(
		select u.Id,u.[name] 'Name' , g.[name]  'GroupName'
		from users u
		join Groups g on u.Group_Id=g.Id) tmpTbl
	left join (
		select u.Id userId,string_agg(fu.[user_id], ',') as FollowersList 
		from users u
		join followingusers  fu
		on u.Id=fu.[followinguser_id]
		group by Id) tmpTbl2 
	on tmpTbl.Id=tmpTbl2.userId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateFollowers]    Script Date: 02/06/2019 12:03:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateFollowers]
	@userId int,
	@followingUserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   IF EXISTS (SELECT * FROM [SeekingAlpha_db].[dbo].[FollowingUsers] WHERE [User_id]=@userId and [FollowingUser_Id]=@followingUserId)
    DELETE FROM [SeekingAlpha_db].[dbo].[FollowingUsers] WHERE [User_id]=@userId and [FollowingUser_Id]=@followingUserId
ELSE
    INSERT INTO [SeekingAlpha_db].[dbo].[FollowingUsers] VALUES (@userId,@followingUserId)
END
GO
USE [master]
GO
ALTER DATABASE [SeekingAlpha_db] SET  READ_WRITE 
GO
