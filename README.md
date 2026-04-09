# Doctor License Management System

A full-stack Doctor License Management module for a Medical SaaS platform, built using **.NET 8 Clean Architecture** and **Next.js 14**.

---

## 🚀 Features

### Backend
- Clean Architecture (Domain, Application, Infrastructure, API)  
- Full CRUD operations with soft delete  
- Automatic license expiry status updates  
- Duplicate license number prevention  
- Input validation using **FluentValidation**  
- Stored procedures for:  
  - Search  
  - Filtering  
  - Pagination  
  - Bonus: Get expired doctors  
- Centralized error handling and logging  

### Frontend
- **Next.js 14** (App Router)  
- **Tailwind CSS** responsive UI  
- Doctor table with:  
  - Search (name / license)  
  - Status filter  
  - Status badges with color indicators  
- Add/Edit forms with validation  
- Pagination support  
- Loading & empty states  
- Expiring soon highlight (within 30 days)  
- Modal-based forms for better UX  

---

## 🛠 Tech Stack

**Backend**  
- .NET 8  
- Entity Framework Core  
- SQL Server  
- FluentValidation  
- Swagger / OpenAPI  

**Frontend**  
- Next.js 14  
- TypeScript  
- Tailwind CSS  
- Axios  
- React Hot Toast  

---

## 📋 Prerequisites

Make sure you have:  
- .NET 8 SDK  
- Node.js 18+  
- SQL Server (LocalDB / Express / Full)  
- Git  

---

## ⚙️ Setup Instructions

### 1. Clone Repository
```bash
git clone https://github.com/oraksoftt/doctor-license-management.git
cd doctor-license-management
