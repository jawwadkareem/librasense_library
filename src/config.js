const mysql = require('mysql');
const con = mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'123',
    database:'librasensedb'
});
module.exports = con;