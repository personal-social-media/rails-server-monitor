const { merge } = require('webpack-merge');
const webpack = require('webpack');
const { webpackConfig } = require('@rails/webpacker');

module.exports = merge(webpackConfig, {
  plugins: [
    new webpack.ProvidePlugin({
      process: 'process/browser',
    }),
  ],
  resolve: {
    alias: {
      process: "process/browser"
    },
  }
})
