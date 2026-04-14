const mysql = require('mysql2/promise');

async function main() {
  const connection = await mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'saodo_equipment',
    password: ''
  });

  const [users] = await connection.execute('SELECT id, email FROM users ORDER BY id ASC');
  
  let code = 1000001;
  const updates = [];

  for (const user of users) {
    let email = user.email;
    if (!/^\d{7,}$/.test(email)) {
      updates.push({ id: user.id, newEmail: code.toString() });
      code++;
    } else {
      const userCode = parseInt(email, 10);
      if (userCode >= code) {
        code = userCode + 1;
      }
    }
  }

  for (const update of updates) {
    await connection.execute('UPDATE users SET email = ? WHERE id = ?', [update.newEmail, update.id]);
    console.log(`Updated user ID ${update.id} to new code ${update.newEmail}`);
  }

  console.log("Database update complete. Total updated:", updates.length);
  await connection.end();
}

main().catch(console.error);
