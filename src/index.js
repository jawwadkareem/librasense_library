const con = require('./config');
const express = require('express');
const app = express();
const path = require('path');
const bcrypt = require('bcrypt');
const session = require('express-session');
const multer = require('multer');
const fs = require("fs");


const upload = multer({ dest: __dirname});
// con.connect(function(err){
//     if (err) throw err;
//     con.query('Select * from booklib',function(errr,res){
//         if (errr) throw errr;
//         console.log(res[0]);
//     })
// })
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '../public')));

app.use(session({
    secret: 'your-secret-key',
    resave: true,
    saveUninitialized: true
}));
app.set('view engine', 'ejs');

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../public/index.html'))
})
app.post('/signup', (req, res) => {
    const { name, password, email, address, tel, rectel } = req.body;

    bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(password, salt, function (err, hash) {
            // Store hash in the database


            const user_info = "INSERT INTO user_info(name,email,password,address) VALUES(?,?,?,?)";
            con.query(user_info, [name, email, hash, address], function (error1, result1) {
                if (error1) throw error1;

                const user = "INSERT INTO user(email) VALUES('" + email + "')";
                con.query(user, function (error2, result2) {
                    if (error2) throw error2;

                    con.query('SELECT user_id from user where email = ?', [email], function (error3, result3) {
                        if (error3) throw error3;
                        results = JSON.parse(JSON.stringify(result3));
                        uid = results[0].user_id;
                        staff = "SELECT staff_id FROM staff WHERE email IN (SELECT email FROM staff_info WHERE job = 'Records Manager')";

                        con.query(staff, function(err, result) {
                            var a = JSON.parse(JSON.stringify(result))
                            staff_idd =  a[Math.floor(Math.random() * a.length)].staff_id;
                            const keepstrack = 'Insert into keeps_track_of values(?,?);'
                            con.query(keepstrack,[staff_idd,uid],function(err,ressult){
                                if(err) console.log(err)

                                const telno = "INSERT INTO user_telno(user_id,telno) VALUES(?,?)";
                    
                                con.query(telno, [uid, tel], function (error4, result4) {
                                    if (error4) throw error4;
                                    else {
                                        if (rectel == '') {
                                            req.session.userid = uid
                                            res.redirect('/user') }
                                        else {
                                            const recttelquery = "INSERT INTO user_telno(user_id,telno) VALUES(?,?)";
                                            con.query(recttelquery, [uid, rectel], function (error5, result5) {
                                                if (error4) throw error5;
                                                req.session.userid = uid
                                                res.redirect('/user');
                                            });
                                        }
                                    }
                                });
                            });});
                    }) 
                });
            });
        });
    })
});

app.post('/login', (req, res) => {
    const { email, password } = req.body;

    const login = `SELECT * FROM user_info WHERE email = ?`;
    con.query(login, [email], (err, results) => {
        if (err) throw err;
        else {
            if (results.length === 0) {
                res.send('error');
            } else {
                const hashedPassword = results[0].password;

                bcrypt.compare(password, hashedPassword, (err, isMatch) => {
                    if (err) throw err;
                    else {
                        if (isMatch) {
                            const user_id_get = 'Select * from user where email = ?'
                            con.query(user_id_get, [email], (err, results) => {
                                if (err) throw err;
                                else {    // Store the user's email in the session
                                    req.session.userid = results[0].user_id;
                                    console.log(req.session.userid)
                                    res.send('success');
                                }
                            })

                        } else {
                            res.send('error');
                        }
                    }
                });
            }
        }
    });
});
app.post('/alogin', (req, res) => {
    const { email, password } = req.body;

    const login = `SELECT * FROM staff_info WHERE email = ?`;
    con.query(login, [email], (err, results) => {
        if (err) throw err;
        else {
            if (results.length === 0) {
                res.send('error');
            } else {
                const hashedPassword = results[0].password;

                bcrypt.compare(password, hashedPassword, (err, isMatch) => {
                    if (err) throw err;
                    else {
                        if (isMatch) {
                            const job_get = 'Select job from staff_info where email = ?'
                            con.query(job_get,[email],function(err,results){
                                if (err) throw err;
                                else{
                                    job_staff = results[0].job;
                            
                            const staff_id_get = 'Select * from staff where email = ?'
                            con.query(staff_id_get, [email], (err, results) => {
                                if (err) throw err;
                                else {
                                      // Store the user's email in the session
                                    req.session.staffid = results[0].staff_id;
                                    console.log(req.session.staffid)
                                    res.send(job_staff);
                                }
                            })
                        }})
                        } else {
                            res.send('error');
                        }
                    }
                });
            }
        }
    });
});
app.get('/admin_dashboard', function (req, res) {
    const sql = "SELECT(SELECT COUNT(*) FROM user) AS total_user,(SELECT COUNT(*) FROM book) AS total_book,(SELECT COUNT(*) FROM staff_info WHERE job <> 'Admin') AS total_staff;"
    con.query(sql,function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/admin-dashboard'), { count: result })
    })

})
// app.get('/user', (req, res) => {
//     if(req.session.userid){
//     res.sendFile(path.join(__dirname, '../public/user.html'))
app.get('/user', (req, res) => {
    if(req.session.userid){

        sql = "Select ui.name, s.email from user_info ui Join user u on u.email = ui.email join keeps_track_of k on k.user_id = u.user_id join staff s on k.staff_id = s.staff_id where u.user_id = ?"
        con.query(sql,[req.session.userid],function(err,result){
            if (err) console.log(err);
            else{
                res.render(path.join(__dirname, '../views/user'), { user: result })
            }
        })

}})
// app.get('/admin', (req, res) => {
//     res.sendFile(path.join(__dirname, '../public/admin-dashboard.html'))
// })

