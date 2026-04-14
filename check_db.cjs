const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'saodo_equipment'
});

connection.query('DESCRIBE user_activities', (err, results) => {
  if (err) {
    console.error(err);
  } else {
    console.log(results);
  }
  process.exit();
});
