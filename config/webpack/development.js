var path = require('path')
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
environment.config.devServer.watchContentBase = true
environment.config.devServer.contentBase = [
  path.join(__dirname, '../../app/views'),
  path.join(__dirname, '../../app/helpers'),
  path.join(__dirname, '../../app/reflexes')
]

module.exports = environment.toWebpackConfig()
