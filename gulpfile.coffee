gulpHelp = require 'gulp-help'
gulp = gulpHelp require 'gulp'

rjs = require 'gulp-requirejs'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
rimraf = require 'gulp-rimraf'

configPath = require './config.coffee'

includeRequirejsConfig = ->
    requireConfigPath = configPath.require_config
    cacheKey = require.resolve requireConfigPath

    delete require.cache[cacheKey]

    requireConfig = require requireConfigPath

    requireConfig['baseUrl'] ?= configPath.temporary
    requireConfig['out'] ?= configPath.target_name
    requireConfig


gulp.task 'default', 'Default task start watching changes for source files', ['build', 'watch'], ->

gulp.task 'watch', 'Watch for changes in source files', ->
    gulp.watch configPath.src, ['build']

gulp.task 'build', 'Build project files', ['coffee'], ->
    requireConfig = do includeRequirejsConfig

    rjs requireConfig
        .pipe uglify()
        .pipe gulp.dest configPath.target_path

    gulp.src configPath.temporary, read: no
        .pipe do rimraf

gulp.task 'coffee', 'Compile coffee scripts', ->
    gulp.src configPath.src
        .pipe do coffee
        .pipe gulp.dest configPath.temporary
