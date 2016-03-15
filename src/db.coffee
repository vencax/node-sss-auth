Sequelize = require('sequelize')

url = process.env.DATABASE_URL || 'sqlite:'
opts = {}
if (process.env.NODE_ENV || 'production') == "production"
  opts.logging = false
if url.indexOf('sqlite:') >= 0
  opts.dialect = 'sqlite'
  if url.length > 8
    opts.storage = url.slice(9)
console.log("## DB: #{url}")
sequelize = new Sequelize(url, opts)

module.exports = (cb) ->

  require('basic-userman/models')(sequelize, Sequelize)

  sequelize.sync({ logging: console.log })
  .then () ->
    cb(null, sequelize)
  .catch (err) ->
    cb('Unable to sync database: ' + err)
