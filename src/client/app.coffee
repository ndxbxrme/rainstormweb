'use strict'

angular.module 'rainstormweb', [
  'ndx'
  'ui.router'
  'ngFileUpload'
]
.config ($locationProvider, $urlRouterProvider, AuthProvider) ->
  $urlRouterProvider.otherwise '/'
  $locationProvider.html5Mode true
  AuthProvider.config
    anonymousUser: true
.run ($rootScope) ->
  $rootScope.makeDownloadUrl = (document) ->
    if document
      '/api/download/' + btoa JSON.stringify({path:document.path,filename:document.originalFilename})
try
  angular.module 'ndx'
catch e
  angular.module 'ndx', [] #ndx module stub