'use client';

import { useState } from 'react';

interface SearchFilterProps {
  onSearch: (search: string) => void;
  onStatusFilter: (status: string) => void;
  onToggleExpiredOnly: () => void;
  showExpiredOnly: boolean;
}

export default function SearchFilter({ onSearch, onStatusFilter, onToggleExpiredOnly, showExpiredOnly }: SearchFilterProps) {
  const [searchInput, setSearchInput] = useState('');

  const handleSearch = () => {
    onSearch(searchInput);
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      handleSearch();
    }
  };

  return (
    <div className="flex gap-4 flex-wrap">
      <div className="flex gap-2">
        <input
          type="text"
          value={searchInput}
          onChange={(e) => setSearchInput(e.target.value)}
          onKeyPress={handleKeyPress}
          placeholder="Search by name or license..."
          className="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 w-64"
        />
        <button
          onClick={handleSearch}
          className="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors"
        >
          Search
        </button>
      </div>
      
      <select
        onChange={(e) => onStatusFilter(e.target.value)}
        className="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
      >
        <option value="">All Status</option>
        <option value="Active">Active</option>
        <option value="Expired">Expired</option>
        <option value="Suspended">Suspended</option>
      </select>
      
      <button
        onClick={onToggleExpiredOnly}
        className={`px-4 py-2 rounded-lg transition-colors ${
          showExpiredOnly
            ? 'bg-red-600 text-white hover:bg-red-700'
            : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
        }`}
      >
        Show Expired Only
      </button>
    </div>
  );
}