app.get('/user_records', function (req, res) {
    const sql = "Select * from user_records_admin"
    con.query(sql, function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/admin_user_records'), { users: result })
    })

})
app.get('/book_records', function (req, res) {
    const sql = "Select * from book_records_admin"
    con.query(sql, function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/admin_book_records'), { book: result })
    })

})
app.get('/ebook_records', function (req, res) {
    const sql = "Select * from ebook_records_admin"
    con.query(sql, function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/admin_ebook_records'), { book: result })
    })

})
app.get('/staff_records', function (req, res) {
    const sql = "Select * from staff_records"
    con.query(sql, function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/admin_staff_records'), { staff: result })
    })

})

app.get('/searching', function (req, res) {
    const name = req.query.name;
    const email = req.query.email;
    const address = req.query.address;


    const sql = "SELECT * FROM user_records_admin where Name LIKE '%" + name + "%' AND Email LIKE '%" + email + "%' AND Address LIKE '%" + address + "%'"
    con.query(sql, [name, email, address], function (err, result) {
        res.send(result);
    })
})
app.get('/searchingstaff', function (req, res) {
    const name = req.query.name;
    const email = req.query.email;
    const job = req.query.job;


    const sql = "SELECT * FROM staff_records where Name LIKE '%" + name + "%' AND Job LIKE '%" + job + "%' AND Email LIKE '%" + email + "%'"
    con.query(sql, [name, job, email], function (err, result) {
        res.send(result);
    })
})

