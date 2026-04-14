import mysql from 'mysql2/promise';

async function run() {
  const connection = await mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '',
    database: 'saodo_equipment'
  });

  await connection.query(`
    CREATE TABLE IF NOT EXISTS user_activities (
      id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      user_id BIGINT UNSIGNED NOT NULL,
      action VARCHAR(255) NOT NULL,
      description TEXT NULL,
      created_at TIMESTAMP NULL DEFAULT NULL,
      updated_at TIMESTAMP NULL DEFAULT NULL,
      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  console.log('Table user_activities created successfully!');
  await connection.end();
}

run().catch(console.error);
