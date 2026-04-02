using DoctorLicense.Domain.Entities;
namespace DoctorLicense.Domain.Interfaces;


public interface IDoctorRepository
{
    
    Task<Doctor?> GetByIdAsync(int id);
    Task<IEnumerable<Doctor>> GetAllAsync();
    Task<Doctor> CreateAsync(Doctor doctor);
    Task UpdateAsync(Doctor doctor);
    Task SoftDeleteAsync(int id);
    Task<bool> IsLicenseNumberUniqueAsync(string licenseNumber, int? excludeId = null);
    Task<(IEnumerable<Doctor> Doctors, int TotalCount)> GetDoctorsWithFiltersAsync(string? searchTerm, string? statusFilter, int pageNumber, int pageSize);
    Task<(IEnumerable<Doctor> Doctors, int TotalCount)> GetExpiredDoctorsAsync(int pageNumber, int pageSize);
    
    //Task<DoctorDto> GetByIdAsync(int id);
    //Task<IEnumerable<DoctorDto>> GetAllAsync();
    //Task<DoctorDto> CreateAsync(CreateDoctorDto dto);
    //Task<DoctorDto> UpdateAsync(UpdateDoctorDto dto);
    //Task SoftDeleteAsync(int id);
    //Task<bool> IsLicenseNumberUniqueAsync(string licenseNumber, int? excludeId = null);

    //Task UpdateStatusAsync(int id, string status);
    //Task<DoctorListResponseDto> GetDoctorsWithFiltersAsync(string? searchTerm, string? statusFilter, int pageNumber, int pageSize);
    //Task<DoctorListResponseDto> GetExpiredDoctorsAsync(int pageNumber, int pageSize);
}