app.get('/ebooksmanager',function(req,res){
    const sql = "Select * from staff_maintains_ebooks where staffid = ?"
    con.query(sql,[req.session.staffid] ,function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/ebooksmanager'), { book: result })
    })
})
app.get('/booksmanager',function(req,res){
    const sql = "Select * from staff_maintains_pbooks where staffid = ?"
    con.query(sql,[req.session.staffid] ,function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/booksmanager'), { book: result })
    })
})
app.get('/searchingbook', function (req, res) {
    const title = req.query.title;
    const author = req.query.author;
    const category = req.query.category;


    const sql = "SELECT * FROM book_records_admin where title LIKE '%" + title + "%' AND author LIKE '%" + author + "%' AND category LIKE '%" + category + "%'"
    con.query(sql, function (err, result) {
        res.send(result);
    })
})
app.get('/searchingebook', function (req, res) {
    const title = req.query.title;
    const author = req.query.author;
    const category = req.query.category;


    const sql = "SELECT * FROM ebook_records_admin where title LIKE '%" + title + "%' AND author LIKE '%" + author + "%' AND category LIKE '%" + category + "%'"
    con.query(sql, function (err, result) {
        res.send(result);
    })
})
app.get('/searchingebookmanager', function (req, res) {
    const title = req.query.title;
    const author = req.query.author;
    const category = req.query.category;
    

    const sql = "SELECT * FROM staff_maintains_ebooks where title LIKE '%" + title + "%' AND author_name LIKE '%" + author + "%' AND category LIKE '%" + category + "%'And staffid='"+req.session.staffid+"'"
    console.log(sql);
    con.query(sql, function (err, result) {
       

        res.send(result);
    })
})
app.get('/searchingrecords', function (req, res) {
    const isbn = req.query.isbn;
    const name = req.query.name;
    const user_id = req.query.user_id;
    

    const sql = "SELECT * FROM staff_user_records where name LIKE '%" + name + "%' AND user_id LIKE '%" + user_id + "%' AND isbn LIKE '%" + isbn + "%'And staff_id='"+req.session.staffid+"'"
    console.log(sql);
    con.query(sql, function (err, result) {
       

        res.send(result);
    })
})
app.get('/searchingbookmanager', function (req, res) {
    const title = req.query.title;
    const author = req.query.author;
    const category = req.query.category;
    

    const sql = "SELECT * FROM staff_maintains_pbooks where title LIKE '%" + title + "%' AND author_name LIKE '%" + author + "%' AND category LIKE '%" + category + "%'And staffid='"+req.session.staffid+"'"
    console.log(sql);
    con.query(sql, function (err, result) {


        res.send(result);
    })
})
app.get('/searchingbooks', function (req, res) {
    const name = req.query.name;
    const genra = req.query.genre;
    const author = req.query.author;
    console.log(name,genra,author);

    const sql = "SELECT * FROM user_books where title LIKE '%" + name + "%' AND Category LIKE '%" + genra + "%' AND author LIKE '%" + author + "%' AND availability = lower('yes')"
    con.query(sql, [name, genra, author], function (err, result) {
        console.log("searching data")
        console.log(result)
        res.send(result);

    })
});
app.get('/searchingebooks', function (req, res) {
    const name = req.query.name;
    const genra = req.query.genre;
    const author = req.query.author;
    console.log(name,genra,author);

    const sql = "SELECT * FROM user_ebooks where title LIKE '%" + name + "%' AND Category LIKE '%" + genra + "%' AND author LIKE '%" + author + "%'"
    con.query(sql, [name, genra, author], function (err, result) {
        console.log("searching data")
        console.log(result)
        res.send(result);

    })
});
app.get('/delete-staffrecord', function (req, res) {
    var staff_id = req.query.staff_id;
    var email = req.query.email;
    console.log(staff_id, email)
    const jobstaff = 'Select job from staff_info where email = ?'
    con.query(jobstaff,[email],function(err,result){
        const results = JSON.parse(JSON.stringify(result));
      console.log(results)
      const job = results[0].job;
      console.log(job);
      if (job == 'Books Manager'){
        const isbnlist = 'Select isbn from maintains where staff_id = ?'
        con.query(isbnlist,[staff_id],function(err,result){
            if (err) console.log(err);
            const results = JSON.parse(JSON.stringify(result));
            if (results.length >0){
                const staff_min = "SELECT s.staff_id FROM staff_info si JOIN staff s ON si.email = s.email LEFT JOIN maintains m ON s.staff_id = m.staff_id WHERE si.job = 'Books Manager' GROUP BY s.staff_id ORDER BY COUNT(m.isbn) ASC LIMIT 1;"
                con.query(staff_min,function(err,result){
                    if (err) console.log(err);
                    const x = JSON.parse(JSON.stringify(result));
                    const new_staff = x[0].staff_id;
                    console.log(new_staff);
                    if(x.length>0 && new_staff!=staff_id){
                    
                    console.log(new_staff);
                    const new_maintains = 'Update maintains set staff_id = ? where staff_id =?'
                    con.query(new_maintains,[new_staff,staff_id],function(err,result){
                        if (err) console.log(err);
                        const works_for = "DELETE from works_for where worker_staff_id=?"
                        con.query(works_for, [staff_id], function (err, result) {
                            if (err) console.log(err);
                            const staff = "DELETE from staff where staff_id=?"
                            con.query(staff, [staff_id], function (err, result) {
                                if (err) console.log(err);
                                const staff_info = "DELETE from staff_info where email=?"
                                con.query(staff_info, [email], function (err, result) {
                                    if (err) console.log(err);
                                    res.send('Record with staff id =' + staff_id + ' is deleted from database')
                                })
                            })
                        })
                    })
                    
           
         }
        else{
            res.send("books manager")

        }})}else{
            const works_for = "DELETE from works_for where worker_staff_id=?"
                        con.query(works_for, [staff_id], function (err, result) {
                            if (err) console.log(err);
                            const staff = "DELETE from staff where staff_id=?"
                            con.query(staff, [staff_id], function (err, result) {
                                if (err) console.log(err);
                                const staff_info = "DELETE from staff_info where email=?"
                                con.query(staff_info, [email], function (err, result) {
                                    if (err) console.log(err);
                                    res.send('Record with staff id =' + staff_id + ' is deleted from database')
                                })
                            })
                        })
        }
          })
      
      

      }
      else if(job == 'Ebooks Manager'){ 
       
        const isbnlist = 'Select isbn from maintains where staff_id = ?'
        con.query(isbnlist,[staff_id],function(err,result){
            const results = JSON.parse(JSON.stringify(result));
            if (results.length >0){
                const staff_min = "SELECT s.staff_id FROM staff_info si JOIN staff s ON si.email = s.email LEFT JOIN maintains m ON s.staff_id = m.staff_id WHERE si.job = 'Ebooks Manager' GROUP BY s.staff_id ORDER BY COUNT(m.isbn) ASC LIMIT 1;"
                con.query(staff_min,function(err,result){
                    const x = JSON.parse(JSON.stringify(result));
                    const new_staff = x[0].staff_id;
                    
                    console.log(new_staff);
                    if(x.length>0 && new_staff!=staff_id){
                    
                    console.log(new_staff);
                    const new_maintains = 'Update maintains set staff_id = ? where staff_id =?'
                    con.query(new_maintains,[new_staff,staff_id],function(err,result){
                        if (err) console.log(err);
                        const works_for = "DELETE from works_for where worker_staff_id=?"
                        con.query(works_for, [staff_id], function (err, result) {
                            if (err) console.log(err);
                            const staff = "DELETE from staff where staff_id=?"
                            con.query(staff, [staff_id], function (err, result) {
                                if (err) console.log(err);
                                const staff_info = "DELETE from staff_info where email=?"
                                con.query(staff_info, [email], function (err, result) {
                                    if (err) console.log(err);
                                    res.send('Record with staff id =' + staff_id + ' is deleted from database')
                                })
                            })
                        })
                    })
                    
           
         }
        else{
            res.send("ebooks manager")

        }})}else{
            const works_for = "DELETE from works_for where worker_staff_id=?"
                        con.query(works_for, [staff_id], function (err, result) {
                            if (err) console.log(err);
                            const staff = "DELETE from staff where staff_id=?"
                            con.query(staff, [staff_id], function (err, result) {
                                if (err) console.log(err);
                                const staff_info = "DELETE from staff_info where email=?"
                                con.query(staff_info, [email], function (err, result) {
                                    if (err) console.log(err);
                                    res.send(staff_id)
                                    // res.send('Record with staff id =' + staff_id + ' is deleted from database')
                                })
                            })
                        })
        }
          })
      

      }
      
      else if(job == 'Records Manager'){ 
        
        const userlist = 'Select user_id from keeps_track_of where staff_id = ?'
        con.query(userlist,[staff_id],function(err,result){
            const results = JSON.parse(JSON.stringify(result));
            if (results.length >0){
                const staff_min = "SELECT s.staff_id FROM staff_info si JOIN staff s ON si.email = s.email LEFT JOIN keeps_track_of k ON s.staff_id = k.staff_id WHERE si.job = 'Records Manager' GROUP BY s.staff_id ORDER BY COUNT(k.user_id) ASC LIMIT 1;"
                con.query(staff_min,function(err,result){
                    const x = JSON.parse(JSON.stringify(result));
                    const new_staff = x[0].staff_id;
                    console.log(new_staff);
                    if(x.length>0 && new_staff!=staff_id){
                    
                    console.log(new_staff);
                    const new_keeps_track = 'Update keeps_track_of set staff_id = ? where staff_id =?'
                    con.query(new_keeps_track,[new_staff,staff_id],function(err,result){
                        if (err) console.log(err);
                        const works_for = "DELETE from works_for where worker_staff_id=?"
                        con.query(works_for, [staff_id], function (err, result) {
                            if (err) console.log(err);
                            const staff = "DELETE from staff where staff_id=?"
                            con.query(staff, [staff_id], function (err, result) {
                                if (err) console.log(err);
                                const staff_info = "DELETE from staff_info where email=?"
                                con.query(staff_info, [email], function (err, result) {
                                    if (err) console.log(err);
                                    res.send('Record with staff id =' + staff_id + ' is deleted from database')
                                })
                            })
                        })
                    })
                    
           
         }
        else{
            res.send("records manager")

        }})}else{
            const works_for = "DELETE from works_for where worker_staff_id=?"
                        con.query(works_for, [staff_id], function (err, result) {
                            if (err) console.log(err);
                            const staff = "DELETE from staff where staff_id=?"
                            con.query(staff, [staff_id], function (err, result) {
                                if (err) console.log(err);
                                const staff_info = "DELETE from staff_info where email=?"
                                con.query(staff_info, [email], function (err, result) {
                                    if (err) console.log(err);
                                    res.send('Record with staff id =' + staff_id + ' is deleted from database')
                                })
                            })
                        })
        }
          })
      

      }
   
    // const works_for = "DELETE from works_for where worker_staff_id=?"
    // con.query(works_for, [staff_id], function (err, result) {
    //     if (err) console.log(err);
    //     const staff = "DELETE from staff where staff_id=?"
    //     con.query(staff, [staff_id], function (err, result) {
    //         if (err) console.log(err);
    //         const staff_info = "DELETE from staff_info where email=?"
    //         con.query(staff_info, [email], function (err, result) {
    //             if (err) console.log(err);
    //             res.send('Record with staff id =' + staff_id + ' is deleted from database')
    //         })
    //     })
    // })
}) });

