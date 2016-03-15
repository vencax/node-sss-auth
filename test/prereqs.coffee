
should = require 'should'
request = require 'request'

module.exports = (ctx) ->

  addr = ctx.baseurl

  describe "prerequsities", ->

    sauron =
      username: 'sauron'
      name: 'Wizard Sauron'
      email: 'jdfsk@dasda.cz'
      password: 'fkdjsfjs'
      gid: 2

    it "must create groups", (done)->
      ctx.GMngmt.create {name: 'admins'}, (err, admins)->
        return done err if err
        ctx.GMngmt.create {name: 'regulars'}, (err, regulars)->
          return done err if err
          done()

    admin =
      username: 'saruman'
      name: 'Wizard Saruman'
      email: 'jdfsk@dasda.cz'
      password: 'fkdjsfjs'
      gid: 1
    ctx.adminuser = admin

    it "must create an admin", (done)->
      ctx.Mngmt.create admin, (err, user)->
        return done err if err
        ctx.adminuser.id = user.id
        done()

    newReg =
      username: 'newreg'
      name: 'newly registered'
      email: 'newreg@jfdksfljs.cz'
      password: 'newregpwd'

    it "must register a new user", (done)->
      request
        url: "#{addr}/register"
        body: newReg
        json: true
        method: 'post'
      , (err, res, body) ->
        return done(err) if err
        res.statusCode.should.eql 201
        console.log ctx.sentemails
        ctx.sentemails.length.should.eql 1
        done()
