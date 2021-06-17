process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const { merge } = require('@rails/webpacker')

const webpackConfig = require('./base')

const chokidar = require('chokidar')

const customConfig = (server) => {
  chokidar
    .watch(['config/locales/**/*.yml', 'app/views/**/*.html.erb', 'app/javascripts/**/*.scss'])
    .on('change', () => server.sockWrite(server.sockets, 'content-changed'))
}

module.exports = merge(webpackConfig, customConfig)