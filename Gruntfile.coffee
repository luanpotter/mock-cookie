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
      options:
        banner: '/*! <%= bower.name %> v<%= bower.version %> | (c) <%= grunt.template.today("yyyy") %> Aspera, Inc. | MIT License */\n'
      all:
        src: [
          'src/<%= bower.name %>.prefix'
          '.tmp/<%= bower.name %>.js'
          'src/<%= bower.name %>.suffix'
        ],
        dest: 'dist/<%= bower.name %>.js'
    uglify:
      options:
        banner: '<%= concat.options.banner %>'
        report: 'gzip'
      all:
        files: 'dist/<%= bower.name %>.min.js': ['<%= concat.all.dest %>']
    jshint:
      dist:
        options:
          globalstrict: false
          eqnull: true
        src: ['<%= concat.all.dest %>']
    bump:
      options:
        files: [
          'package.json'
          'bower.json'
        ]
        updateConfigs: ['bower']
        commitFiles: ['-a']
        pushTo: 'origin'


  grunt.registerTask 'default', [
    'clean'
    'coffee'
    'concat'
    'jshint'
    'uglify'
    'clean:tmp'
  ]

  grunt.registerTask 'release', (target) ->
    if target in [ 'patch', 'minor', 'major', 'git' ]
      grunt.task.run [
        "bump-only:#{target}"
        'default'
        'changelog'
        'bump-commit'
      ]
