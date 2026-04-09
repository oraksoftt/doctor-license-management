
USE [DoctorLicenseDB]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 4/9/2026 6:36:20 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Doctors] ON 
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (2, N'Bilal', N'bilal@yahoo.com', N'Skin ', N'2223', CAST(N'2026-04-02' AS Date), N'Expired', CAST(N'2026-04-02T05:24:52.7883341' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1002, N'Sohail', N'sohail@yahoo.com', N'Dermatologist', N'3344', CAST(N'2026-04-02' AS Date), N'Active', CAST(N'2026-04-02T08:18:26.3325428' AS DateTime2), 1, CAST(N'2026-04-02T08:19:22.1948168' AS DateTime2))
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1003, N'Fahad', N'fahad@yahoo.com', N'Child', N'8520', CAST(N'2026-04-09' AS Date), N'NearExpiry', CAST(N'2026-04-09T09:57:00.1409069' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1004, N'Saleem ', N'saleem@yahoo.om', N'Cardiologist', N'4544', CAST(N'2026-04-08' AS Date), N'Expired', CAST(N'2026-04-09T09:58:22.7390164' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1018, N'Zain', N'zain@yahoo.com', N'Chil', N'8877', CAST(N'2026-04-19' AS Date), N'NearExpiry', CAST(N'2026-04-09T11:21:00.9116388' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1019, N'Mushtaq', N'mushtaq@yahoo.com', N'Skin', N'7788', CAST(N'2026-05-29' AS Date), N'Active', CAST(N'2026-04-09T12:49:52.7116669' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[Doctors] ([Id], [FullName], [Email], [Specialization], [LicenseNumber], [LicenseExpiryDate], [Status], [CreatedDate], [IsDeleted], [DeletedDate]) VALUES (1020, N'Salman', N'salman@yahoo.com', N'SKin', N'8888', CAST(N'2026-05-30' AS Date), N'Active', CAST(N'2026-04-09T12:58:25.9591627' AS DateTime2), 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[Doctors] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Doctors__A9D10534CF46676A]    Script Date: 4/9/2026 6:36:20 PM ******/
ALTER TABLE [dbo].[Doctors] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Doctors__E8890166675F963C]    Script Date: 4/9/2026 6:36:20 PM ******/
ALTER TABLE [dbo].[Doctors] ADD UNIQUE NONCLUSTERED 
(
	[LicenseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Doctors_IsDeleted]    Script Date: 4/9/2026 6:36:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_IsDeleted] ON [dbo].[Doctors]
(
	[IsDeleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Doctors_LicenseNumber]    Script Date: 4/9/2026 6:36:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_LicenseNumber] ON [dbo].[Doctors]
(
	[LicenseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Doctors_Status]    Script Date: 4/9/2026 6:36:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Doctors_Status] ON [dbo].[Doctors]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDoctorsList]    Script Date: 4/9/2026 6:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetDoctorsList]
    @SearchTerm NVARCHAR(200) = NULL,
    @StatusFilter NVARCHAR(20) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    /*
    -- Update status based on expiry date
    UPDATE Doctors
    SET Status = CASE 
        WHEN LicenseExpiryDate < CAST(GETUTCDATE() AS DATE) THEN 'Expired'
        WHEN Status = 'Expired' AND LicenseExpiryDate >= CAST(GETUTCDATE() AS DATE) THEN 'Active'
        ELSE Status
    END
    WHERE IsDeleted = 0;
    */
	UPDATE Doctors
	SET Status = CASE 
    WHEN LicenseExpiryDate < CAST(GETUTCDATE() AS DATE) THEN 'Expired'
    WHEN LicenseExpiryDate BETWEEN CAST(GETUTCDATE() AS DATE) AND DATEADD(DAY, 30, CAST(GETUTCDATE() AS DATE)) 
	THEN 'NearExpiry'
    ELSE 'Active'
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
/****** Object:  StoredProcedure [dbo].[sp_GetExpiredDoctors]    Script Date: 4/9/2026 6:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


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
    WHEN LicenseExpiryDate BETWEEN CAST(GETUTCDATE() AS DATE) AND DATEADD(DAY, 30, CAST(GETUTCDATE() AS DATE)) 
	THEN 'NearExpiry'
    ELSE 'Active'
	END
    WHERE IsDeleted=0
	/*
    UPDATE Doctors
    SET Status = CASE 
        WHEN LicenseExpiryDate < CAST(GETUTCDATE() AS DATE) THEN 'Expired'
        ELSE Status
    END
    WHERE IsDeleted = 0;
    */
    SELECT 
        Id,
        FullName,
        Email,
        Specialization,
        LicenseNumber,
        LicenseExpiryDate,
        Status,
        CreatedDate,
		DeletedDate,
		CAST(0 AS BIT) AS IsDeleted,
        COUNT(*) OVER() AS TotalCount
    FROM Doctors
    WHERE IsDeleted = 0 
        AND Status = 'Expired'
    ORDER BY LicenseExpiryDate ASC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO