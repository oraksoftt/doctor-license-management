
using DoctorLicense.Domain.Entities;
using DoctorLicense.Domain.Interfaces;
using DoctorLicense.Infrastructure.Data;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace DoctorLicense.Infrastructure.Repositories;

public class DoctorRepository : IDoctorRepository
{
    private readonly ApplicationDbContext _context;

    public DoctorRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Doctor?> GetByIdAsync(int id)
    {
        return await _context.Doctors
            .Where(d => d.Id == id && !d.IsDeleted)
            .FirstOrDefaultAsync();
    }

    public async Task<IEnumerable<Doctor>> GetAllAsync()
    {
        return await _context.Doctors
            .Where(d => !d.IsDeleted)
            .OrderByDescending(d => d.CreatedDate)
            .ToListAsync();
    }

    public async Task<Doctor> CreateAsync(Doctor doctor)
    {
        _context.Doctors.Add(doctor);
        await _context.SaveChangesAsync();
        return doctor;
    }

    public async Task UpdateAsync(Doctor doctor)
    {
        _context.Entry(doctor).State = EntityState.Modified;
        await _context.SaveChangesAsync();
    }

    public async Task SoftDeleteAsync(int id)
    {
        var doctor = await GetByIdAsync(id);
        if (doctor != null)
        {
            doctor.IsDeleted = true;
            doctor.DeletedDate = DateTime.UtcNow;
            await _context.SaveChangesAsync();
        }
    }

    public async Task<bool> IsLicenseNumberUniqueAsync(string licenseNumber, int? excludeId = null)
    {
        var query = _context.Doctors.Where(d => d.LicenseNumber == licenseNumber && !d.IsDeleted);

        if (excludeId.HasValue)
            query = query.Where(d => d.Id != excludeId.Value);

        return !await query.AnyAsync();
    }

    public async Task<(IEnumerable<Doctor> Doctors, int TotalCount)> GetDoctorsWithFiltersAsync(string? searchTerm, string? statusFilter, int pageNumber, int pageSize)
    {
        try
        {
            var searchParam = new SqlParameter("@SearchTerm", searchTerm ?? (object)DBNull.Value);
            var statusParam = new SqlParameter("@StatusFilter", statusFilter ?? (object)DBNull.Value);
            var pageNumberParam = new SqlParameter("@PageNumber", pageNumber);
            var pageSizeParam = new SqlParameter("@PageSize", pageSize);

            var result = await _context.Doctors.FromSqlRaw("EXEC sp_GetDoctorsList @SearchTerm, @StatusFilter, @PageNumber, @PageSize", searchParam, statusParam, pageNumberParam, pageSizeParam).ToListAsync();

            var totalCount = result.FirstOrDefault()?.GetType().GetProperty("TotalCount")?.GetValue(result.FirstOrDefault()) as int? ?? 0;

            return (result, totalCount);
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    public async Task<(IEnumerable<Doctor> Doctors, int TotalCount)> GetExpiredDoctorsAsync(int pageNumber, int pageSize)
    {
        var pageNumberParam = new SqlParameter("@PageNumber", pageNumber);
        var pageSizeParam = new SqlParameter("@PageSize", pageSize);

        var result = await _context.Doctors.FromSqlRaw("EXEC sp_GetExpiredDoctors @PageNumber, @PageSize",pageNumberParam, pageSizeParam).ToListAsync();

        var totalCount = result.FirstOrDefault()?.GetType().GetProperty("TotalCount")?.GetValue(result.FirstOrDefault()) as int? ?? 0;

        return (result, totalCount);
    }
}