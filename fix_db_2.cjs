const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'saodo_equipment'
});

connection.query('ALTER TABLE user_activities MODIFY COLUMN action varchar(255) NULL', (err, results) => {
  if (err) {
    console.error(err);
  } else {
    console.log("Made 'action' nullable.");
  }
  process.exit();
});
