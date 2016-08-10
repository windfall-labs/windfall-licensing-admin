angular.module('client').filter 'range', ->
  (input, total) ->
    total = parseInt(total)
    i = 0
    while i < total
      input.push i+1
      i++
    input


angular.module('client').directive "toggleListType", ->
  restrict: "E"
  replace: true
  templateUrl: 'components/toggle_view/index.html'
  scope:
    listType: '='

  link: ($scope, element, attrs) ->

    $scope.changeListType =(type)->
      $scope.listType = type
