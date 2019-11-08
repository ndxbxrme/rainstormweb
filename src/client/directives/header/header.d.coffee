'use strict'

angular.module 'rainstormweb'
.directive 'header', ->
  restrict: 'EA'
  templateUrl: 'directives/header/header.html'
  replace: true