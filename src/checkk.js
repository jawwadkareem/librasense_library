// const path = require('path');
// console.log(path.join(__dirname,'..','public','books' +'.jpg'))


const con = require('./config');
// publisher_check = "select publisher_name from publisher where publisher_name = ?;"
// con.query(publisher_check,['dell publising'],function(err,result){
//   console.log(result.length)
// })

// sql = "SELECT date(issue_date) from staff_user_records";

// con.query(sql, function(err, result) {
//   var a = JSON.parse(JSON.stringify(result));
//   console.log(a)

// });

const job = 'Select isbn from maintains where staff_id = ?'
    con.query(job,['ST-0003'],function(err,result){
      const results = JSON.parse(JSON.stringify(result));
      console.log(results)
      result.forEach(function(i){
        console.log(i.isbn)
      })
    })
