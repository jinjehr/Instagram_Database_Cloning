/*
First install the packages with these commands in your terminal:
npm install mysql
npm install @faker-js/faker
*/

/* Insert 500 Users by using faker*/
var mysql = require('mysql2');
var { faker } = require('@faker-js/faker'); 
 
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'testFaker'
});
 
var data = [];
for(var i = 0; i < 500; i++){
    data.push([
        faker.internet.email(),
        faker.date.past()
    ]);
}
 
var q = 'INSERT INTO users (email, created_at) VALUES ?';
 
connection.query(q, [data], function(err, result) {
  console.log(err);
  console.log(result);
});
 
connection.end();
