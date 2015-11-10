# Js-skeleton

Base skeleton for js application. Used gulp, coffee script and require Js.

### Install

You need install node modules and bower comonents:

```bash
npm install
bower install
```

### Use

After install requeres (node & bower), need start gulp:

```bash
gulp --require coffee-script/register
```

Target 'defualt' watch compiled coffee script files and build to dist/main.js (path optional). Result is located in dist/main.js (path optional)

Available targets list:

```bash
gulp --require coffee-script/register help
```

Building config is located config.coffee

```coffee
src: './app/**/*.coffee' #Glob mask in to find *.coffee files
temporary: 'tmp/' #Temporary directory
target_path: 'dist' #Directory path for compiled files
target_name: 'main.js' #Name for compiled application file located in target_path
require_config: './app/require.config.coffee' #Path to config file for require Js
```
