import re

with open('src/components/PlanEditor.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

# Fix the JSX syntax error in time allocation header
bad_jsx = r'''<div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                  <Calendar size={16} className="text-primary" />
                  <h3 className="text-sm font-bold text-zinc-800 uppercase tracking-wider">Phân bổ thời gian</h3>
                </div>
              <div className="grid grid-cols-1 gap-4">'''

good_jsx = r'''<div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                  <Calendar size={16} className="text-primary" />
                  <h3 className="text-sm font-bold text-zinc-800 uppercase tracking-wider">Phân bổ thời gian</h3>
                </div>
              </div>
              <div className="grid grid-cols-1 gap-4">'''

content = content.replace(bad_jsx, good_jsx)

with open('src/components/PlanEditor.tsx', 'w', encoding='utf-8') as f:
    f.write(content)
print("Updated JSX successfully")
