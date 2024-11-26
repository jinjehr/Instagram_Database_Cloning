var mysql = require('mysql');
var faker = require('faker');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'jinjehr',
  database : 'insta_cloning'
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


#Sample_queries_with_faker
INSERT INTO users (email) VALUES('Katie34@yahoo.com'), ('Tunde@gmail.com');

SELECT * FROM users;

var q = 'SELECT * FROM users ';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});

var q = 'SELECT COUNT(*) AS total FROM users ';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results[0].total);
});

var q = 'INSERT INTO users (email) VALUES ("rusty_the_dog@gmail.com")';
 
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});

#Easier_approach_that_allows_dynamic_data
var person = {
    email: faker.internet.email(),
    created_at: faker.date.past()
};
 
var end_result = connection.query('INSERT INTO users SET ?', person, function(err, result) {
  if (err) throw err;
  console.log(result);
});
