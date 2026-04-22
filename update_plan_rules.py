import re

with open('frontend/src/components/MyPlans.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

# I want to find handleCreate and replace its logic.
# Also find the form and add the month/year selectors.
# First, update the state declarations in NewPlanModal

state_target = '''  const [weeks, setWeeks] = useState([0, 0, 0, 0, 0]);
  
  const currentDate = new Date();
  const endOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);'''

state_replacement = '''  const [weeks, setWeeks] = useState([0, 0, 0, 0, 0]);
  
  const currentDate = new Date();
  const [planMonth, setPlanMonth] = useState(currentDate.getMonth() + 1);
  const [planYear, setPlanYear] = useState(currentDate.getFullYear());
  const endOfMonth = new Date(planYear, planMonth, 0);'''

if state_target in content:
    content = content.replace(state_target, state_replacement)

# Next, update handleCreate
handle_target = '''  const handleCreate = async () => {
    if (!title.trim() || !currentUser) return;
    setError(null);
    
    const month = currentDate.getMonth() + 1;
    const year = currentDate.getFullYear();

    const existingPlan = useAppStore.getState().plans.find(p => p.teacherId === currentUser.id && p.month === month && p.year === year);'''

handle_replacement = '''  const handleCreate = async () => {
    if (!title.trim() || !currentUser) return;
    setError(null);
    
    const month = planMonth;
    const year = planYear;

    // Validation for rules: From May onwards, no past dates, create before 5th.
    // Also, execution after 5th (this will just be a UI note).
    const isMayOrLater = (year > 2024) || (year === 2024 && month >= 5) || (year === 2026 && month >= 5);
    // Since we don't know exact year, let's just say if month >= 5 or year > currentYear
    if (month >= 5 || year > currentDate.getFullYear() || (year === 2026)) {
        const isPastPlan = (year < currentDate.getFullYear()) || (year === currentDate.getFullYear() && month < currentDate.getMonth() + 1);
        if (isPastPlan) {
            setError(`Không được lập kế hoạch cho tháng trong quá khứ.`);
            return;
        }
        if (year === currentDate.getFullYear() && month === currentDate.getMonth() + 1) {
            if (currentDate.getDate() > 5) {
                setError(`Đã quá hạn lập kế hoạch cho tháng ${month}. Kế hoạch phải được lập trước ngày 05 hàng tháng.`);
                return;
            }
        }
    }

    const existingPlan = useAppStore.getState().plans.find(p => p.teacherId === currentUser.id && p.month === month && p.year === year);'''

if handle_target in content:
    content = content.replace(handle_target, handle_replacement)

# Next, update the UI to include month/year selectors
ui_target = '''          <div>
            <label className="text-xs font-bold text-zinc-500 uppercase tracking-wider block mb-1">Tên kế hoạch</label>
            <input
              type="text"
              placeholder="VD: Kế hoạch công tác tháng 12/2025"
              value={title}
              onChange={e => setTitle(e.target.value)}
              className="w-full px-4 py-2.5 border border-zinc-200 rounded-xl text-sm focus:ring-2 focus:ring-primary/20 outline-none"
            />
          </div>'''

ui_replacement = '''          <div>
            <label className="text-xs font-bold text-zinc-500 uppercase tracking-wider block mb-1">Tên kế hoạch</label>
            <input
              type="text"
              placeholder="VD: Kế hoạch công tác tháng 12/2025"
              value={title}
              onChange={e => setTitle(e.target.value)}
              className="w-full px-4 py-2.5 border border-zinc-200 rounded-xl text-sm focus:ring-2 focus:ring-primary/20 outline-none mb-3"
            />
            
            <div className="grid grid-cols-2 gap-3">
               <div>
                  <label className="text-xs font-bold text-zinc-500 uppercase tracking-wider block mb-1">Tháng</label>
                  <select 
                    value={planMonth} 
                    onChange={e => setPlanMonth(Number(e.target.value))}
                    className="w-full px-4 py-2.5 border border-zinc-200 rounded-xl text-sm focus:ring-2 focus:ring-primary/20 outline-none bg-white"
                  >
                    {[1,2,3,4,5,6,7,8,9,10,11,12].map(m => (
                       <option key={m} value={m}>Tháng {m}</option>
                    ))}
                  </select>
               </div>
               <div>
                  <label className="text-xs font-bold text-zinc-500 uppercase tracking-wider block mb-1">Năm</label>
                  <select 
                    value={planYear} 
                    onChange={e => setPlanYear(Number(e.target.value))}
                    className="w-full px-4 py-2.5 border border-zinc-200 rounded-xl text-sm focus:ring-2 focus:ring-primary/20 outline-none bg-white"
                  >
                    {[2024, 2025, 2026, 2027].map(y => (
                       <option key={y} value={y}>Năm {y}</option>
                    ))}
                  </select>
               </div>
            </div>
          </div>'''

if ui_target in content:
    content = content.replace(ui_target, ui_replacement)

# Add note for execution time
note_target = '''<label className="text-xs font-bold text-zinc-500 uppercase tracking-wider block mb-1">Dự kiến số giờ (Nhập thủ công)</label>'''
note_replacement = '''<label className="text-xs font-bold text-zinc-500 uppercase tracking-wider block mb-1">Dự kiến số giờ <span className="text-[10px] text-red-500 normal-case">(Thời gian thực hiện phải sau ngày 05)</span></label>'''
if note_target in content:
    content = content.replace(note_target, note_replacement)

with open('frontend/src/components/MyPlans.tsx', 'w', encoding='utf-8') as f:
    f.write(content)

print("Updated MyPlans.tsx")
