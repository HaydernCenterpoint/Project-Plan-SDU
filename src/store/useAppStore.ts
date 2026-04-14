import { create } from 'zustand';
import axios from 'axios';
import { Plan, User, PlanStatus, Role, TableTemplate } from '../types';
export type Theme = 'light' | 'dark' | 'system';
export type { Plan, User, PlanStatus, Role };
import { generateMockPlans } from '../data/mockData';

const DEFAULT_TEMPLATES: TableTemplate[] = [
  {
    id: 'tpl-1',
    name: 'Mẫu Plan',
    columns: [
      { id: 'tt', name: 'TT', width: 'w-12', align: 'center' },
      { id: 'chu_de', name: 'Tên chủ đề/nội dung nghiên cứu', width: 'min-w-[200px]' },
      { id: 'dia_diem', name: 'Địa điểm', width: 'min-w-[120px]' },
      { id: 'ten_thiet_bi', name: 'Tên thiết bị', width: 'min-w-[150px]' },
      { id: 'nam_su_dung', name: 'Năm đưa vào sử dụng', width: 'w-[100px]', align: 'center' },
      { id: 'giang_vien', name: 'Giảng viên thực hiện', width: 'min-w-[150px]' },
      { id: 'thoi_gian', name: 'Thời gian thực hiện', width: 'min-w-[120px]' },
      { id: 'ket_qua', name: 'Dự kiến kết quả đạt được', width: 'min-w-[200px]' }
    ]
  },
  {
    id: 'tpl-2',
    name: 'Kết quả kiểm tra thiết bị',
    columns: [
      { id: 'tt', name: 'TT', width: 'w-10', align: 'center' },
      { id: 'content', name: 'Nội dung kiểm tra', width: 'min-w-[150px]' },
      { id: 'equipmentStatus', name: 'Tình trạng thiết bị', width: 'min-w-[150px]' },
      { id: 'checker', name: 'Người kiểm tra', width: 'w-[130px]' },
      { id: 'time', name: 'Thời gian', width: 'min-w-[150px]' },
      { id: 'notes', name: 'Ghi chú', width: 'w-24', align: 'center' },
    ]
  }
];


// Set default axios config
export const api = axios.create({
  baseURL: '/api',
  timeout: 15000,
});

interface AppState {
  currentUser: User | null;
  token: string | null;
  theme: Theme;
  plans: Plan[];
  tableTemplates: TableTemplate[];
  isLoading: boolean;
  error: string | null;
  setCurrentUser: (user: User | null) => void;
  setToken: (token: string | null) => void;
  setTheme: (theme: Theme) => void;
  setPlans: (plans: Plan[]) => void;
  addTableTemplate: (template: TableTemplate) => void;
  updateTableTemplate: (templateId: string, template: TableTemplate) => void;
  
  // Auth
  initAuth: () => Promise<void>;
  login: (credentials: any) => Promise<void>;
  register: (data: any) => Promise<void>;
  logout: () => void;

  // API Actions
  fetchPlans: () => Promise<void>;
  updatePlanStatus: (planId: string, status: PlanStatus, comment?: string) => Promise<void>;
  createPlan: (plan: Partial<Plan> & Record<string, any>) => Promise<void>;
  updatePlan: (planId: string, payload: Partial<Plan> & Record<string, any>) => Promise<void>;
  deletePlan: (planId: string) => Promise<void>;
  api: import('axios').AxiosInstance;
}

const mapUser = (u: any): User => {
  if (!u) return u;
  return {
    ...u,
    departmentId: u.department_id || u.departmentId,
    departmentName: u.department?.name || u.departmentName || '',
  };
};

