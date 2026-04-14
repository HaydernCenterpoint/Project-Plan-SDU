const fs = require('fs');
let text = fs.readFileSync('src/components/PlanEditor.tsx', 'utf-8');

// 1. the Attachments Card starts at `{/* Attachments Card */}` and ends with `</section>` (before Table Templates)
const attachStart = text.indexOf('{/* Attachments Card */}');
const attachEndMatch = text.indexOf('</section>', attachStart);
if (attachStart !== -1 && attachEndMatch !== -1) {
    const attachText = text.substring(attachStart, attachEndMatch);
    text = text.substring(0, attachStart) + text.substring(attachEndMatch);
    
    // Now insert it before Document Viewers
    const docViewersIdx = text.indexOf('{/* Document Viewers */}');
    text = text.substring(0, docViewersIdx) + `<div className="mt-8">\n${attachText}\n</div>\n\n            ` + text.substring(docViewersIdx);
}

// 2. Remove Table Templates Selector
const tpStart = text.indexOf('{/* Table Templates Selector */}');
const tpEndMatch = text.indexOf('{/* Activities table */}', tpStart);
if (tpStart !== -1 && tpEndMatch !== -1) {
    text = text.substring(0, tpStart) + text.substring(tpEndMatch);
}

// 3. Remove `xl:grid-cols-2` from Info Card container
text = text.replace('className="grid grid-cols-1 xl:grid-cols-2 gap-6"', 'className="grid grid-cols-1 gap-6"');

// 4. Time Allocation simplifications
// Replace "Nội dung thực hiện" dropdown
const topicSelectStart = text.indexOf('<span className="text-[10px] font-black text-zinc-500 uppercase block mb-1">Nội dung thực hiện</span>');
if (topicSelectStart !== -1) {
   const topicSelectEnd = text.indexOf('</div>', topicSelectStart) + 6;
   text = text.substring(0, topicSelectStart - 40) + text.substring(topicSelectEnd);
}

// Remove "Thêm phân bổ" button
const addWeekStart = text.indexOf('<button\n                    onClick={() => {\n                      setWeeks');
if (addWeekStart !== -1) {
    const addWeekEnd = text.indexOf('</button>', addWeekStart) + 9;
    text = text.substring(0, addWeekStart) + text.substring(addWeekEnd);
}

// Make "Chi tiết hoạt động" header inputs editable and remove "Thêm hoạt động", replace with Add Row/Col
text = text.replace('<Plus size={13} /> Thêm hoạt động', '<Plus size={13} /> Thêm hàng');

fs.writeFileSync('src/components/PlanEditor.tsx', text, 'utf-8');
console.log("Done text replacement.");
