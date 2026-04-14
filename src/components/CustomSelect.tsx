import React, { useState, useRef, useEffect } from 'react';
import { ChevronDown } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

interface Option {
  value: string | number;
  label: string;
}

interface CustomSelectProps {
  value: string | number;
  onChange: (value: string | number) => void;
  options: Option[];
  icon?: React.ReactNode;
  minWidth?: string;
  className?: string;
}

const CustomSelect: React.FC<CustomSelectProps> = ({ value, onChange, options, icon, minWidth = '130px', className = '' }) => {
  const [isOpen, setIsOpen] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, []);

  const selectedOption = options.find((opt) => opt.value == value);

  return (
    <div 
      ref={containerRef}
      className={`relative border border-slate-200 rounded-xl bg-white hover:bg-slate-50 transition-colors h-[38px] flex select-none cursor-pointer ${className}`}
      style={{ minWidth }}
      onClick={() => setIsOpen(!isOpen)}
    >
      {/* Target area */}
      <div className="flex items-center w-full px-3 gap-2">
        {icon && <span className="text-slate-500">{icon}</span>}
        <span className="flex-1 text-slate-700 font-medium text-sm truncate">
          {selectedOption ? selectedOption.label : 'Select...'}
        </span>
        <ChevronDown size={15} className={`text-slate-400 transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`} />
      </div>

      {/* Dropdown Menu */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 5 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: 5 }}
            transition={{ duration: 0.15 }}
            className="absolute top-[calc(100%+8px)] left-0 w-full min-w-max bg-white border border-slate-100 rounded-xl shadow-[0_10px_25px_-5px_rgba(0,0,0,0.1),0_0_10px_0_rgba(0,0,0,0.02)] z-[100] py-1 overflow-hidden"
          >
            <div className="max-h-[250px] overflow-y-auto custom-scrollbar">
              {options.map((opt) => (
                <div
                  key={opt.value}
                  onClick={(e) => {
                    e.stopPropagation();
                    onChange(opt.value);
                    setIsOpen(false);
                  }}
                  className={`px-4 py-2.5 text-sm transition-colors cursor-pointer flex items-center ${opt.value == value ? 'bg-primary/5 text-primary font-bold' : 'text-slate-700 hover:bg-slate-50 font-medium'}`}
                >
                  {opt.label}
                </div>
              ))}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default CustomSelect;
