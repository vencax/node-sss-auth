crypto = require('crypto')

module.exports = (db) ->

  _createPassword = (passwd)->
    return crypto.createHmac('sha256', passwd).digest('hex')

  createPasswordHash: _createPassword

  find: (body, done) ->
    cond = []
    if body.username
      cond.push({username: body.username})
    if body.email
      cond.push({email: body.email})

    db.models.user.find
      where: $or: cond
    .then (found) ->
      return done(null, found)
    .catch (err) ->
      done(err)

  build: (props) ->
    if 'password' of props
      props.password = _createPassword(props.password)
    db.models.user.build props

  save: (user, done) ->
    user.save().then (saved) ->
      return done(null, user)
    .catch (err) ->
      done(err)

  validPassword: (user, passwd) ->
    user.password == _createPassword(passwd)

  delete: (user, done)->
    user.destroy().then ()->
      done(null, 'deleted')
    .catch (err) ->
      done(err)
