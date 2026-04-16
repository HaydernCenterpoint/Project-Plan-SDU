import html2pdf from 'html2pdf.js';
import { formatThoiGian } from './formatThoiGian';
export const buildPlanHTML = (plan: any) => {
  const date = new Date();
  
  const teacherTemplate = {
    columns: [
      { id: 'tt', name: 'TT', width: '30px' },
      { id: 'chu_de', name: 'Tên chủ đề/nội dung nghiên cứu', width: 'auto' },
      { id: 'dia_diem', name: 'Địa điểm', width: '80px' },
      { id: 'ten_thiet_bi', name: 'Tên thiết bị', width: '120px' },
      { id: 'nam_su_dung', name: 'Năm đưa vào sử dụng', width: '60px' },
      { id: 'giang_vien', name: 'Giảng viên thực hiện', width: '100px' },
      { id: 'thoi_gian', name: 'Thời gian thực hiện', width: '100px' },
      { id: 'ket_qua', name: 'Dự kiến kết quả đạt được', width: '120px' }
    ]
  };

  const studentTemplate = {
    columns: [
      { id: 'tt', name: 'TT', width: '30px' },
      { id: 'chu_de', name: 'Tên chủ đề/nội dung nghiên cứu', width: 'auto' },
      { id: 'dia_diem', name: 'Địa điểm', width: '80px' },
      { id: 'ten_thiet_bi', name: 'Tên thiết bị', width: '120px' },
      { id: 'nam_su_dung', name: 'Năm đưa vào sử dụng', width: '60px' },
      { id: 'sinh_vien', name: 'Sinh viên thực hiện', width: '100px' },
      { id: 'giang_vien', name: 'Giảng viên hướng dẫn', width: '100px' },
      { id: 'thoi_gian', name: 'Thời gian thực hiện', width: '100px' },
      { id: 'ket_qua', name: 'Dự kiến kết quả đạt được', width: '120px' }
    ]
  };

  const teacherItems = plan.items?.filter((i: any) => i.tableType !== 'student') || [];
  const studentItems = plan.items?.filter((i: any) => i.tableType === 'student') || [];

  const buildTable = (items: any[], template: any) => {
    if (items.length === 0) return `<div style="font-style: italic; margin: 10px 0;">Không có dữ liệu</div>`;
    
    let thead = `<tr style="font-weight: bold; background-color: #f8fafc; font-size: 10pt;">`;
    template.columns.forEach((col: any) => {
      thead += `<th style="border: 1px solid black; padding: 8px 6px; text-align: center; vertical-align: middle; width: ${col.width}; text-transform: uppercase;">${col.name}</th>`;
    });
    thead += `</tr>`;

    let tbody = '';
    items.forEach((item: any, idx: number) => {
      tbody += `<tr>`;
      template.columns.forEach((col: any) => {
        let val = col.id === 'tt' ? (idx + 1) : (item[col.id] || '');
        if (col.id === 'thoi_gian') {
          val = typeof val === 'string' ? val.replace(/\n/g, '<br/>') : val;
        }
        const align = col.id === 'tt' || col.id === 'nam_su_dung' ? 'center' : 'left';
        tbody += `<td style="border: 1px solid black; padding: 6px; text-align: ${align}; vertical-align: middle;">${val}</td>`;
      });
      tbody += `</tr>`;
    });

    return `
      <table class="report-table">
        <thead>${thead}</thead>
        <tbody>${tbody}</tbody>
      </table>
    `;
  };

  const deptName = plan.departmentName || '................................';

  return `
    <style>
      .report-container {
        font-family: 'Times New Roman', serif;
        color: #000;
        font-size: 13pt;
        padding: 20px 30px;
        box-sizing: border-box;
        width: 100%;
        line-height: 1.4;
      }
      .report-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        margin-bottom: 20px;
        font-size: 11pt;
        page-break-inside: auto;
      }
      .report-table tr {
        page-break-inside: avoid;
        page-break-after: auto;
      }
      .report-table thead {
        display: table-header-group;
      }
      .indent-p {
        text-indent: 30px;
        margin: 5px 0;
      }
      .dash-li {
        margin: 5px 0;
        padding-left: 15px;
        text-indent: -15px;
      }
      .plus-li {
        margin: 5px 0;
        padding-left: 30px;
        text-indent: -15px;
      }
      .section-title {
        font-weight: bold;
        margin-top: 15px;
        margin-bottom: 5px;
      }
      .sub-title {
        font-weight: bold;
      }
    </style>
    <div class="report-container">
      <div style="display: flex; justify-content: space-between; text-align: center; margin-bottom: 20px; line-height: 1.2;">
        <div>
          <div style="text-transform: uppercase;">TRƯỜNG ĐẠI HỌC SAO ĐỎ</div>
          <div style="text-transform: uppercase; font-weight: bold; text-decoration: underline;">KHOA ${deptName.toUpperCase().replace('KHOA ', '')}</div>
        </div>
        <div>
          <div style="font-weight: bold; text-transform: uppercase;">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</div>
          <div style="font-weight: bold; text-decoration: underline;">Độc lập - Tự do - Hạnh phúc</div>
          <div style="font-style: italic; margin-top: 5px;">Hải Dương, ngày ${date.getDate()} tháng ${date.getMonth() + 1} năm ${date.getFullYear()}</div>
        </div>
      </div>

      <div style="text-align: center; margin-bottom: 20px; margin-top: 30px;">
        <div style="font-weight: bold; font-size: 14pt;">KẾ HOẠCH</div>
        <div style="font-weight: bold; font-size: 13pt;">KHAI THÁC TRANG THIẾT BỊ, PHÒNG THỰC HÀNH, THÍ NGHIỆM TRONG VÀ NGOÀI GIỜ HÀNH CHÍNH</div>
        <div style="font-weight: bold; font-style: italic; font-size: 13pt;">Tháng ${plan.month} năm ${plan.year}</div>
      </div>

      <div class="section-title">I. Mục đích, yêu cầu</div>
      <div class="sub-title">1. Mục đích</div>
      <div class="dash-li">- Nâng cao trình độ nghiệp vụ chuyên môn, kỹ năng tay nghề cho giảng viên, sinh viên góp phần nâng cao chất lượng đào tạo của khóa học đáp ứng chuẩn đầu ra của Nhà trường;</div>
      <div class="dash-li">- Tăng cường khai thác hợp lý, hiệu quả cơ sở vật chất, trang thiết bị, phòng thực hành, thí nghiệm của khoa hiện có phục vụ tốt nhiệm vụ đào tạo và nghiên cứu khoa học của giảng viên, sinh viên.</div>
      
      <div class="sub-title">2. Yêu cầu</div>
      <div class="dash-li">- Đối với giảng viên</div>
      <div class="plus-li">+ Giảng viên chuẩn bị chu đáo các nội dung thực hành, thí nghiệm, vật tư theo tiến độ thực hiện, đề cương môn học và chuẩn bị mẫu mô hình theo kế hoạch đã dự kiến đảm bảo 100% thời gian lên lớp.</div>
      <div class="plus-li">+ Giảng viên tham gia đầy đủ, đúng thời gian, địa điểm theo kế hoạch đã đăng ký. Giảng viên hướng dẫn đảm bảo an toàn tuyệt đối về người, thiết bị trong quá trình thực hành, thí nghiệm.</div>
      <div class="dash-li">- Đối với sinh viên</div>
      <div class="plus-li">+ Sinh viên tham gia đầy đủ, đúng thời gian, địa điểm theo kế hoạch đã đăng ký.</div>
      <div class="plus-li">+ Tuân thủ nghiêm ngặt các quy định về an toàn, nội quy phòng thực hành.</div>

      <div class="section-title">II. Nội dung thực hiện</div>
      <div class="sub-title">1. Đối với giảng viên</div>
      ${buildTable(teacherItems, teacherTemplate)}

      <div class="sub-title">2. Đối với sinh viên</div>
      ${buildTable(studentItems, studentTemplate)}

      <div class="section-title">III. Tổ chức thực hiện</div>
      <div class="sub-title">1. Khoa ${plan.departmentName?.replace('Khoa ', '') || '.......................'}</div>
      <div class="dash-li">- Lập kế hoạch, triển khai đến giảng viên, sinh viên trong khoa;</div>
      <div class="dash-li">- Bố trí giảng viên phụ trách phòng máy tính hỗ trợ cài đặt các phần mềm phục vụ khai thác thiết bị;</div>
      <div class="dash-li">- Quản lý, kiểm tra, đôn đốc giảng viên, sinh viên thực hiện đúng kế hoạch;</div>
      <div class="dash-li">- Tổng hợp báo cáo Ban Giám hiệu, Phòng Quản lý chất lượng theo quy định.</div>
      
      <div class="sub-title">2. Bộ môn ...............................................</div>
      <div class="dash-li">- Đôn đốc giảng viên, sinh viên tham gia đầy đủ, đúng thời gian, địa điểm.</div>
      
      <div class="sub-title">3. Giáo viên, sinh viên</div>
      <div class="dash-li">- Thực hiện nghiêm túc, đúng kế hoạch đề ra;</div>
      <div class="dash-li">- Kết thúc thời gian thực hiện kế hoạch giảng viên tổ chức đánh giá kết quả đạt được, sinh viên nộp sản phẩm hoàn thành kế hoạch đã đề ra về bộ môn.</div>

      <div style="display: flex; justify-content: space-between; text-align: center; font-size: 13pt; margin-top: 40px;">
         <div style="flex: 1;">
         </div>
         <div style="flex: 1; display: flex; flex-direction: column; align-items: center;">
            <span style="font-weight: bold; text-transform: uppercase;">TRƯỞNG KHOA</span>
            <br/><br/><br/><br/><br/>
            <span style="font-weight: bold;">................................</span>
         </div>
      </div>
    </div>
  `;
};

