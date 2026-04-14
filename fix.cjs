const fs = require('fs');
let txt = fs.readFileSync('src/components/PlanEditor.tsx', 'utf-8');

txt = txt.replace(/<button\s*onClick=\{\(\) => setWeeks\(prev => prev.filter\(w => w\.id !== week\.id\)\)\}\s*className="absolute top-3 right-3 text-red-400 opacity-0 group-hover:opacity-100 transition-opacity p-1.5 rounded-lg hover:bg-red-50 hover:text-red-600"\s*value=\{week\.date \|\| ''\}\s*onChange=\{e => updateWeek\(week\.id, 'date', e\.target\.value\)\}\s*className="w-full text-sm font-bold px-3 py-2 rounded-lg border border-zinc-300 outline-none focus:ring-2 focus:ring-primary\/20 focus:border-primary transition-all bg-white"\s*\/>\s*<\/div>/, 
`                        <button 
                            onClick={() => setWeeks(prev => prev.filter(w => w.id !== week.id))}
                            className="absolute top-3 right-3 text-red-400 opacity-0 group-hover:opacity-100 transition-opacity p-1.5 rounded-lg hover:bg-red-50 hover:text-red-600"
                        >
                            <Trash2 size={16} />
                        </button>
                      )}
                      <div className="space-y-4">
                        <div className="pr-8">
                          <span className="text-[10px] font-black text-zinc-500 uppercase block mb-1">Ngày thực hiện</span>
                          <input
                            type="date"
                            readOnly={!isEditable}
                            value={week.date || ''}
                            onChange={e => updateWeek(week.id, 'date', e.target.value)}
                            className="w-full text-sm font-bold px-3 py-2 rounded-lg border border-zinc-300 outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all bg-white"
                          />
                        </div>`);
fs.writeFileSync('src/components/PlanEditor.tsx', txt, 'utf-8');
console.log('Fixed');
