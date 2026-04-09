'use client';

import { Doctor } from '@/types/doctor';

interface DoctorTableProps {
  doctors: Doctor[];
  onEdit: (doctor: Doctor) => void;
  onDelete: (id: number) => void;
}

const getStatusColor = (status: string) => {
  switch (status) {
    case 'Active':
      return 'bg-green-100 text-green-800';
    case 'Expired':
      return 'bg-red-100 text-red-800';
    case 'Suspended':
      return 'bg-yellow-100 text-yellow-800';
    case 'Pending':
    return 'bg-red'
    default:
      return 'bg-gray-100 text-gray-800';
  }
};

const isExpiringSoon = (expiryDate: string) => {
  const today = new Date();
  const expiry = new Date(expiryDate);
  const daysUntilExpiry = Math.ceil((expiry.getTime() - today.getTime()) / (1000 * 3600 * 24));
  // console.log('showme ',daysUntilExpiry)
  
  // return daysUntilExpiry <= 50 && daysUntilExpiry > 0;
  return daysUntilExpiry ;
};

export default function DoctorTable({ doctors, onEdit, onDelete }: DoctorTableProps) {
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  };

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full divide-y divide-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Full Name
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Email
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Specialization
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              License Number
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Expiry Date
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Status
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {doctors.map((doctor) => (
            <tr 
              key={doctor.id} 
              className={`hover:bg-gray-50 transition-colors ${
                isExpiringSoon(doctor.licenseExpiryDate) && doctor.status === 'Active' 
                  ? 'bg-yellow-50' 
                  : ''
              }`}
            >
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="text-sm font-medium text-gray-900">{doctor.fullName}</div>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="text-sm text-gray-500">{doctor.email}</div>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="text-sm text-gray-500">{doctor.specialization}</div>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="text-sm text-gray-500 font-mono">{doctor.licenseNumber}</div>
              </td>
              {/* <td className="px-6 py-4 whitespace-nowrap">
                <div className={`text-sm ${isExpiringSoon(doctor.licenseExpiryDate) && doctor.status === 'Active' ? 'text-yellow-600 font-semibold' : 'text-gray-500'}`}>
                  {formatDate(doctor.licenseExpiryDate)}
                  {isExpiringSoon(doctor.licenseExpiryDate) && doctor.status === 'Active' && (
                    <span className="ml-2 text-xs text-yellow-600">(Expiring soon)</span>
                  )}
                </div>
              </td> */}
              <td className={`text-sm ${doctor.status === 'NearExpiry' ? 'text-yellow-600 font-semibold' : 'text-gray-500'}`}>
              {formatDate(doctor.licenseExpiryDate)}
                {doctor.status === 'NearExpiry' && <span className="ml-2 text-xs text-yellow-600">(Expiring soon)</span>}
              </td>
              
              <td className="px-6 py-4 whitespace-nowrap">
                <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${getStatusColor(doctor.status)}`}>
                  {doctor.status}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <button
                  onClick={() => onEdit(doctor)}
                  className="text-blue-600 hover:text-blue-900 mr-3"
                >
                  Edit
                </button>
                <button
                  onClick={() => onDelete(doctor.id)}
                  className="text-red-600 hover:text-red-900"
                >
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}