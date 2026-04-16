import React, { useState, useEffect, useRef } from 'react';
import { ChevronLeft, Calendar } from 'lucide-react';

interface CustomDatePickerProps {
  value: string;
  onChange: (date: string) => void;
  disabled?: boolean;
  mode?: 'single' | 'multiple';
  placeholder?: string;
  minWidth?: string;
  hideFooter?: boolean;
}

const CustomDatePicker = ({ value, onChange, disabled, mode = 'multiple', placeholder, minWidth, hideFooter = false }: CustomDatePickerProps) => {
  const [isOpen, setIsOpen] = useState(false);
  const selectedDates = value ? value.split(',').map((d: string) => d.trim()).filter(Boolean) : [];
  
  const [currentDate, setCurrentDate] = useState(() => {
    if (selectedDates.length > 0) {
      const first = selectedDates[0];
      return new Date(first);
    }
    return new Date();
  });
  
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setIsOpen(false);
      }
    };
    if (isOpen) document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [isOpen]);

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();

  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const firstDay = new Date(year, month, 1).getDay();
  const startOffset = firstDay === 0 ? 6 : firstDay - 1;

  const days = [];
  for (let i = 0; i < startOffset; i++) days.push(null);
  for (let i = 1; i <= daysInMonth; i++) days.push(i);

  const dateToStr = (y: number, m: number, d: number) => 
    `${y}-${String(m+1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;

  const handleSelect = (day: number) => {
    if (!day) return;
    const dateStr = dateToStr(year, month, day);
    
    if (mode === 'single') {
      onChange(dateStr);
      setIsOpen(false);
    } else {
      if (selectedDates.includes(dateStr)) {
        onChange(selectedDates.filter((d: string) => d !== dateStr).join(', '));
      } else {
        onChange([...selectedDates, dateStr].sort().join(', '));
      }
    }
  };

  const nextMonth = () => setCurrentDate(new Date(year, month + 1, 1));
  const prevMonth = () => setCurrentDate(new Date(year, month - 1, 1));
  const today = new Date();

  let displayValue = placeholder || 'Chọn ngày...';
  if (selectedDates.length === 1) {
    const d = new Date(selectedDates[0]);
    displayValue = `${String(d.getDate()).padStart(2, '0')}/${String(d.getMonth() + 1).padStart(2, '0')}/${d.getFullYear()}`;
  } else if (selectedDates.length > 1) {
    displayValue = `${selectedDates.length} ngày đã chọn`;
  }

  return (
    <div 
      className="relative" 
      ref={containerRef}
      style={{ minWidth }}
    >
      <div 
        onClick={() => setIsOpen(!isOpen)}
        className={`w-full text-sm font-bold px-3 py-2 rounded-xl border ${isOpen ? 'border-primary ring-2 ring-primary/20 bg-red-50/10' : 'border-slate-200'} bg-white flex justify-between items-center transition-colors ${disabled ? 'opacity-90 bg-zinc-50 cursor-not-allowed' : 'cursor-pointer hover:bg-slate-50 shadow-sm'}`}
      >
        <span className={`truncate ${!value && !placeholder ? 'text-slate-400' : ''}`}>{displayValue}</span>
        <Calendar size={16} className="text-slate-400 shrink-0 ml-2" />
      </div>

      {isOpen && (
        <div className="absolute top-full mt-2 left-0 p-4 bg-white rounded-3xl shadow-xl shadow-slate-200/50 border border-slate-200 z-[100] w-[320px] animate-in slide-in-from-top-2 fade-in duration-200">
          <div className="flex justify-between items-center mb-4">
              <button type="button" onClick={prevMonth} className="p-1.5 hover:bg-slate-100 rounded-lg text-slate-600 transition-colors"><ChevronLeft size={18} /></button>
              <div className="flex gap-1 items-center">
                <select 
                  className="font-bold text-navy bg-transparent outline-none cursor-pointer hover:bg-slate-50 px-1 py-0.5 rounded appearance-none"
                  value={month}
                  onChange={(e) => setCurrentDate(new Date(year, parseInt(e.target.value), 1))}
                >
                  {Array.from({length: 12}).map((_, i) => (
                    <option key={i} value={i}>Tháng {i + 1}</option>
                  ))}
                </select>
                <select 
                  className="font-bold text-navy bg-transparent outline-none cursor-pointer hover:bg-slate-50 px-1 py-0.5 rounded appearance-none"
                  value={year}
                  onChange={(e) => setCurrentDate(new Date(parseInt(e.target.value), month, 1))}
                >
                  {Array.from({length: 120}).map((_, i) => {
                    const y = new Date().getFullYear() - 80 + i;
                    return <option key={y} value={y}>{y}</option>
                  })}
                </select>
              </div>
              <button type="button" onClick={nextMonth} className="p-1.5 hover:bg-slate-100 rounded-lg text-slate-600 transition-colors"><ChevronLeft size={18} className="rotate-180" /></button>
            </div>
            <div className="grid grid-cols-7 gap-1 text-center mb-2">
              {['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'].map(d => (
                <div key={d} className="text-[11px] font-black text-slate-400 select-none uppercase tracking-wider">{d}</div>
              ))}
            </div>
            <div className="grid grid-cols-7 gap-1">
              {days.map((d, i) => {
                if (!d) return <div key={i} className="h-8 select-none" />;
                const dateStr = dateToStr(year, month, d);
                const isSelected = selectedDates.includes(dateStr);
                const isToday = today.getFullYear() === year && today.getMonth() === month && today.getDate() === d;
                
                return (
                  <button
                    type="button"
                    key={i}
                    onClick={() => { if (!disabled) handleSelect(d); }}
                    className={`h-8 rounded-lg text-sm font-bold flex items-center justify-center transition-all focus:outline-none
                      ${isSelected ? 'bg-primary text-white shadow-md shadow-primary/20 scale-105' : 
                        isToday ? `bg-red-50 text-primary border border-red-200 ${!disabled ? 'hover:bg-red-100' : ''}` : `text-slate-700 ${!disabled ? 'hover:bg-slate-100' : ''}`}
                      ${disabled ? 'cursor-default' : ''}`}
                  >
                    {d}
                  </button>
                );
              })}
            </div>
            {!hideFooter && (
              <div className="mt-4 pt-3 border-t border-slate-100 flex gap-2">
                <button 
                  type="button"
                  onClick={() => {
                    if (!disabled) {
                      if (mode === 'single') {
                        onChange('');
                        setIsOpen(false);
                      } else {
                        onChange('');
                      }
                    }
                  }}
                  className={`flex-1 text-xs font-bold py-2 rounded-lg transition-colors ${disabled ? 'text-slate-400 cursor-default' : 'text-slate-500 hover:bg-slate-100'}`}
                >
                  Xóa
                </button>
                <button 
                  type="button" 
                  onClick={() => { 
                    setCurrentDate(today); 
                    if (!disabled) {
                      const dateStr = dateToStr(today.getFullYear(), today.getMonth(), today.getDate());
                      if (mode === 'single') {
                        onChange(dateStr);
                        setIsOpen(false);
                      } else if (!selectedDates.includes(dateStr)) {
                        onChange([...selectedDates, dateStr].sort().join(', '));
                      }
                    }
                  }}
                  className={`flex-1 text-xs font-bold py-2 rounded-lg transition-colors ${disabled ? 'text-slate-400 cursor-default' : 'text-primary hover:bg-red-50'}`}
                >
                  Hôm nay
                </button>
              </div>
            )}
        </div>
      )}
    </div>
  );
};

export default CustomDatePicker;
