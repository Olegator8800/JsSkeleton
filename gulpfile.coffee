gulpHelp = require 'gulp-help'

gulp = gulpHelp require 'gulp'
rjs = require 'gulp-requirejs'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
rimraf = require 'gulp-rimraf'
livereload = require 'gulp-livereload'


config = require './config.coffee'

includeRequirejsConfig = ->
    requireConfigPath = config.path.require_config
    cacheKey = require.resolve requireConfigPath

    delete require.cache[cacheKey]

    requireConfig = require requireConfigPath

    requireConfig['baseUrl'] ?= config.path.temporary
    requireConfig['out'] ?= config.path.target_name
    requireConfig

gulp.task 'livereload', 'Starl livereload server', ->
    livereloadConfig = config.livereload

    livereloadConfig['basePath'] ?= "./#{config.path.target_path}"
    livereloadConfig['start'] ?= on

    livereload.listen livereloadConfig

gulp.task 'watch', 'Watch for changes in source files', ['livereload'], ->
    gulp.watch config.path.src, ['build']

gulp.task 'build', 'Build project files', ['coffee'], ->
    requireConfig = do includeRequirejsConfig

    rjs requireConfig
        .pipe uglify()
        .pipe gulp.dest config.path.target_path
        .pipe do livereload

    gulp.src config.path.temporary, read: no
        .pipe do rimraf

gulp.task 'coffee', 'Compile coffee scripts', ->
    gulp.src config.path.src
        .pipe do coffee
        .pipe gulp.dest config.path.temporary

gulp.task 'default', 'Default task start watching changes for source files', ['build', 'watch'], ->
