const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'saodo_equipment'
});

connection.query(`
  ALTER TABLE user_activities ADD COLUMN type VARCHAR(255) AFTER user_id;
`, (err, results, fields) => {
  if (err) {
    console.error(err);
  } else {
    console.log("Successfully added 'type' column to user_activities!");
  }
  process.exit();
});
