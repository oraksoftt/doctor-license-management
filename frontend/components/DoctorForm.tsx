'use client';

import { useState, useEffect } from 'react';
import { Doctor, CreateDoctorDto, UpdateDoctorDto } from '@/types/doctor';
import { doctorApi } from '@/services/api';
import toast from 'react-hot-toast';

interface DoctorFormProps {
  doctor?: Doctor;
  onClose: () => void;
  onSubmit: () => void;
}

export default function DoctorForm({ doctor, onClose, onSubmit }: DoctorFormProps) {
  const [formData, setFormData] = useState<CreateDoctorDto>({
    fullName: '',
    email: '',
    specialization: '',
    licenseNumber: '',
    licenseExpiryDate: '',
  });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (doctor) {
      setFormData({
        fullName: doctor.fullName,
        email: doctor.email,
        specialization: doctor.specialization,
        licenseNumber: doctor.licenseNumber,
        licenseExpiryDate: doctor.licenseExpiryDate.split('T')[0],
      });
    }
  }, [doctor]);

  const validateForm = () => {
    const newErrors: Record<string, string> = {};
    
    if (!formData.fullName.trim()) {
      newErrors.fullName = 'Full name is required';
    }
    
    if (!formData.email.trim()) {
      newErrors.email = 'Email is required';
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)) {
      newErrors.email = 'Invalid email format';
    }
    
    if (!formData.specialization.trim()) {
      newErrors.specialization = 'Specialization is required';
    }
    
    if (!formData.licenseNumber.trim()) {
      newErrors.licenseNumber = 'License number is required';
    }
    
    if (!formData.licenseExpiryDate) {
      newErrors.licenseExpiryDate = 'License expiry date is required';
    }
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm()) {
      return;
    }
    
    setSubmitting(true);
    
    try {
      if (doctor) {
        const updateData: UpdateDoctorDto = {
          ...formData,
          id: doctor.id,
        };
        await doctorApi.updateDoctor(doctor.id, updateData);
        toast.success('Doctor updated successfully');
      } else {
        await doctorApi.createDoctor(formData);
        toast.success('Doctor created successfully');
      }
      onSubmit();
    } catch (error: any) {
      console.error('Error saving doctor:', error);
      if (error.response?.status === 409) {
        toast.error('License number already exists');
      } else if (error.response?.status === 400) {
        const validationErrors = error.response.data;
        if (Array.isArray(validationErrors)) {
          const newErrors: Record<string, string> = {};
          validationErrors.forEach((err: any) => {
            newErrors[err.propertyName?.replace('Data.', '').toLowerCase()] = err.errorMessage;
          });
          setErrors(newErrors);
        }
        toast.error('Please check the form for errors');
      } else {
        toast.error('Failed to save doctor');
      }
    } finally {
      setSubmitting(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
    if (errors[name]) {
      setErrors(prev => ({ ...prev, [name]: '' }));
    }
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg shadow-xl max-w-md w-full max-h-[90vh] overflow-y-auto">
        <div className="flex justify-between items-center p-6 border-b">
          <h2 className="text-xl font-semibold text-gray-900">
            {doctor ? 'Edit Doctor' : 'Add New Doctor'}
          </h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600"
          >
            <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Full Name *
            </label>
            <input
              type="text"
              name="fullName"
              value={formData.fullName}
              onChange={handleChange}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                errors.fullName ? 'border-red-500' : 'border-gray-300'
              }`}
            />
            {errors.fullName && (
              <p className="mt-1 text-sm text-red-600">{errors.fullName}</p>
            )}
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Email *
            </label>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                errors.email ? 'border-red-500' : 'border-gray-300'
              }`}
            />
            {errors.email && (
              <p className="mt-1 text-sm text-red-600">{errors.email}</p>
            )}
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Specialization *
            </label>
            <input
              type="text"
              name="specialization"
              value={formData.specialization}
              onChange={handleChange}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                errors.specialization ? 'border-red-500' : 'border-gray-300'
              }`}
            />
            {errors.specialization && (
              <p className="mt-1 text-sm text-red-600">{errors.specialization}</p>
            )}
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              License Number *
            </label>
            <input
              type="text"
              name="licenseNumber"
              value={formData.licenseNumber}
              onChange={handleChange}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                errors.licenseNumber ? 'border-red-500' : 'border-gray-300'
              }`}
            />
            {errors.licenseNumber && (
              <p className="mt-1 text-sm text-red-600">{errors.licenseNumber}</p>
            )}
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              License Expiry Date *
            </label>
            <input
              type="date"
              name="licenseExpiryDate"
              value={formData.licenseExpiryDate}
              onChange={handleChange}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                errors.licenseExpiryDate ? 'border-red-500' : 'border-gray-300'
              }`}
            />
            {errors.licenseExpiryDate && (
              <p className="mt-1 text-sm text-red-600">{errors.licenseExpiryDate}</p>
            )}
          </div>
          
          <div className="flex justify-end gap-3 pt-4">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 text-gray-700 bg-gray-100 rounded-lg hover:bg-gray-200 transition-colors"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={submitting}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50"
            >
              {submitting ? 'Saving...' : doctor ? 'Update' : 'Create'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}