export const exportPlanToPdf = (plan: any) => {
  const content = buildPlanHTML(plan);
  const tempDiv = document.createElement('div');
  tempDiv.innerHTML = content;
  
  html2pdf().set({
    margin: [15, 10, 15, 10],
    filename: `KH_Khai_Thac_Thiet_Bi_Thang_${plan.month}.pdf`,
    image: { type: 'jpeg', quality: 0.98 },
    html2canvas: { scale: 2, useCORS: true },
    jsPDF: { unit: 'mm', format: 'a4', orientation: 'landscape' },
    pagebreak: { mode: ['css', 'legacy'] }
  } as any).from(tempDiv).save();
};

export const exportPlanToDocx = (plan: any) => {
  const content = buildPlanHTML(plan);
  const header = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'><head><meta charset='utf-8'><title>KẾ HOẠCH</title></head><body>";
  const footer = "</body></html>";
  const sourceHTML = header + content + footer;
  
  const source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
  const fileDownload = document.createElement("a");
  document.body.appendChild(fileDownload);
  fileDownload.href = source;
  fileDownload.download = `KH_Khai_Thac_Thiet_Bi_Thang_${plan.month}.doc`;
  fileDownload.click();
  document.body.removeChild(fileDownload);
};

export const printPlanBrowser = (plan: any) => {
  const content = buildPlanHTML(plan);
  const printWindow = window.open('', '_blank');
  if (printWindow) {
    printWindow.document.write(`
      <html>
        <head>
          <title>In Kế Hoạch</title>
          <style>@page { size: landscape; }</style>
        </head>
        <body onload="window.print(); window.close();">
          ${content}
        </body>
      </html>
    `);
    printWindow.document.close();
  }
};
