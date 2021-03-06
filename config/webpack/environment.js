const { environment } = require('@rails/webpacker')

// const webpack = require('webpack')
// environment.plugins.append(
//   'Provide',
//   new webpack.ProvidePlugin({
//     ApplicationController: ['../application_controller', 'default']
//   })
// )

const sassLoader = environment.loaders.get('sass')
const sassLoaderConfig = sassLoader.use.find(function (element) {
  return element.loader == 'sass-loader'
})

const options = sassLoaderConfig.options
options.implementation = require('sass')

function hotfixPostcssLoaderConfig (subloader) {
  const subloaderName = subloader.loader
  if (subloaderName === 'postcss-loader') {
    subloader.options.postcssOptions = subloader.options.config
    delete subloader.options.config
  }
}

environment.loaders.keys().forEach(loaderName => {
  const loader = environment.loaders.get(loaderName)
  loader.use.forEach(hotfixPostcssLoaderConfig)
})

module.exports = environment
