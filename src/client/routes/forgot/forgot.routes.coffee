'use strict'

angular.module 'rainstormweb'
.config ($stateProvider) ->
  $stateProvider.state 'forgot',
    url: '/forgot'
    templateUrl: 'routes/forgot/forgot.html'
    controller: 'ForgotCtrl' 
  $stateProvider.state 'forgotResponse',
    url: '/forgot/:token'
    templateUrl: 'routes/forgot/forgot.html'
    controller: 'ForgotCtrl'  