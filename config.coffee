module.exports =
    path:
        src: './app/**/*.coffee'
        temporary: 'tmp/'
        target_path: 'dist'
        target_name: 'main.js'
        require_config: './app/require.config.coffee'
    livereload:
        start: on
        quiet: off
        port: 1234
        host: 'localhost'
