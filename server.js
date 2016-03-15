
require('coffee-script/register');
var port = process.env.PORT || 3000;
var DB = require('./src/db');
var App = require('./src/index');

var sendMail = null;

if(process.env.SENDGRID_USERNAME) {
  var sendgrid  = require('sendgrid')(
    process.env.SENDGRID_USERNAME,
    process.env.SENDGRID_PASSWORD
  );
  sendMail = function(data, cb) {
    sendgrid.send(data, cb);
  };
} else {
  sendMail = function sendMail(mail, done) {
    console.log(mail);
    done();
  };
}

DB(function(err, db) {
  if(err) {
    return console.log(err);
  }
  App(db, sendMail).listen(port, function() {
    console.log('gimly pulls his axe into ' + port);
  });
});
