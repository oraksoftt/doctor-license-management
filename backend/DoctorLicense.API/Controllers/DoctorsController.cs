
using DoctorLicense.Application.DTOs;
using DoctorLicense.Application.Services;
using DoctorLicense.Infrastructure.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace DoctorLicense.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class DoctorsController : ControllerBase
{
    private readonly IDoctorService _doctorService;    
    private readonly ILogger<DoctorsController> _logger;

    public DoctorsController(IDoctorService doctorService, ILogger<DoctorsController> logger)
    {
        _doctorService = doctorService;
        _logger = logger;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        try
        {
            var doctors = await _doctorService.GetAllAsync();
            return Ok(doctors);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting all doctors");
            return StatusCode(500, "An error occurred while retrieving doctors");
        }
    }

    [HttpGet("list")]
    public async Task<IActionResult> GetList(
        [FromQuery] string? search,
        [FromQuery] string? status,
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        try
        {
            var result = await _doctorService.GetDoctorsWithFiltersAsync(search, status, pageNumber, pageSize);
            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting filtered doctors list");
            return StatusCode(500, "An error occurred while retrieving doctors");
        }
    }

    [HttpGet("expired")]
    public async Task<IActionResult> GetExpired(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        try
        {
            var result = await _doctorService.GetExpiredDoctorsAsync(pageNumber, pageSize);
            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting expired doctors");
            return StatusCode(500, "An error occurred while retrieving expired doctors");
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        try
        {
            var doctor = await _doctorService.GetByIdAsync(id);
            return Ok(doctor);
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting doctor by ID {Id}", id);
            return StatusCode(500, "An error occurred while retrieving the doctor");
        }
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateDoctorDto createDto)
    {
        try
        {
            var doctor = await _doctorService.CreateAsync(createDto);
            return CreatedAtAction(nameof(GetById), new { id = doctor.Id }, doctor);
        }
        catch (FluentValidation.ValidationException ex)
        {
            return BadRequest(ex.Errors);
        }
        catch (InvalidOperationException ex)
        {
            return Conflict(ex.Message);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating doctor");
            return StatusCode(500, "An error occurred while creating the doctor");
        }
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateDoctorDto updateDto)
    {
        try
        {
            if (id != updateDto.Id)
                return BadRequest("ID mismatch");

            var doctor = await _doctorService.UpdateAsync(updateDto);
            return Ok(doctor);
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (FluentValidation.ValidationException ex)
        {
            return BadRequest(ex.Errors);
        }
        catch (InvalidOperationException ex)
        {
            return Conflict(ex.Message);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating doctor {Id}", id);
            return StatusCode(500, "An error occurred while updating the doctor");
        }
    }

    [HttpPatch("{id}/status")]
    public async Task<IActionResult> UpdateStatus(int id, [FromBody] UpdateDoctorStatusDto statusDto)
    {
        try
        {
            if (id != statusDto.Id)
                return BadRequest("ID mismatch");

            await _doctorService.UpdateStatusAsync(id, statusDto.Status);
            return NoContent();
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating doctor status {Id}", id);
            return StatusCode(500, "An error occurred while updating doctor status");
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        try
        {
            await _doctorService.DeleteAsync(id);
            return NoContent();
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting doctor {Id}", id);
            return StatusCode(500, "An error occurred while deleting the doctor");
        }
    }
}