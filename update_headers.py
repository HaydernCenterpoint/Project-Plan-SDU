import re

with open('src/components/PlanEditor.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

bad_jsx = r'''                  <thead>
                    <tr className="bg-zinc-100 text-xs font-bold text-black uppercase tracking-widest border-b border-zinc-300">
                      {activeTemplate.columns.map(col => (
                        <th key={col.id} className={`border-r border-zinc-300 px-2 py-2 ${col.width || 'min-w-[150px]'} ${col.align === 'center' ? 'text-center' : ''}`}>
                          {isEditable ? (
                            <input
                              type="text"
                              className="w-full bg-transparent outline-none uppercase font-black text-xs text-zinc-600 placeholder:text-zinc-300 text-center border-b border-dashed border-zinc-300 focus:border-primary py-1"
                              placeholder="Nhập tiêu đề"
                              value={col.name}
                              onChange={(e) => {
                                const newCols = activeTemplate.columns.map((c: any) => c.id === col.id ? { ...c, name: e.target.value } : c);
                                updateTableTemplate(activeTemplate.id, { ...activeTemplate, columns: newCols });
                              }}
                            />
                          ) : (
                            col.name || '—'
                          )}
                        </th>
                      ))}
                    </tr>
                  </thead>'''

good_jsx = r'''                  <thead>
                    <tr className="bg-zinc-100 text-xs font-bold text-black uppercase tracking-widest border-b border-zinc-300">
                      {activeTemplate.columns.map((col: any) => (
                        <th key={col.id} className={`border-r border-zinc-300 px-2 py-2 align-middle ${col.width || 'min-w-[150px]'} ${col.align === 'center' ? 'text-center' : ''}`}>
                          {col.id === 'tt' ? (
                            <div className="w-full text-center">STT</div>
                          ) : isEditable ? (
                            <textarea
                              rows={1}
                              className="w-full bg-transparent outline-none uppercase font-black text-xs text-zinc-600 placeholder:text-zinc-300 text-center border-b border-dashed border-zinc-300 focus:border-primary py-1 resize-none overflow-hidden"
                              placeholder="NHẬP TIÊU ĐỀ"
                              value={col.name}
                              onInput={(e: React.FormEvent<HTMLTextAreaElement>) => {
                                e.currentTarget.style.height = 'auto';
                                e.currentTarget.style.height = (e.currentTarget.scrollHeight) + 'px';
                              }}
                              onChange={(e) => {
                                const newCols = activeTemplate.columns.map((c: any) => c.id === col.id ? { ...c, name: e.target.value } : c);
                                updateTableTemplate(activeTemplate.id, { ...activeTemplate, columns: newCols });
                              }}
                              style={{ minHeight: '32px' }}
                            />
                          ) : (
                            col.name || '—'
                          )}
                        </th>
                      ))}
                    </tr>
                  </thead>'''

# We have to escape the f strings properly or just use replace
content = content.replace(bad_jsx, good_jsx)

with open('src/components/PlanEditor.tsx', 'w', encoding='utf-8') as f:
    f.write(content)
print("Updated PlanEditor Header JS")
