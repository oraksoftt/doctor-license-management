
using DoctorLicense.Application.DTOs;

namespace DoctorLicense.Application.Services;

public interface IDoctorService
{
    /// <summary>
    /// Get doctor by ID
    /// </summary>
    Task<DoctorDto> GetByIdAsync(int id);
    Task<IEnumerable<DoctorDto>> GetAllAsync();
    Task<DoctorListResponseDto> GetDoctorsWithFiltersAsync(string? searchTerm,string? statusFilter,int pageNumber,int pageSize);
    Task<DoctorDto> CreateAsync(CreateDoctorDto createDto);
    Task<DoctorDto> UpdateAsync(UpdateDoctorDto updateDto);
    Task UpdateStatusAsync(int id, string status);
    Task DeleteAsync(int id);
    Task<DoctorListResponseDto> GetExpiredDoctorsAsync(int pageNumber, int pageSize);
}