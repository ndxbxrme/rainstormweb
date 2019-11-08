'use strict'

angular.module 'rainstormweb'
.controller 'UserCtrl', ($scope, $stateParams) ->
  $scope.user = $scope.single 'users', $stateParams