app.post('/addstaff', function (req, res) {
    const { staff_id, name, email, password, address, job } = req.body;
    bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(password, salt, function (err, hash) {
        const staff_info = "Insert Into staff_info values(?,?,?,?,?)"
        con.query(staff_info, [email, job, name, address, hash], function (error, result) {
            if (error) console.log(error);
            const staff = 'INSERT INTO staff values(?,?)'
            con.query(staff, [staff_id, email], function (error, result) {
                if (error) console.log(error);
                const managerdb = "SELECT worker_staff_id FROM works_for WHERE manager_staff_id IS NULL;"
                con.query(managerdb, function (err, result) {
                    const results = JSON.parse(JSON.stringify(result));
                    const manager = results[0].worker_staff_id;
                    const works_for = 'Insert into works_for values(?,?)'
                    con.query(works_for, [staff_id, manager], function (error, result) {
                        if (error) console.log(error);
                        res.redirect('/staff_records')
                    })
                })

            })

        }
        )
    });
})});


app.get('/updatestaff', function (req, res) {
    const staff_id = req.query.staff_id;
    const sql = "Select * from staff_info where email=(Select email from staff where staff_id=?)"
    con.query(sql, [staff_id], function (err, result) {
        if (err) console.log(err);
        console.log(result)
        result[0].staffid = staff_id
        res.send(result)
    })

});
app.post('/updatestaff', function (req, res) {
    const staff_id = req.body.staff_id
    const name = req.body.name
    const emailadd = req.body.email
    const address = req.body.address
    // const job = req.body.job
    console.log(name)
    const emailcheck = 'Select email from staff where staff_id = ?'
    con.query(emailcheck, [staff_id], function (err, result) {
        if (err) console.log(err);
        const results = JSON.parse(JSON.stringify(result));
        console.log(results);
        const emaildb = results[0].email
        if (emailadd == emaildb) {
            const staff_info = "UPDATE staff_info set name = ? , address = ? where email =(Select email from staff where staff_id = ?)"
            con.query(staff_info, [name, address, staff_id], function (err, result) {
                if (err) console.log(err);
                res.redirect('/staff_records')

            })
        }
        else {
            const staff_info = "UPDATE staff_info set name = ? , address = ? where email =(Select email from staff where staff_id = ?)"
            con.query(staff_info, [name, address, staff_id], function (err, result) {
                if (err) console.log(err);
            null_email = "Update staff set email = null where staff_id = ?"
            con.query(null_email, [staff_id], function (err, result) {
                update_staffinfo = "Update staff_info set email = ? where email = ?"
                con.query(update_staffinfo, [emailadd, emaildb], function (err, result) {
                    if (err) console.log(err);
                    const updatestaff = 'Update staff set email = ? where staff_id = ?'
                    con.query(updatestaff, [emailadd, staff_id], function (err, result) {
                        if (err) console.log(err);
                        res.redirect('/staff_records')
                    })

                })
            })})
        }

    })
});

                                //  Books

//add books and ebooks admin
app.get('/addbook', function (req, res) {
    var sql = "Select staff_id from staff where email in (Select email from staff_info where job = 'Books Manager');"
    con.query(sql,  function (err, result) {
        
        if (err) console.log(err);
        
        res.send(result)
    })

})
app.get('/addebook', function (req, res) {
    var sql = "Select staff_id from staff where email in (Select email from staff_info where job = 'Ebooks Manager');"
    con.query(sql,  function (err, result) {
        
        if (err) console.log(err);
        
        res.send(result)
    })

})
app.post('/addbook',function(req,res){
    const{isbn,title,author,category,price,publisher,year,condition,staffmem}=req.body;
    const book_info = 'Insert into book_info values(?,?,?)'
    con.query(book_info,[title,category,price],function(err,result){
        if (err) console.log(err);
        const book = 'Insert into book values (?,?)'
        con.query(book,[isbn,title],function(err,result){
            if (err) console.log(err);
            const pb = 'Insert into physical_book values(?,?,?)'
            con.query(pb,[isbn,condition,"Yes"],function(err,result){
                if (err) console.log(err);
                const book_author = 'Insert into book_author values(?,?)'
                con.query(book_author,[isbn,author],function(err,result){
                    if (err) console.log(err);
                    const publisher_check = "select publisher_name from publisher where publisher_name = ?;"
                    con.query(publisher_check,[publisher],function(err,result){
                        if (result.length == 0){
                            const book_publisher = 'Insert into publisher(publisher_name) values(?)'
                            con.query(book_publisher,[publisher],function(err,result){
                                if (err) console.log(err);})
                        }

                    
                   
                        const getpublisherID = 'Select publisher_id from publisher where publisher_name = ?'
                        con.query(getpublisherID,[publisher],function(err,result){
                            console.log(result);
                            const results =JSON.parse(JSON.stringify(result));
                            console.log(results);
                            publisherr_id =  results[0].publisher_id;
                            const book_publish = 'Insert into publishes values(?,?,?)'
                            con.query(book_publish,[isbn,publisherr_id,year],function(err,result){
                                if (err) console.log(err);
                                const staffmaintains = 'Insert into maintains values(?,?);'
                                con.query(staffmaintains,[isbn,staffmem],function(err,result){
                                    if (err) console.log(err);
                                    res.redirect('/book_records')
                                })
                        
                            })
                        })
                    })
                    })
                })
            })
        })
    })

