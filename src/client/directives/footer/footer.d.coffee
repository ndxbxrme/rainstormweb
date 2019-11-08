'use strict'

angular.module 'rainstormweb'
.directive 'footer', ->
  restrict: 'EA'
  templateUrl: 'directives/footer/footer.html'
  replace: true