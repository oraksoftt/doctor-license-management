
import axios from 'axios';
import { Doctor, DoctorListResponse, CreateDoctorDto, UpdateDoctorDto } from '@/types/doctor';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'https://localhost:7254/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const doctorApi = {
  // Get all doctors 
  getDoctorsList: async (
    search?: string,
    status?: string,
    pageNumber: number = 1,
    pageSize: number = 10
  ): Promise<DoctorListResponse> => {
    const params = new URLSearchParams();
    if (search) params.append('search', search);
    if (status) params.append('status', status);
    params.append('pageNumber', pageNumber.toString());
    params.append('pageSize', pageSize.toString());
    
    const response = await api.get(`/Doctors/list?${params.toString()}`);
    return response.data;
  },

  // Get expired doctors (bonus)
  getExpiredDoctors: async (pageNumber: number = 1, pageSize: number = 10): Promise<DoctorListResponse> => {
    const response = await api.get(`/Doctors/expired?pageNumber=${pageNumber}&pageSize=${pageSize}`);
    return response.data;
  },

  // Get doctor by ID
  getDoctorById: async (id: number): Promise<Doctor> => {
    const response = await api.get(`/Doctors/${id}`);
    return response.data;
  },

  // Create doctor
  createDoctor: async (data: CreateDoctorDto): Promise<Doctor> => {
    const response = await api.post('/Doctors', data);
    return response.data;
  },

  // Update doctor
  updateDoctor: async (id: number, data: UpdateDoctorDto): Promise<Doctor> => {
    const response = await api.put(`/Doctors/${id}`, data);
    return response.data;
  },

  // Update doctor status
  updateDoctorStatus: async (id: number, status: string): Promise<void> => {
    await api.patch(`/Doctors/${id}/status`, { id, status });
  },

  // Delete doctor (soft delete)
  deleteDoctor: async (id: number): Promise<void> => {
    await api.delete(`/Doctors/${id}`);
  },
};