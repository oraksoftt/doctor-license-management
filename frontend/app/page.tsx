'use client';

import { useState, useEffect } from 'react';
import { doctorApi } from '@/services/api';
import { Doctor, DoctorListResponse } from '@/types/doctor';
import DoctorTable from '@/components/DoctorTable';
import DoctorForm from '@/components/DoctorForm';
import SearchFilter from '@/components/SearchFilter';
import Pagination from '@/components/Pagination';
import toast from 'react-hot-toast';

export default function Home() {
  const [doctors, setDoctors] = useState<Doctor[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalCount, setTotalCount] = useState(0);
  const [showForm, setShowForm] = useState(false);
  const [editingDoctor, setEditingDoctor] = useState<Doctor | undefined>();
  const [showExpiredOnly, setShowExpiredOnly] = useState(false);

  const pageSize = 10;

  const fetchDoctors = async () => {
    setLoading(true);
    try {
      let response: DoctorListResponse;
      
      if (showExpiredOnly) {
        response = await doctorApi.getExpiredDoctors(currentPage, pageSize);
      } else {
        response = await doctorApi.getDoctorsList(
          searchTerm,
          statusFilter,
          currentPage,
          pageSize
        );
      }
      
      setDoctors(response.doctors);
      setTotalPages(response.totalPages);
      setTotalCount(response.totalCount);
    } catch (error) {
      console.error('Error fetching doctors:', error);
      toast.error('Failed to load doctors');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchDoctors();
  }, [searchTerm, statusFilter, currentPage, showExpiredOnly]);

  const handleAddDoctor = () => {
    setEditingDoctor(undefined);
    setShowForm(true);
  };

  const handleEditDoctor = (doctor: Doctor) => {
    setEditingDoctor(doctor);
    setShowForm(true);
  };

  const handleDeleteDoctor = async (id: number) => {
    if (confirm('Are you sure you want to delete this doctor?')) {
      try {
        await doctorApi.deleteDoctor(id);
        toast.success('Doctor deleted successfully');
        fetchDoctors();
      } catch (error) {
        console.error('Error deleting doctor:', error);
        toast.error('Failed to delete doctor');
      }
    }
  };

  const handleFormSubmit = async () => {
    setShowForm(false);
    fetchDoctors();
  };

  const handleSearch = (search: string) => {
    setSearchTerm(search);
    setCurrentPage(1);
  };

  const handleStatusFilter = (status: string) => {
    setStatusFilter(status);
    setCurrentPage(1);
  };

  const handleToggleExpiredOnly = () => {
    setShowExpiredOnly(!showExpiredOnly);
    setCurrentPage(1);
    setSearchTerm('');
    setStatusFilter('');
  };

  return (
    <main className="min-h-screen bg-gray-50">
      <div className="container mx-auto px-4 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Doctor License Management</h1>
          <p className="text-gray-600 mt-2">Manage and track doctor licenses efficiently</p>
        </div>

        <div className="bg-white rounded-lg shadow-md p-6">
          <div className="flex justify-between items-center mb-6">
            <SearchFilter
              onSearch={handleSearch}
              onStatusFilter={handleStatusFilter}
              onToggleExpiredOnly={handleToggleExpiredOnly}
              showExpiredOnly={showExpiredOnly}
            />
            <button
              onClick={handleAddDoctor}
              className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors flex items-center gap-2"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
              </svg>
              Add Doctor
            </button>
          </div>

          {loading ? (
            <div className="flex justify-center items-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
            </div>
          ) : doctors.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-gray-500 text-lg">No doctors found</p>
              <p className="text-gray-400 mt-2">Try adjusting your search or filter criteria</p>
            </div>
          ) : (
            <>
              <DoctorTable
                doctors={doctors}
                onEdit={handleEditDoctor}
                onDelete={handleDeleteDoctor}
              />
              <Pagination
                currentPage={currentPage}
                totalPages={totalPages}
                onPageChange={setCurrentPage}
                totalCount={totalCount}
                pageSize={pageSize}
              />
            </>
          )}
        </div>
      </div>

      {showForm && (
        <DoctorForm
          doctor={editingDoctor}
          onClose={() => setShowForm(false)}
          onSubmit={handleFormSubmit}
        />
      )}
    </main>
  );
}