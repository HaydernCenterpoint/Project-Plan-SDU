// Run: node seed_demo_users.js
const fs = require('fs');

async function seed() {
  const depts = [
    { id: 1, name: 'Khoa Công nghệ thông tin', code: 'CNTT', prefix: 'cntt' },
    { id: 2, name: 'Khoa May và Thời trang', code: 'KMT', prefix: 'kmt' },
    { id: 3, name: 'Khoa Cơ khí', code: 'KCK', prefix: 'kck' },
    { id: 4, name: 'Khoa Điện', code: 'KD', prefix: 'kd' },
    { id: 5, name: 'Khoa Ô tô', code: 'KOT', prefix: 'kot' }
  ];

  console.log('Seeding 5 users per department...');

  for (const dept of depts) {
    for (let i = 1; i <= 5; i++) {
        const payload = {
            name: `Giảng viên ${i} (${dept.name})`,
            email: `${dept.prefix}${i}@saodo.edu.vn`,
            password: 'password123',
            password_confirmation: 'password123',
            department_id: dept.id,
            role: 'TEACHER'
        };

        try {
            const res = await fetch('http://127.0.0.1:8000/api/auth/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

            const data = await res.json();
            if (res.ok) {
                console.log(`[SUCCESS] Registered: ${payload.name}`);
                
                // Active user right away
                // Admin login and approve? No, new users are PENDING by default in my system.
                // If they are PENDING, they won't appear in `/users/active`.
            } else {
                console.log(`[FAILED] ${payload.name}:`, data);
            }
        } catch (e) {
            console.error(e);
        }
    }
  }
}

seed();
