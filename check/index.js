// Import required modules
const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

// Create an instance of Express
const app = express();

// Set up MySQL connection
const connection = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'123',
    database:'librasensedb'
});

// Connect to the MySQL server
connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to the MySQL server');
});

// Middleware for parsing request body
app.use(bodyParser.urlencoded({ extended: true }));

// Serve static files from the "public" directory
app.use(express.static('public'));

// Define the login route
app.post('/login', (req, res) => {
  const { email, password } = req.body;

  // Query the database for the user credentials
  const sql = `SELECT * FROM user_info WHERE email = '${email}' AND password = '${password}'`;

  connection.query(sql, (err, results) => {
    if (err) throw err;

    if (results.length > 0) {
      // Authentication successful, redirect to user page
      res.send('success');
    } else {
      // Authentication failed, display error message
      res.send('error');
    }
  });
});

// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
