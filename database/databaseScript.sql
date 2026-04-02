USE [master]
GO
/****** Object:  Database [DoctorLicenseDB]    Script Date: 4/2/2026 1:27:49 PM ******/
CREATE DATABASE [DoctorLicenseDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DoctorLicenseDB', FILENAME = N'D:\Databases\MSSQL15.MSSQLSERVER\MSSQL\DATA\DoctorLicenseDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DoctorLicenseDB_log', FILENAME = N'D:\Databases\MSSQL15.MSSQLSERVER\MSSQL\DATA\DoctorLicenseDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DoctorLicenseDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DoctorLicenseDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DoctorLicenseDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DoctorLicenseDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DoctorLicenseDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DoctorLicenseDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DoctorLicenseDB] SET  MULTI_USER 
GO
ALTER DATABASE [DoctorLicenseDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DoctorLicenseDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DoctorLicenseDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DoctorLicenseDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DoctorLicenseDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DoctorLicenseDB', N'ON'
GO
USE [DoctorLicenseDB]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 4/2/2026 1:27:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](200) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Specialization] [nvarchar](100) NOT NULL,
	[LicenseNumber] [nvarchar](50) NOT NULL,
	[LicenseExpiryDate] [date] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[DeletedDate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Doctors] ON 
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1, N'Ali', N'ali@yahoo.com', N'string', N'string', CAST(N'2026-04-02' AS Date), N'Active', CAST(N'2026-04-02T05:21:02.3268677' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (2, N'Bilal', N'bilal@yahoo.com', N'Skin ', N'2223', CAST(N'2026-04-02' AS Date), N'Active', CAST(N'2026-04-02T05:24:52.7883341' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1002, N'Sohail', N'sohail@yahoo.com', N'Dermatologist', N'3344', CAST(N'2026-04-02' AS Date), N'Active', CAST(N'2026-04-02T08:18:26.3325428' AS DateTime2), 1, CAST(N'2026-04-02T08:19:22.1948168' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Doctors] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Doctors__A9D10534CF46676A]    Script Date: 4/2/2026 1:27:49 PM ******/
ALTER TABLE [dbo].[Doctors] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Doctors__E8890166675F963C]    Script Date: 4/2/2026 1:27:49 PM ******/
ALTER TABLE [dbo].[Doctors] ADD UNIQUE NONCLUSTERED 
(
	[LicenseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Doctors_IsDeleted]    Script Date: 4/2/2026 1:27:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_IsDeleted] ON [dbo].[Doctors]
(
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Doctors_LicenseNumber]    Script Date: 4/2/2026 1:27:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_LicenseNumber] ON [dbo].[Doctors]
(
	[LicenseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Doctors_Status]    Script Date: 4/2/2026 1:27:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_Status] ON [dbo].[Doctors]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDoctorsList]    Script Date: 4/2/2026 1:27:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- database/scripts/03_stored_procedures.sql
-- Main stored procedure for doctor listing with search and filter
CREATE PROCEDURE [dbo].[sp_GetDoctorsList]
    @SearchTerm NVARCHAR(200) = NULL,
    @StatusFilter NVARCHAR(20) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    
    -- Update status based on expiry date
    UPDATE Doctors
    SET Status = CASE 
        WHEN LicenseExpiryDate < CAST(GETUTCDATE() AS DATE) THEN 'Expired'
        WHEN Status = 'Expired' AND LicenseExpiryDate >= CAST(GETUTCDATE() AS DATE) THEN 'Active'
        ELSE Status
    END
    WHERE IsDeleted = 0;
    
    -- Get filtered and paginated results
    SELECT 
    Id,
    FullName,
    Email,
    Specialization,
    LicenseNumber,
    LicenseExpiryDate,
    Status,
    CreatedDate,
    IsDeleted,
    DeletedDate,
    COUNT(*) OVER() AS TotalCount
    FROM Doctors
    WHERE IsDeleted = 0
        AND (@SearchTerm IS NULL OR 
             FullName LIKE '%' + @SearchTerm + '%' OR 
             LicenseNumber LIKE '%' + @SearchTerm + '%')
        AND (@StatusFilter IS NULL OR Status = @StatusFilter)
    ORDER BY CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetExpiredDoctors]    Script Date: 4/2/2026 1:27:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Bonus: Stored procedure for expired doctors
CREATE PROCEDURE [dbo].[sp_GetExpiredDoctors]
    @PageNumber INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    
    -- Update status first
    UPDATE Doctors
    SET Status = CASE 
        WHEN LicenseExpiryDate < CAST(GETUTCDATE() AS DATE) THEN 'Expired'
        ELSE Status
    END
    WHERE IsDeleted = 0;
    
    SELECT 
        Id,
        FullName,
        Email,
        Specialization,
        LicenseNumber,
        LicenseExpiryDate,
        Status,
        CreatedDate,
        COUNT(*) OVER() AS TotalCount
    FROM Doctors
    WHERE IsDeleted = 0 
        AND Status = 'Expired'
    ORDER BY LicenseExpiryDate ASC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
USE [master]
GO
ALTER DATABASE [DoctorLicenseDB] SET  READ_WRITE 
GO