app.post('/addebook',function(req,res){
    const{isbn,title,author,category,price,publisher,year,filesize,fileformat,staffmem}=req.body;
    const book_info = 'Insert into book_info values(?,?,?)'
    con.query(book_info,[title,category,price],function(err,result){
        if (err) console.log(err);
        const book = 'Insert into book values (?,?)'
        con.query(book,[isbn,title],function(err,result){
            if (err) console.log(err);
            const pb = 'Insert into ebook values(?,?,?)'
            con.query(pb,[isbn,filesize,fileformat],function(err,result){
                if (err) console.log(err);
                const book_author = 'Insert into book_author values(?,?)'
                con.query(book_author,[isbn,author],function(err,result){
                    if (err) console.log(err);
                    const publisher_check = "select publisher_name from publisher where publisher_name = ?;"
                    con.query(publisher_check,[publisher],function(err,result){
                        if (result.length == 0){
                            const book_publisher = 'Insert into publisher(publisher_name) values(?)'
                            con.query(book_publisher,[publisher],function(err,result){
                                if (err) console.log(err);})
                        }
                        const getpublisherID = 'Select publisher_id from publisher where publisher_name = ?'
                        con.query(getpublisherID,[publisher],function(err,result){
                            console.log(result);
                            const results =JSON.parse(JSON.stringify(result));
                            console.log(results);
                            publisherr_id =  results[0].publisher_id;
                            const book_publish = 'Insert into publishes values(?,?,?)'
                            con.query(book_publish,[isbn,publisherr_id,year],function(err,result){
                                if (err) console.log(err);
                                const staffmaintains = 'Insert into maintains values(?,?);'
                                con.query(staffmaintains,[isbn,staffmem],function(err,result){
                                    if (err) console.log(err);
                                    res.redirect('/ebook_records')
                                })
                                
                            })
                        })
                       
                    })
                })
            })
        })
    }) 
})

//add books and ebooks for managers
app.post('/addebook_manager',function(req,res){
    const{isbn,title,author,category,price,publisher,year,filesize,fileformat}=req.body;
    const book_info = 'Insert into book_info values(?,?,?)'
    con.query(book_info,[title,category,price],function(err,result){
        if (err) console.log(err);
        const book = 'Insert into book values (?,?)'
        con.query(book,[isbn,title],function(err,result){
            if (err) console.log(err);
            const pb = 'Insert into ebook values(?,?,?)'
            con.query(pb,[isbn,filesize,fileformat],function(err,result){
                if (err) console.log(err);
                const book_author = 'Insert into book_author values(?,?)'
                con.query(book_author,[isbn,author],function(err,result){
                    if (err) console.log(err);
                    const publisher_check = "select publisher_name from publisher where publisher_name = ?;"
                    con.query(publisher_check,[publisher],function(err,result){
                        if (result.length == 0){
                            const book_publisher = 'Insert into publisher(publisher_name) values(?)'
                            con.query(book_publisher,[publisher],function(err,result){
                                if (err) console.log(err);})
                        }
                        const getpublisherID = 'Select publisher_id from publisher where publisher_name = ?'
                        con.query(getpublisherID,[publisher],function(err,result){
                            console.log(result);
                            const results =JSON.parse(JSON.stringify(result));
                            console.log(results);
                            publisherr_id =  results[0].publisher_id;
                            const book_publish = 'Insert into publishes values(?,?,?)'
                            con.query(book_publish,[isbn,publisherr_id,year],function(err,result){
                                if (err) console.log(err);
                                const staffmaintains = 'Insert into maintains values(?,?);'
                                con.query(staffmaintains,[isbn,req.session.staffid],function(err,result){
                                    if (err) console.log(err);
                                    res.redirect('/ebooksmanager')
                                })
                                
                            })
                        })
                       
                    })
                })
            })
        })
    }) 
})
app.post('/addbook_manager',function(req,res){
    const{isbn,title,author,category,price,publisher,year,condition}=req.body;
    const book_info = 'Insert into book_info values(?,?,?)'
    con.query(book_info,[title,category,price],function(err,result){
        if (err) console.log(err);
        const book = 'Insert into book values (?,?)'
        con.query(book,[isbn,title],function(err,result){
            if (err) console.log(err);
            const pb = 'Insert into physical_book values(?,?,?)'
            con.query(pb,[isbn,condition,'Yes'],function(err,result){
                if (err) console.log(err);
                const book_author = 'Insert into book_author values(?,?)'
                con.query(book_author,[isbn,author],function(err,result){
                    if (err) console.log(err);
                    const publisher_check = "select publisher_name from publisher where publisher_name = ?;"
                    con.query(publisher_check,[publisher],function(err,result){
                        if (result.length == 0){
                            const book_publisher = 'Insert into publisher(publisher_name) values(?)'
                            con.query(book_publisher,[publisher],function(err,result){
                                if (err) console.log(err);})
                        }
                        const getpublisherID = 'Select publisher_id from publisher where publisher_name = ?'
                        con.query(getpublisherID,[publisher],function(err,result){
                            console.log(result);
                            const results =JSON.parse(JSON.stringify(result));
                            console.log(results);
                            publisherr_id =  results[0].publisher_id;
                            const book_publish = 'Insert into publishes values(?,?,?)'
                            con.query(book_publish,[isbn,publisherr_id,year],function(err,result){
                                if (err) console.log(err);
                                const staffmaintains = 'Insert into maintains values(?,?);'
                                con.query(staffmaintains,[isbn,req.session.staffid],function(err,result){
                                    if (err) console.log(err);
                                    res.redirect('/booksmanager')
                                })
                                
                            })
                        })
                       
                    })
                })
            })
        })
    }) 
})
//Update books and ebooks
app.get('/updateebook', function (req, res) {
    var isbnn = req.query.isbn;
    var sql = "Select price from book_info where title = (Select title from book where isbn=?);"
    con.query(sql, [isbnn], function (err, result) {
        
        if (err) console.log(err);
        result[0].isbn = isbnn
        res.send(result)
    })

})
app.get('/updatebook', function (req, res) {
    var isbn = req.query.isbn;
    var sql = "Select b.isbn, bi.price, pb.book_condition, pb.availability from book b join book_info bi on b.title = bi.title join physical_book pb on b.isbn = pb.isbn where b.isbn = ?;"
    con.query(sql, [isbn], function (err, result) {
        
        if (err) console.log(err);
        
        res.send(result)
    })

})
app.post('/updatebook',function(req,res){
    const isbn = req.body.isbn;
    const price = req.body.price;
    const availability = req.body.availability;
    const condition = req.body.condition;
    const book_info = 'Update book_info set price = ? where title= (Select title from book where isbn = ?)'
    con.query(book_info,[price,isbn],function(err,result){
        if (err) console.log(err)
        phy_book = 'Update physical_book set book_condition = ?,availability = ? where isbn=? '
        con.query(phy_book,[condition,availability,isbn],function(err,result){
            if (err) console.log(err);
            res.redirect('/book_records')
        })
    })
})
app.post('/updateebook',function(req,res){
    const isbn = req.body.isbn;
    const price = req.body.price;
    
    const book_info = 'Update book_info set price = ? where title= (Select title from book where isbn = ?)'
    con.query(book_info,[price,isbn],function(err,result){
        if (err) console.log(err)
        res.redirect('/ebook_records')
    })
})