const mapPlan = (p: any): Plan => {
  if (!p) return p;
  return {
    ...p,
    teacherId: p.user_id || p.teacherId,
    teacherName: p.teacher?.name || p.teacherName || 'Giảng viên',
    departmentId: p.department_id || p.departmentId,
    departmentName: p.department?.name || p.departmentName || '',
    items: (p.items || []).map((i: any) => {
      let parsed: any = {};
      if (typeof i.expected_result === 'string' && i.expected_result.startsWith('{')) {
        try { parsed = JSON.parse(i.expected_result); } catch (e) {}
      } else if (typeof i.expectedResult === 'string' && i.expectedResult.startsWith('{')) {
        try { parsed = JSON.parse(i.expectedResult); } catch (e) {}
      }
      return {
        ...i,
        ...parsed,
        plannedHours: i.planned_hours ?? i.plannedHours ?? parsed.plannedHours,
        expectedResult: i.expected_result ?? i.expectedResult,
      };
    }),
    weeks: (p.weeks || []).map((w: any) => {
      let parsed: any = {};
      if (typeof w.week_label === 'string' && w.week_label.startsWith('{')) {
        try { parsed = JSON.parse(w.week_label); } catch (e) {}
      } else if (typeof w.weekLabel === 'string' && w.weekLabel.startsWith('{')) {
        try { parsed = JSON.parse(w.weekLabel); } catch (e) {}
      }
      return {
        ...w,
        ...parsed,
        weekLabel: w.week_label ?? w.weekLabel,
        plannedHours: w.planned_hours ?? w.plannedHours ?? parsed.plannedHours,
        actualHours: w.actual_hours ?? w.actualHours ?? parsed.actualHours,
      };
    }),
    auditLog: p.audit_logs || p.auditLog || [],
    attachedFilePath: p.attached_file_path || p.attachedFilePath,
    attachedFileUrl: p.attached_file_path ? `/api/storage/${p.attached_file_path}` : p.attachedFileUrl,
    attachedFileName: p.attached_file_name || p.attachedFileName,
    attachments: (p.attachments || []).map((att: any) => ({
      ...att,
      url: `/api/storage/${att.path}`
    })),
    templateId: p.template_id || p.templateId || 'tpl-1',
    createdAt: p.created_at || p.createdAt || new Date().toISOString(),
    updatedAt: p.updated_at || p.updatedAt || new Date().toISOString(),
  };
};

