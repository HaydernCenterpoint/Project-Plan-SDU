import sys

with open('frontend/src/components/QCPanel.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

# Add the import
if 'exportReportToXlsx' not in content:
    content = content.replace("exportReportToPdf, printReportBrowser", "exportReportToPdf, printReportBrowser, exportReportToXlsx")

target = 'Xuất ra DOCX'

if target in content and 'Xuất ra Excel' not in content:
    idx = content.find(target)
    start_btn = content.rfind('<button', 0, idx)
    new_btn = """<button 
                    onClick={() => exportReportToXlsx(selectedMonth, generateExportData(selectedMonth))}
                    className="w-full text-left px-4 py-2.5 text-sm text-slate-700 hover:bg-slate-50 font-medium flex items-center gap-2 border-b border-slate-100 transition-colors"
                  >
                    Xuất ra Excel (XLSX)
                  </button>\n                  """
    content = content[:start_btn] + new_btn + content[start_btn:]
    with open('frontend/src/components/QCPanel.tsx', 'w', encoding='utf-8') as f:
        f.write(content)
