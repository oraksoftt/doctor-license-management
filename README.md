# Doctor License Management System

A comprehensive doctor license management module for a Medical SaaS platform, built with .NET 8 Clean Architecture and Next.js.

## Features

### Backend
- Clean Architecture with Domain, Application, Infrastructure, and API layers
- Full CRUD operations with soft delete
- Automatic license expiry status updates
- Duplicate license number prevention
- Input validation using FluentValidation
- Stored procedures for optimized listing with search/filter/pagination
- Bonus stored procedure for expired doctors
- Error handling and logging

### Frontend
- Modern Next.js 14 with App Router
- Responsive Tailwind CSS design
- Doctor table with search (name/license) and status filter
- Status badges with color coding
- Add/Edit forms with validation
- Loading and empty states
- Pagination
- Expiring soon highlight (30 days warning)
- Modal forms for better UX

## Tech Stack

### Backend
- .NET 8
- Entity Framework Core
- SQL Server
- FluentValidation
- Swagger/OpenAPI

### Frontend
- Next.js 14
- TypeScript
- Tailwind CSS
- Axios
- React Hot Toast

## Prerequisites

- .NET 8 SDK
- Node.js 18+
- SQL Server (LocalDB, Express, or full version)
- Git

## Setup Instructions

### Database Setup

1. **Create the database and run scripts:**
   ```bash
   # Connect to SQL Server and execute scripts in order:
   # 1. database/scripts/01_create_database.sql
   # 2. database/scripts/02_create_doctors_table.sql
   # 3. database/scripts/03_stored_procedures.sql
