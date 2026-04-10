# Doctor License Management System

A full-stack Doctor License Management module for a Medical SaaS platform, built using .NET 8 Clean Architecture and Next.js 14.

---

## 🚀 Features

**Backend**
- Clean Architecture (Domain, Application, Infrastructure, API)
- Full CRUD operations with soft delete
- Automatic license expiry status updates
- Duplicate license number prevention
- Input validation using FluentValidation
- Stored procedures for: Search, Filtering, Pagination, Get expired doctors
- Centralized error handling and logging

**Frontend**
- Next.js 14 (App Router)
- Tailwind CSS responsive UI
- Doctor table with: Search (name/license), Status filter, Status badges with color indicators
- Add/Edit forms with validation
- Pagination support
- Loading & empty states
- Expiring soon highlight (within 30 days)
- Modal-based forms for better UX

---

## 🛠 Tech Stack

**Backend:** .NET 8, Entity Framework Core, SQL Server, FluentValidation, Swagger/OpenAPI

**Frontend:** Next.js 14, TypeScript, Tailwind CSS, Axios, React Hot Toast

---

## 📋 Prerequisites

- .NET 8 SDK
- Node.js 18+
- SQL Server (LocalDB/Express/Full)
- Git

---

## ⚙️ Setup Instructions

**1. Clone Repository**

git clone <your-repo-url>
cd doctor-license-management

**2. Database Setup**

- Open SQL Server Management Studio (SSMS)
- Execute the script: database/full_database_script.sql

**3. Backend Setup**

cd backend/DoctorLicense.API

Edit appsettings.json:
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=DoctorLicenseDB;Trusted_Connection=True;"
  }
}

Run commands:
dotnet restore
dotnet build
dotnet run

Verify at: https://localhost:7192/swagger

**4. Frontend Setup**

cd frontend/doctor-license-ui

npm install

Create .env.local file:
NEXT_PUBLIC_API_URL=https://localhost:7192/api

npm run dev

Open at: http://localhost:3000

---

## 🧪 Testing

**Backend (Swagger)**
- POST /api/doctors → Create doctor
- GET /api/doctors/list → Get all doctors
- GET /api/doctors/list?search=john → Search
- GET /api/doctors/list?status=Active → Filter
- GET /api/doctors/expired → Expired doctors
- PUT /api/doctors/{id} → Update
- DELETE /api/doctors/{id} → Soft delete

**Frontend**
- Add Doctor
- Search (name/license)
- Filter by status
- View expired doctors
- Edit doctor
- Delete doctor

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/doctors | Get all doctors |
| GET | /api/doctors/list | Filtered list (SP) |
| GET | /api/doctors/expired | Expired doctors |
| GET | /api/doctors/{id} | Get by ID |
| POST | /api/doctors | Create doctor |
| PUT | /api/doctors/{id} | Update doctor |
| PATCH | /api/doctors/{id}/status | Update status |
| DELETE | /api/doctors/{id} | Soft delete |

---

## 📌 Business Rules

- Auto Expiry: License status becomes Expired if expiry date is past
- Unique License Number: Enforced at DB + backend validation
- Validation: All required fields validated using FluentValidation
- Soft Delete: Records are not permanently deleted

---

## 📁 Project Structure

doctor-license-management/
│
├── backend/
│   ├── DoctorLicense.Domain/         # Entities, Interfaces
│   ├── DoctorLicense.Application/    # DTOs, Services, Validators
│   ├── DoctorLicense.Infrastructure/ # Repositories, DB logic
│   └── DoctorLicense.API/            # Controllers, Program.cs
│
├── frontend/
│   └── doctor-license-ui/
│       ├── app/                      # Pages
│       ├── components/               # UI Components
│       ├── services/                 # API calls
│       └── types/                    # TypeScript types
│
└── database/
    └── scripts/                      # SQL scripts

---

## ✅ Notes

- Designed following Clean Architecture principles
- Focused on real-world SaaS use cases
- Optimized using stored procedures for performance
