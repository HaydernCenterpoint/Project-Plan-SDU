import re

with open('src/components/PlanEditor.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Thêm import updateTableTemplate
if 'updateTableTemplate' not in content:
    content = re.sub(
        r'(const updatePlan = useAppStore\(state => state\.updatePlan\);)',
        r'\1\n  const updateTableTemplate = useAppStore(state => state.updateTableTemplate);',
        content
    )

# 2. Xóa nút "Thêm hàng" và thay bằng "Thêm cột"
content = re.sub(
    r'<button\s*onClick=\{addItem\}\s*disabled=\{!isEditable\}\s*className="flex items-center gap-1\.5 px-3 py-1\.5 bg-[#CC0000]/10 text-[#CC0000] rounded-lg text-xs font-bold hover:bg-[#CC0000]/20 transition-all disabled:opacity-50 disabled:cursor-not-allowed"\s*>\s*<Plus size=\{13\}\s*/>\s*Thêm hàng\s*</button>',
    r'''<button 
                onClick={() => {
                  if (activeTemplate) {
                    updateTableTemplate(activeTemplate.id, {
                      ...activeTemplate,
                      columns: [...activeTemplate.columns, { id: 'col_' + Date.now(), name: '', width: 'min-w-[150px]' }]
                    });
                  }
                }}
                disabled={!isEditable}
                className="flex items-center gap-1.5 px-3 py-1.5 bg-[#CC0000]/10 text-[#CC0000] rounded-lg text-xs font-bold hover:bg-[#CC0000]/20 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
              >
                <Plus size={13} /> Thêm cột
              </button>''',
    content
)

# 3. Thông tin chung: Đổi Kế hoạch tháng ... thành formattedDate
content = re.sub(
    r'<span className="text-sm font-bold text-zinc-900">Kế hoạch tháng \{plan\.month\}/\{plan\.year\}</span>',
    r'<span className="text-sm font-bold text-zinc-900">{new Date(plan.createdAt || Date.now()).toLocaleDateString("vi-VN")}</span>',
    content
)

content = re.sub(
    r'<span className="text-sm font-bold text-\[\#CC0000\]">Ngày cuối cùng của tháng</span>',
    r'<span className="text-sm font-bold text-[#CC0000]">{(() => { const d = new Date(plan.createdAt || Date.now()); return new Date(d.getFullYear(), d.getMonth() + 1, 0).toLocaleDateString("vi-VN"); })()}</span>',
    content
)

# 4. Thay đổi thead TH để chỉnh sửa được
old_th_map = r'''\{activeTemplate\.columns\.map\(\(col: any\) => \(
\s*<th key=\{col\.id\} className=\{\`p-4 border-r border-zinc-200/50 \$\{col\.width\}\`\}>
\s*\{col\.name\}
\s*</th>
\s*\)\)\}'''

new_th_map = r'''{activeTemplate.columns.map((col: any) => (
                        <th key={col.id} className={`p-4 border-r border-zinc-200/50 ${col.width}`}>
                          {isEditable ? (
                            <input 
                              type="text" 
                              className="w-full bg-transparent outline-none uppercase font-black text-xs text-zinc-600 placeholder:text-zinc-300 text-center"
                              placeholder="NHẬP TIÊU ĐỀ"
                              value={col.name}
                              onChange={(e) => {
                                  const newCols = activeTemplate.columns.map((c: any) => c.id === col.id ? { ...c, name: e.target.value } : c);
                                  updateTableTemplate(activeTemplate.id, { ...activeTemplate, columns: newCols });
                              }}
                            />
                          ) : (
                            col.name
                          )}
                        </th>
                      ))}'''

content = re.sub(old_th_map, new_th_map, content)


# 5. Xóa cột XÓA (header)
content = re.sub(
    r'<th className="w-\[80px\] font-black text-xs text-zinc-600 uppercase text-center p-4">Xóa</th>',
    '',
    content
)

# 6. Xóa td XÓA (body)
td_delete_match = r'<td className="text-center p-2">\s*<button[\s\S]*?<Trash2 size=\{16\} />\s*</button>\s*</td>'
content = re.sub(td_delete_match, '', content)

# 7. Xóa nút "Thêm phân bổ" ở header "PHÂN BỔ THỜI GIAN"
add_time_btn = r'<button\s*onClick=\{addWeek\}\s*disabled=\{!isEditable\}\s*className="flex items-center gap-1\.5 px-3 py-1\.5 bg-[#CC0000]/10 text-[#CC0000] rounded-lg text-xs font-bold hover:bg-[#CC0000]/20 transition-all disabled:opacity-50 disabled:cursor-not-allowed"\s*>\s*<Plus size=\{13\} /> Thêm phân bổ\s*</button>'
content = re.sub(add_time_btn, '', content)

# 8. Thay toàn bộ render của từng cục week cho ngắn gọn lại
# Xóa button thùng rác ở week
week_content_pattern = r'<div key=\{week\.id\} className="border border-zinc-200 p-4 rounded-xl bg-zinc-50/50 relative group hover:border-zinc-300 transition-colors">[\s\S]*?className="pt-3 border-t border-zinc-200/60"[\s\S]*?</div>\s*\)\}\s*</div>\s*</div>'

new_week_content = r'''<div key={week.id} className="flex flex-wrap md:flex-nowrap items-end gap-3 border border-zinc-200 p-3 rounded-lg bg-zinc-50 hover:border-zinc-300 transition-colors">
                      <div className="flex-1 min-w-[150px]">
                        <span className="text-[10px] font-black text-zinc-500 uppercase block mb-1">Ngày thực hiện</span>
                        <input
                          type="date"
                          readOnly={!isEditable}
                          value={week.date || ''}
                          onChange={e => updateWeek(week.id, 'date', e.target.value)}
                          className="w-full text-sm font-bold px-3 py-2 rounded-lg border border-zinc-300 outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all bg-white"
                        />
                      </div>
                      <div className="w-[120px]">
                        <span className="text-[10px] font-black text-zinc-500 uppercase block mb-1">Từ tiết</span>
                        <select
                          disabled={!isEditable}
                          value={week.startLesson || 1}
                          onChange={e => {
                            const newStart = Number(e.target.value);
                            const newEnd = Math.max(newStart, week.endLesson || newStart);
                            setWeeks(prev => prev.map(w => w.id === week.id ? { ...w, startLesson: newStart, endLesson: newEnd, plannedHours: newEnd - newStart + 1 } : w));
                          }}
                          className="w-full text-sm font-bold px-2 py-2 rounded-lg border border-zinc-300 outline-none focus:ring-2 focus:ring-primary/20 bg-white disabled:opacity-70 disabled:bg-zinc-100"
                        >
                            {Array.from({ length: 15 }, (_, i) => i + 1).map(n => <option key={n} value={n}>Tiết {n}</option>)}
                        </select>
                      </div>
                      <div className="w-[120px]">
                        <span className="text-[10px] font-black text-zinc-500 uppercase block mb-1">Đến tiết</span>
                        <select
                          disabled={!isEditable}
                          value={week.endLesson || (week.startLesson || 1)}
                          onChange={e => {
                            const newEnd = Number(e.target.value);
                            const newStart = Math.min(newEnd, week.startLesson || newEnd);
                            setWeeks(prev => prev.map(w => w.id === week.id ? { ...w, startLesson: newStart, endLesson: newEnd, plannedHours: newEnd - newStart + 1 } : w));
                          }}
                          className="w-full text-sm font-bold px-2 py-2 rounded-lg border border-zinc-300 outline-none focus:ring-2 focus:ring-primary/20 bg-white disabled:opacity-70 disabled:bg-zinc-100"
                        >
                            {Array.from({ length: 15 }, (_, i) => i + 1).map(n => <option key={n} value={n}>Tiết {n}</option>)}
                        </select>
                      </div>
                      <div className="w-[80px] text-center">
                        <span className="text-[10px] font-black text-zinc-500 uppercase block mb-1">Tổng số</span>
                        <div className="text-sm py-1.5 font-black text-primary bg-primary/10 rounded-md h-[38px] flex items-center justify-center">
                          {(week.endLesson || week.startLesson || 1) - (week.startLesson || 1) + 1}
                        </div>
                      </div>
                      {(isReporting || week.actualHours !== undefined) && (
                        <div className="w-[100px]">
                          <span className="text-[10px] font-black text-emerald-600 uppercase block mb-1">Thực hiện</span>
                          <input
                            type="number"
                            readOnly={!isReporting}
                            value={week.actualHours ?? 0}
                            onChange={e => updateWeek(week.id, 'actualHours', Number(e.target.value))}
                            className="w-full text-sm font-black text-center py-2 rounded border border-emerald-500/30 bg-emerald-50 text-emerald-600 outline-none focus:ring-1 focus:ring-emerald-400 h-[38px]"
                          />
                        </div>
                      )}
                    </div>'''

content = re.sub(week_content_pattern, new_week_content, content)


with open('src/components/PlanEditor.tsx', 'w', encoding='utf-8') as f:
    f.write(content)
print("Updated successfully")
