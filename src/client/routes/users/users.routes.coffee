'use strict'
 
angular.module 'rainstormweb'
.config ($stateProvider) ->
  $stateProvider.state 'users',
    url: '/users'
    templateUrl: 'routes/users/users.html'
    controller: 'UsersCtrl'
    data:
      title: 'users'
      auth: ['anon']