//Update Books and ebooks for book manage and ebook manager
app.post('/updateebookmanager',function(req,res){
    const isbn = req.body.isbn;
    const price = req.body.price;
    
    const book_info = 'Update book_info set price = ? where title= (Select title from book where isbn = ?)'
    con.query(book_info,[price,isbn],function(err,result){
        if (err) console.log(err)
        res.redirect('/ebooksmanager')
    })
})

app.post('/updatebookmanager',function(req,res){
    const isbn = req.body.isbn;
    const price = req.body.price;
    const availability = req.body.availability;
    const condition = req.body.condition;
    const book_info = 'Update book_info set price = ? where title= (Select title from book where isbn = ?)'
    con.query(book_info,[price,isbn],function(err,result){
        if (err) console.log(err)
        phy_book = 'Update physical_book set book_condition = ?,availability = ? where isbn=? '
        con.query(phy_book,[condition,availability,isbn],function(err,result){
            if (err) console.log(err);
            res.redirect('/booksmanager')
        })
    })
})

//delete books and ebooks
app.get('/delete-bookrecord', function (req, res) {
    var isbn = req.query.isbn;
    var title = req.query.title;
    var publisher_id = req.query.publisher_id;
    console.log(isbn,title,publisher_id)
    book_borrow_check = 'Select * from borrows where isbn =? '
    con.query(book_borrow_check,[isbn],function(err,result){
        if(result.length == 0 ){
    
    const book_author = "DELETE from book_author where isbn=?"
    con.query(book_author, [isbn], function (err, result) {
        if (err) console.log(err);
        const physical_book = "DELETE from physical_book where isbn=?"
        con.query(physical_book, [isbn], function (err, result) {
            if (err) console.log(err);
            const publishes = "DELETE from publishes where isbn=?"
            con.query(publishes, [isbn], function (err, result) {
                if (err) console.log(err);
                const publisher_check = 'Select * from publishes where publisher_id = ?;'
                con.query(publisher_check,[publisher_id],function(err,result){
                    if (result.length == 0){
                        const publisher = "DELETE from publisher where publisher_id=?"
                        con.query(publisher,[publisher_id],function(err,result){
                        if (err) console.log(err);})

                        }
                
                
                    const maintains = 'Delete from maintains where isbn = ?'
                    con.query(maintains,[isbn],function(err,result){
                    const book = "DELETE from book where isbn=?"
                    con.query(book,[isbn],function(err,result){
                        if (err) console.log(err);
                        const book_info = "DELETE from book_info where title=?"
                        con.query(book_info,[title],function(err,result){
                            if (err) console.log(err);
                            res.send(title + ' is deleted from database')
                        })
                    })
                })})
            })
            })
        })}
    else{
        res.send()
    }})
    });
app.get('/delete-ebookrecord', function (req, res) {
    var isbn = req.query.isbn;
    var title = req.query.title;
    var publisher_id = req.query.publisher_id;
    console.log(isbn,title,publisher_id)
    book_borrow_check = 'Select * from borrows where isbn = ? '
    con.query(book_borrow_check,[isbn],function(err,result){
        if(result.length == 0 ){
    const book_author = "DELETE from book_author where isbn=?"
    con.query(book_author, [isbn], function (err, result) {
        if (err) console.log(err);
        const ebook = "DELETE from ebook where isbn=?"
        con.query(ebook, [isbn], function (err, result) {
            if (err) console.log(err);
            const publishes = "DELETE from publishes where isbn=?"
            con.query(publishes, [isbn], function (err, result) {
                if (err) console.log(err);
                const publisher_check = 'Select * from publishes where publisher_id = ?;'
                con.query(publisher_check,[publisher_id],function(err,result){
                    if (result.length == 0){
                        const publisher = "DELETE from publisher where publisher_id=?"
                        con.query(publisher,[publisher_id],function(err,result){
                        if (err) console.log(err);})

                        }
                
                    const maintains = 'Delete from maintains where isbn = ?'
                    con.query(maintains,[isbn],function(err,result){
                    const book = "DELETE from book where isbn=?"
                    con.query(book,[isbn],function(err,result){
                        if (err) console.log(err);
                        const book_info = "DELETE from book_info where title=?"
                        con.query(book_info,[title],function(err,result){
                            if (err) console.log(err);
                            res.send(title + ' is deleted from database')
                        })
                    })
                })})

            })
        })
    })} else{
        res.send()
    }})
});

//User book page

app.get('/userbooksview', function (req, res) {

    const sql = "SELECT * FROM user_books WHERE availability = 'yes';"
    con.query(sql, function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/userbooks'), { books: result })
    })
});
app.get('/userebookView', function (req, res) {
    
    const sql = "select * from user_ebooks;"
    con.query(sql, function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/userebook'), { books: result })
    })
});


