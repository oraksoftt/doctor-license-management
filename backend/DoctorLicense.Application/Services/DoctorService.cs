

using DoctorLicense.Application.DTOs;
using DoctorLicense.Domain.Entities;
using DoctorLicense.Domain.Interfaces;
using FluentValidation;

using ValidationException = FluentValidation.ValidationException;
namespace DoctorLicense.Application.Services;

public class DoctorService : IDoctorService
{
    private readonly IDoctorRepository _doctorRepository;
    private readonly IValidator<CreateDoctorDto> _createValidator;
    private readonly IValidator<UpdateDoctorDto> _updateValidator;

    public DoctorService(IDoctorRepository doctorRepository,IValidator<CreateDoctorDto> createValidator,IValidator<UpdateDoctorDto> updateValidator)
    {
        _doctorRepository = doctorRepository;
        _createValidator = createValidator;
        _updateValidator = updateValidator;
    }

    public async Task<DoctorDto> GetByIdAsync(int id)
    {
        var doctor = await _doctorRepository.GetByIdAsync(id);
        if (doctor == null)
            throw new KeyNotFoundException($"Doctor with ID {id} not found");

        return MapToDto(doctor);
    }

    public async Task<IEnumerable<DoctorDto>> GetAllAsync()
    {
        var doctors = await _doctorRepository.GetAllAsync();
        return doctors.Select(MapToDto);
    }

    public async Task<DoctorListResponseDto> GetDoctorsWithFiltersAsync(
        string? searchTerm, string? statusFilter, int pageNumber, int pageSize)
    {
        var (doctors, totalCount) = await _doctorRepository.GetDoctorsWithFiltersAsync(searchTerm, statusFilter, pageNumber, pageSize);

        return new DoctorListResponseDto
        {
            Doctors = doctors.Select(MapToDto),
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<DoctorDto> CreateAsync(CreateDoctorDto createDto)
    {
        var validationResult = await _createValidator.ValidateAsync(createDto);
        if (!validationResult.IsValid)
            throw new ValidationException(validationResult.Errors);

        var isUnique = await _doctorRepository.IsLicenseNumberUniqueAsync(createDto.LicenseNumber);
        if (!isUnique)
            throw new InvalidOperationException("License number already exists");

        var doctor = new Doctor
        {
            FullName = createDto.FullName,
            Email = createDto.Email,
            Specialization = createDto.Specialization,
            LicenseNumber = createDto.LicenseNumber,
            LicenseExpiryDate = createDto.LicenseExpiryDate,
            CreatedDate = DateTime.UtcNow,
            Status = createDto.LicenseExpiryDate < DateTime.UtcNow.Date ? "Expired" : "Active",
            IsDeleted = false
        };

        var created = await _doctorRepository.CreateAsync(doctor);
        return MapToDto(created);
    }

    public async Task<DoctorDto> UpdateAsync(UpdateDoctorDto updateDto)
    {
        var validationResult = await _updateValidator.ValidateAsync(updateDto);
        if (!validationResult.IsValid)
            throw new ValidationException(validationResult.Errors);

        var existing = await _doctorRepository.GetByIdAsync(updateDto.Id);
        if (existing == null)
            throw new KeyNotFoundException($"Doctor with ID {updateDto.Id} not found");

        var isUnique = await _doctorRepository.IsLicenseNumberUniqueAsync(updateDto.LicenseNumber, updateDto.Id);
        if (!isUnique)
            throw new InvalidOperationException("License number already exists");

        existing.FullName = updateDto.FullName;
        existing.Email = updateDto.Email;
        existing.Specialization = updateDto.Specialization;
        existing.LicenseNumber = updateDto.LicenseNumber;
        existing.LicenseExpiryDate = updateDto.LicenseExpiryDate;
        existing.Status = updateDto.LicenseExpiryDate < DateTime.UtcNow.Date ? "Expired" : "Active";

        await _doctorRepository.UpdateAsync(existing);
        return MapToDto(existing);
    }

    public async Task UpdateStatusAsync(int id, string status)
    {
        var doctor = await _doctorRepository.GetByIdAsync(id);
        if (doctor == null)
            throw new KeyNotFoundException($"Doctor with ID {id} not found");

        doctor.Status = status;
        await _doctorRepository.UpdateAsync(doctor);
    }

    public async Task DeleteAsync(int id)
    {
        await _doctorRepository.SoftDeleteAsync(id);
    }

    public async Task<DoctorListResponseDto> GetExpiredDoctorsAsync(int pageNumber, int pageSize)
    {
        var (doctors, totalCount) = await _doctorRepository.GetExpiredDoctorsAsync(pageNumber, pageSize);

        return new DoctorListResponseDto
        {
            Doctors = doctors.Select(MapToDto),
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    private static DoctorDto MapToDto(Doctor doctor)
    {
        return new DoctorDto
        {
            Id = doctor.Id,
            FullName = doctor.FullName,
            Email = doctor.Email,
            Specialization = doctor.Specialization,
            LicenseNumber = doctor.LicenseNumber,
            LicenseExpiryDate = doctor.LicenseExpiryDate,
            Status = doctor.Status,
            CreatedDate = doctor.CreatedDate
        };
    }
}