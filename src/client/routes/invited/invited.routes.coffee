'use strict'

angular.module 'rainstormweb'
.config ($stateProvider) ->
  $stateProvider.state 'invited',
    url: '/invite/:code'
    templateUrl: 'routes/invited/invited.html'
    controller: 'InvitedCtrl'