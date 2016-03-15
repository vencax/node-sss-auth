
should = require('should')
http = require('http')
request = require('request').defaults({timeout: 5000})
fs = require('fs')
express = require('express')

process.env.SERVER_SECRET = 'fhdsakjhfkjal'
process.env.ADMINS_GID = 1
process.env.EMAIL_TRANSPORTER_USER = 'pipin@shire.nz'
process.env.CURRENCY='CZK'
process.env.BANK_ACCOUNT='11112222333/1234'
# process.env.DATABASE_URL = 'sqlite://db.sqlite'

ctx =
  port: process.env.PORT || 3333
  sentemails: []
sendMail = (mail, cb) ->
  ctx.sentemails.push mail
  cb()

# entry ...
describe "app", ->

  InitDB = require('../src/db')
  App = require('../src/index')

  before (done) ->

    InitDB (err, db)->
      return done(err) if err

      app = App(db, sendMail)

      # create manipulator (just for test data creation)
      Userman = require('basic-userman')
      Mngmt = Userman(db)
      ctx.Mngmt = Mngmt.UserManip
      ctx.GMngmt = Mngmt.GroupManip

      ctx.server = app.listen ctx.port, (err) ->
        return done(err) if err
        done()

      ctx.app = app

  after (done) ->
    ctx.server.close()
    done()

  it "should exist", (done) ->
    should.exist ctx.app
    done()

  # run the rest of tests
  ctx.baseurl = "http://localhost:#{ctx.port}"

  submodules = [
    './prereqs'
  ]
  for i in submodules
    E = require(i)
    E(ctx)