app.post('/upload', upload.single('image'), (req, res) => {
    console.log('hehe')
    if (req.file) {
        booktype = req.query.type;
        
      // Rename the uploaded file to 'abc'
      console.log(req.query.isbn)
      console.log(req.file.destination)
      if (booktype=='book'){
      const newPath = path.join(req.file.destination,'..','public','images','books' ,req.query.isbn+'.jpg');
      console.log(newPath)
      fs.rename(req.file.path, newPath, (error) => {
        if (error) {
          console.error(error);
          res.sendStatus(500);
        } else {
          res.sendStatus(200);
        }
      });
    }
    else if(booktype == 'ebook'){
        const newPath = path.join(req.file.destination,'..','public','images','ebooks' ,req.query.isbn+'.jpg');
        console.log(newPath)
        fs.rename(req.file.path, newPath, (error) => {
            if (error) {
              console.error(error);
              res.sendStatus(500);
            } else {
              res.sendStatus(200);
            }
          });
    }
    } else {
      res.sendStatus(400);
    }

  });
app.post('/uploadpdf', upload.single('file'), (req, res) => {
    
    if (req.file) {
        
        
      // Rename the uploaded file to 'abc'
      console.log(req.query.isbn)
      console.log(req.file.destination)
      
      const newPath = path.join(req.file.destination,'..','public','ebookread' ,req.query.isbn+'.'+req.query.format);
      console.log(newPath)
      fs.rename(req.file.path, newPath, (error) => {
        if (error) {
          console.error(error);
          res.sendStatus(500);
        } else {
          res.sendStatus(200);
        }
      });
    
    } else {
      res.sendStatus(400);
    }

  });
  app.post('/borrowbooks', function (req, res) {
    sql= 'Insert into borrows(user_id,isbn,issue_date,due_date) values(?,?,sysdate(),DATE_ADD(sysdate(), INTERVAL 7 DAY))'
    con.query(sql,[req.session.userid,req.body.isbn],function(err,result){
        if(err) {console.log(err)
            res.send('error')
        }
        else{
        pb = "Update physical_book set availability ='No' where isbn = ?"
        con.query(pb,[req.body.isbn],function(err,result){
            if (err) console.log(err);
            res.send('success')
        })
    }
    })
});
app.get('/recordsmanager', function (req, res) {
    const sql = "Select * from staff_user_records where staff_id = ?"
    con.query(sql, [req.session.staffid],function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/recordsmanager'), { records: result })
    })

})


app.get('/userborrowrecords', function (req, res) {
    const sql = "Select * from user_borrows_books where user_id = ?"
    con.query(sql, [req.session.userid],function (error, result) {
        if (error) throw error;
        console.log(result);
        res.render(path.join(__dirname, '../views/user-borrow-records'), { records: result })
    })

})


app.post('/userreturnbook', function (req, res) {
    console.log(req.body.isbn);
    returnbook = `Update borrows set return_date = sysdate() where user_id=${req.session.userid}`
    console.log(returnbook)
    con.query(returnbook, function (err, result) {
        if (err) {
            console.log(err)
            res.send('error')
        }
        else {
        pb = `Update physical_book set availability = 'yes' where isbn=${req.body.isbn}`
        con.query(pb,function (err, result) {
            if (err) console.log(err);
            else {
                console.log('adan')
                res.redirect('/userborrowrecords');
                // res.redirect('/userborrowrecords')
            }
            
        })
        }
    });
});
  app.listen(4200);





























// const con = require('./config');
// const express = require('express');
// const app = express();
// const path = require('path');
// // con.connect(function(err){
// //     if (err) throw err;
// //     con.query('Select * from booklib',function(errr,res){
// //         if (errr) throw errr;
// //         console.log(res[0]);
// //     })
// // })

// const bodyParser = require('body-parser');
// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: true }));
// app.use(express.static(path.join(__dirname, '../public')));
// app.set('view engine', 'ejs');

// app.get('/', (req, res) => {
//     res.sendFile(path.join(__dirname, '../public/index.html'))
// })
// app.post('/signup', (req, res) => {
//     const { name, password, email, address, tel, rectel } = req.body;
//     const user_info = "INSERT INTO user_info(name,email,password,address) VALUES(?,?,?,?)";
//     // const telno = "INSERT INTO booklib(isbn,title,author) VALUES(?,?,?)";
//     con.query(user_info, [name, email, password, address], function (error1, result1) {
//         if (error1) throw error1;
//         const user = "INSERT INTO user(email) VALUES('" + email + "')";
//         con.query(user, function (error2, result2) {
//             if (error2) throw error2;
//             con.query('SELECT user_id from user where email = ?', [email], function (error3, result3) {
//                 if (error3) throw error3;
//                 results = JSON.parse(JSON.stringify(result3));
//                 uid = results[0].user_id;

//                 const telno = "INSERT INTO user_telno(user_id,telno) VALUES(?,?)";
//                 con.query(telno, [uid, tel], function (error4, result4) {
//                     if (error4) throw error4;
//                     else {
//                         if (rectel == '') { res.redirect('/user') }
//                         else {
//                             const recttelquery = "INSERT INTO user_telno(user_id,telno) VALUES(?,?)";
//                             con.query(recttelquery, [uid, rectel], function (error5, result5) {
//                                 if (error4) throw error5;
//                                 res.redirect('/user')
//                             })
//                         }
//                     }
//                 });
//             });
//         })
//     })
// });
// app.post('/login', (req, res) => {
//     const { email, password } = req.body;
//     const login = `SELECT * FROM user_info WHERE email = ? AND password = ?`;
//     con.query(login, [email, password], (err, results) => {
//         if (err) throw err;
//         else {
//             if (results.length === 0) {
//                 res.send('error');
//             }
//             else {
//                 res.send('success')
//             }
//         }
//     });
// });
// app.post('/alogin', (req, res) => {
//     const { email, password } = req.body;
//     console.log(email,password);
//     const login = `SELECT * FROM staff_info WHERE email = ? AND password = ?`;
//     con.query(login, [email, password], (err, results) => {
//         if (err) throw err;
//         else {
//             if (results.length === 0) {
//                 res.send('error')    
//             }
//             else {
//                 res.send('success')
//             }
//         }
//     });
// });
// app.get('/user', (req, res) => {
//     res.sendFile(path.join(__dirname, '../public/user.html'))
// })
// app.get('/admin', (req, res) => {
//     res.sendFile(path.join(__dirname, '../public/admin.html'))
// })

