SPAAuth = require('spa-auth')
Userman = require('basic-userman')
express = require('express')
bodyParser = require('body-parser')
cors = require('cors')
Manip = require('./usermanip')

module.exports = (db, sendMail)->

  # create user manipulator
  nassaManip = Manip(db)

  mainApp = express()
  mainApp.use(cors({maxAge: 86400}))

  authApp = express()
  SPAAuth(authApp, nassaManip, bodyParser, sendMail)
  mainApp.use('/', authApp)

  # create management app
  UMngmt = Userman(db)
  managementApp = UMngmt.app
  # add it to main app
  mainApp.use('/userman', managementApp)

  return mainApp
