USE [master]
GO
/****** Object:  Database [ProfileManagement]    Script Date: 29-06-2021 02:48:46 ******/
CREATE DATABASE [ProfileManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProfileManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ProfileManagement.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ProfileManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ProfileManagement_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ProfileManagement] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProfileManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProfileManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProfileManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProfileManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProfileManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProfileManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProfileManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProfileManagement] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ProfileManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProfileManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProfileManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProfileManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProfileManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProfileManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProfileManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProfileManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProfileManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProfileManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProfileManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProfileManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProfileManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProfileManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProfileManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProfileManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProfileManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProfileManagement] SET  MULTI_USER 
GO
ALTER DATABASE [ProfileManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProfileManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProfileManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProfileManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ProfileManagement]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddProfile]    Script Date: 29-06-2021 02:48:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddProfile]
	@Id int,
	@FullName nvarchar(255),
	@EmailId nvarchar(255),
	@Mobile nvarchar(20),
	@IsActive bit
AS
BEGIN	
	SET NOCOUNT ON;

	IF(@Id > 0)
		BEGIN
			UPDATE ProfileMaster SET FullName = @FullName, EmailId = @EmailId, Mobile = @Mobile, IsActive = @IsActive WHERE Id = @Id;
		END
	ELSE
		BEGIN
			INSERT INTO ProfileMaster(FullName, EmailId, Mobile, IsActive, CreatedOn, CreatedBy) 
			values (@FullName, @EmailId, @Mobile, @IsActive, GETUTCDATE(), -1);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteProfile]    Script Date: 29-06-2021 02:48:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteProfile]
	@Id int
AS
BEGIN	
	SET NOCOUNT ON;
	DELETE FROM ProfileMaster WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProfiles]    Script Date: 29-06-2021 02:48:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetProfiles]
	@FilterActive bit,
	@Id int
AS
BEGIN	
	SET NOCOUNT ON;

	IF(@FilterActive = 1)
		BEGIN			
			SELECT * FROM ProfileMaster WHERE ISNULL(IsActive, 0) = 1 AND Id = CASE WHEN @Id > 0 THEN @Id ELSE Id END;
		END
	ELSE
		BEGIN
			SELECT * FROM ProfileMaster WHERE Id = CASE WHEN @Id > 0 THEN @Id ELSE Id END;
		END    
END

GO
/****** Object:  Table [dbo].[ProfileMaster]    Script Date: 29-06-2021 02:48:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileMaster](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[EmailId] [nvarchar](255) NOT NULL,
	[Mobile] [nvarchar](20) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
 CONSTRAINT [PK_ProfileMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ProfileMaster] ON 

INSERT [dbo].[ProfileMaster] ([Id], [FullName], [EmailId], [Mobile], [IsActive], [CreatedOn], [CreatedBy]) VALUES (10005, N'Ram Kewal', N'sgdf@sfh.cht', N'+91 9384736458', 1, CAST(0x0000AD5600942987 AS DateTime), -1)
SET IDENTITY_INSERT [dbo].[ProfileMaster] OFF
USE [master]
GO
ALTER DATABASE [ProfileManagement] SET  READ_WRITE 
GO
