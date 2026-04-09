
export interface Doctor {
  id: number;
  fullName: string;
  email: string;
  specialization: string;
  licenseNumber: string;
  licenseExpiryDate: string;
  status: 'Active' | 'Expired' | 'Suspended' | 'Pending';
  createdDate: string;
}

export interface DoctorListResponse {
  doctors: Doctor[];
  totalCount: number;
  pageNumber: number;
  pageSize: number;
  totalPages: number;
}

export interface CreateDoctorDto {
  fullName: string;
  email: string;
  specialization: string;
  licenseNumber: string;
  licenseExpiryDate: string;
}

export interface UpdateDoctorDto extends CreateDoctorDto {
  id: number;
}