// app.get('/user_records', function (req, res) {
//     const sql = "Select * from user_records_admin"
//     con.query(sql, function (error, result) {
//         if (error) throw error;
//         console.log(result);
//         res.render(path.join(__dirname, '../views/user_records'), { users: result })
//     })

// })
// app.get('/staff_records', function (req, res) {
//     const sql = "Select * from staff_records"
//     con.query(sql, function (error, result) {
//         if (error) throw error;
//         console.log(result);
//         res.render(path.join(__dirname, '../views/staff_records'), { staff: result })
//     })

// })

// app.get('/searching', function (req, res) {
//     const name = req.query.name;
//     const email = req.query.email;
//     const address = req.query.address;


//     const sql = "SELECT * FROM user_records_admin where Name LIKE '%" + name + "%' AND Email LIKE '%" + email + "%' AND Address LIKE '%" + address + "%'"
//     con.query(sql, [name, email, address], function (err, result) {
//         res.send(result);
//     })
// })
// app.get('/searchingstaff', function (req, res) {
//     const name = req.query.name;
//     const email = req.query.email;
//     const job = req.query.job;


//     const sql = "SELECT * FROM staff_records where Name LIKE '%" + name + "%' AND Job LIKE '%" + job + "%' AND Email LIKE '%" + email + "%'"
//     con.query(sql, [name, job, email], function (err, result) {
//         res.send(result);
//     })
// })
// app.get('/delete-staffrecord', function (req, res) {
//     var staff_id = req.query.staff_id;
//     var email = req.query.email;
//     console.log(staff_id, email)

//     const works_for = "DELETE from works_for where worker_staff_id=?"
//     con.query(works_for, [staff_id], function (err, result) {
//         if (err) console.log(err);
//         // res.send('Record with staff id =' + staff_id + ' is deleted from database')
//         const staff = "DELETE from staff where staff_id=?"
//         con.query(staff, [staff_id], function (err, result) {
//             if (err) console.log(err);
//             const staff_info = "DELETE from staff_info where email=?"
//             con.query(staff_info, [email], function (err, result) {
//                 if (err) console.log(err);
//                 res.send('Record with staff id =' + staff_id + ' is deleted from database')
//             })
//         })
//     })
// });
// app.post('/addstaff', function (req, res) {
//     const { staff_id, name, email, password, address, job} = req.body;
//     console.log(name, staff_id)
//     const staff_info = "Insert Into staff_info values(?,?,?,?,?)"
//     con.query(staff_info, [email, job, name, address, password], function (error, result) {
//         if (error) console.log(error);
//         const staff = 'INSERT INTO staff values(?,?)'
//         con.query(staff, [staff_id, email], function (error, result) {
//             if (error) console.log(error);
//             const managerdb = "SELECT worker_staff_id FROM works_for WHERE manager_staff_id IS NULL;"
//             con.query(managerdb,function(err,result){
//                 const results = JSON.parse(JSON.stringify(result));
//                 const manager = results[0].worker_staff_id;
//                 const works_for = 'Insert into works_for values(?,?)'
//                 con.query(works_for, [staff_id,manager], function (error, result) {
//                 if (error) console.log(error);
//                 res.redirect('/staff_records')
//             })
//             })
            
//         })

//     }
//     )
// });

// app.get('/updatestaff',function(req,res){
//     var staff_id = req.query.staff_id;
//     var sql = "Select * from staff_info where email=(Select email from staff where staff_id=?)"
//     con.query(sql, [staff_id], function (err, result) {
//         if (err) console.log(err);
//         console.log(result)
//         result[0].staffid = staff_id
//         res.send(result)    
//     })

// })

// app.post('/updatestaff', function (req, res) {
//         const staff_id = req.body.staff_id
//         const name = req.body.name
//         const emailadd = req.body.email
//         const address = req.body.address
//         const job = req.body.job
//         console.log(name)
//         const emailcheck = 'Select email from staff where staff_id = ?'
//         con.query(emailcheck, [staff_id], function (err, result) {
//             if (err) console.log(err);
//             const results = JSON.parse(JSON.stringify(result));
//             console.log(results);
//             const emaildb = results[0].email
//             if (emailadd == emaildb) {
//                 const staff_info = "UPDATE staff_info set name = ? , address = ?, job=? where email =(Select email from staff where staff_id = ?)"
//                 con.query(staff_info, [name, address, job, staff_id], function (err, result) {
//                     if (err) console.log(err);
//                     res.redirect('/staff_records')

//                 })
//             }
//             else{
//                 null_email = "Update staff set email = null where staff_id = ?"
//                 con.query(null_email,[staff_id],function(err,result){
//                     update_staffinfo = "Update staff_info set email = ? where email = ?"
//                     con.query(update_staffinfo,[emailadd,emaildb],function(err,result){
//                         if (err) console.log(err);
//                         const updatestaff = 'Update staff set email = ? where staff_id = ?'
//                         con.query(updatestaff,[emailadd,staff_id],function(err,result){
//                             if (err) console.log(err);
//                             res.redirect('/staff_records')
//                         })

//                     })
//                 })
//             }

//         })
// })

// app.get('/userbooksview', function (req, res) {
    
//     const sql = "select * from user_books"
//     con.query(sql, function (error, result) {
//         if (error) throw error;
//         console.log(result);
//         res.render(path.join(__dirname, '../views/book'), { books: result })
//     })
// });

// app.listen(4200);