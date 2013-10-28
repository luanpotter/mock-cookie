module.exports = (grunt) ->
  # Load all the grunt tasks
  require('load-grunt-tasks') grunt

  grunt.initConfig
    # Module options as specified in bower.json file
    bower: grunt.file.readJSON 'bower.json'

    # Remove the old built files before making new ones
    clean:
      dist: ['dist']
      tmp: ['.tmp']
    coffee:
      options: bare: true
      all:
        files: '.tmp/<%= bower.name %>.js': 'src/<%= bower.name %>.coffee'
    concat:
      all:
        src: [
          'src/<%= bower.name %>.prefix',
          '.tmp/<%= bower.name %>.js',
          'src/<%= bower.name %>.suffix'
        ],
        dest: 'dist/<%= bower.name %>.js'
    uglify:
      options:
        banner: '/*! <%= bower.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
        report: 'gzip'
      all:
        files: 'dist/<%= bower.name %>.min.js': ['<%= concat.all.dest %>']
    jshint:
      dist:
        options:
          globalstrict: false
          eqnull: true
        src: ['<%= concat.all.dest %>']


  grunt.registerTask 'default', [
    'clean:dist'
    'coffee'
    'concat'
    'jshint:dist'
    'uglify'
  ]
