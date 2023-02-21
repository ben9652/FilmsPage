const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: [
    'vuetify'
  ],
  configureWebpack: {
    resolve: {
      fallback: {
        crypto: require.resolve("crypto-browserify"),
        stream: require.resolve("stream-browserify"),
        timers: require.resolve("timers-browserify"),
        zlib: require.resolve("browserify-zlib"),
        url: false
      }
    }
  },
  devServer: {
    port: 80,
    host: '0.0.0.0'
  }
})