export const useAppStore = create<AppState>((set, get) => ({
  currentUser: null,
  token: localStorage.getItem('token'),
  theme: (localStorage.getItem('theme') as Theme) || 'light',
  plans: [],
  tableTemplates: (() => {
    const saved = localStorage.getItem('tableTemplates');
    if (saved) {
      try {
        const parsed = JSON.parse(saved);
        // Force reset DEFAULT_TEMPLATES to ensure users get the blank state
        const updated = parsed.map((t: any) => {
           if (t.id === 'tpl-1' || t.id === 'tpl-2') {
               return DEFAULT_TEMPLATES.find(dt => dt.id === t.id) || t;
           }
           return t;
        });
        localStorage.setItem('tableTemplates', JSON.stringify(updated));
        return updated;
      } catch (e) {
        return DEFAULT_TEMPLATES;
      }
    }
    return DEFAULT_TEMPLATES;
  })(),
  isLoading: false,
  error: null,
  api,
  
  setCurrentUser: (user) => set({ currentUser: user }),
  setToken: (token) => {
    if (token) {
      localStorage.setItem('token', token);
      api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    } else {
      localStorage.removeItem('token');
      delete api.defaults.headers.common['Authorization'];
    }
    set({ token });
  },
  setTheme: (theme) => {
    localStorage.setItem('theme', theme);
    const root = window.document.documentElement;
    root.classList.remove('light', 'dark');
    if (theme === 'system') {
      root.classList.add(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    } else {
      root.classList.add(theme);
    }
    set({ theme });
  },
  setPlans: (plans) => set({ plans }),
  addTableTemplate: (template) => {
    const currentTemplates = get().tableTemplates;
    const newTemplates = [...currentTemplates, template];
    localStorage.setItem('tableTemplates', JSON.stringify(newTemplates));
    set({ tableTemplates: newTemplates });
  },
  updateTableTemplate: (templateId, template) => {
    const currentTemplates = get().tableTemplates.map(t => t.id === templateId ? template : t);
    localStorage.setItem('tableTemplates', JSON.stringify(currentTemplates));
    set({ tableTemplates: currentTemplates });
  },

  // Add Auth initialization logic
  initAuth: async () => {
    const { token } = get();
    if (token) {
      api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      try {
        const response = await api.get('/me');
        set({ currentUser: mapUser(response.data) });
      } catch (e) {
        get().setToken(null);
        get().setCurrentUser(null);
      }
    }
  },

  login: async (credentials) => {
    set({ isLoading: true, error: null });
    try {
      const response = await api.post('/login', credentials);
      get().setToken(response.data.token);
      set({ currentUser: mapUser(response.data.user), isLoading: false });
    } catch (error: any) {
      set({ error: error.response?.data?.message || 'Login failed', isLoading: false });
      throw error;
    }
  },

  register: async (data: any) => {
    set({ isLoading: true, error: null });
    try {
      await api.post('/register', data);
      set({ isLoading: false });
    } catch (error: any) {
      set({ error: error.response?.data?.message || 'Register failed', isLoading: false });
      throw error;
    }
  },

  logout: () => {
    get().setToken(null);
    get().setCurrentUser(null);
  },

  fetchPlans: async () => {
    set({ isLoading: true, error: null });
    try {
      const response = await api.get('/plans');
      if (Array.isArray(response.data)) {
        set({ plans: response.data.map(mapPlan), isLoading: false });
      } else {
        throw new Error('API response is not an array');
      }
    } catch (error) {
      console.warn('API /plans failed or returned invalid data, falling back to mock data:', error);
      set({ 
        plans: generateMockPlans(), 
        isLoading: false, 
        error: 'Chế độ offline: Đang sử dụng dữ liệu mẫu' 
      });
    }
  },

  updatePlanStatus: async (planId, status, comment) => {
    const { plans, currentUser } = get();
    
    const updatedPlans = plans.map((p) => 
      p.id === planId 
        ? { 
            ...p, 
            status, 
            auditLog: [
              ...p.auditLog, 
              { 
                id: Math.random().toString(36).substr(2, 9), 
                actor: currentUser?.name || 'Hệ thống', 
                action: `Cập nhật trạng thái: ${status}`, 
                timestamp: new Date().toISOString(), 
                comment 
              }
            ] 
          } 
        : p
    );
    set({ plans: updatedPlans });

    try {
      await api.put(`/plans/${planId}/status`, { status, comment });
    } catch (error) {
      console.warn('Failed to update status on server, kept local change:', error);
    }
  },

  createPlan: async (newPlan) => {
    try {
      const payload = new FormData();
      payload.append('title', newPlan.title || '');
      payload.append('month', (newPlan.month || 1).toString());
      payload.append('year', (newPlan.year || new Date().getFullYear()).toString());
      
      if (newPlan.items) payload.append('items', JSON.stringify(newPlan.items));
      if (newPlan.weeks) payload.append('weeks', JSON.stringify(newPlan.weeks));

      // Handle multiple newly uploaded files
      if (newPlan.newAttachments && Array.isArray(newPlan.newAttachments)) {
        newPlan.newAttachments.forEach((file: File) => {
          payload.append('new_attachments[]', file);
        });
      }

      // Legacy single file support
      if (newPlan.attachedFile) {
        payload.append('new_attachments[]', newPlan.attachedFile);
      }

      const response = await api.post('/plans', payload);
      set((state) => ({ plans: [mapPlan(response.data), ...state.plans] }));
    } catch (error) {
      console.error('Failed to create plan on server:', error);
      throw error;
    }
  },

  updatePlan: async (planId, payload) => {
    try {
      const formData = new FormData();
      if (payload.title) formData.append('title', payload.title);
      if (payload.items) formData.append('items', JSON.stringify(payload.items));
      if (payload.weeks) formData.append('weeks', JSON.stringify(payload.weeks));
      
      if (payload.keptAttachments) {
        formData.append('kept_attachments', JSON.stringify(payload.keptAttachments));
      }

      if (payload.newAttachments && Array.isArray(payload.newAttachments)) {
        payload.newAttachments.forEach((file: File) => {
          formData.append('new_attachments[]', file);
        });
      }

      const response = await api.post(`/plans/${planId}`, formData);
      const updatedPlan = mapPlan(response.data);
      
      set((state) => ({
        plans: state.plans.map(p => p.id === planId ? updatedPlan : p)
      }));
    } catch (error) {
      console.error('Failed to update plan on server:', error);
      throw error;
    }
  },

  deletePlan: async (planId: string) => {
    // Optimistic delete
    set((state) => ({ plans: state.plans.filter(p => p.id !== planId) }));
    try {
      await api.delete(`/plans/${planId}`);
    } catch (error) {
      console.error('Failed to delete plan on server:', error);
      // Revert if it fails (not implemented for simplicity, but logs error)
    }
  },
}));
