app = angular.module('app');

app.directive('navigation'
  ()->
    return {
      scope: true
      templateUrl: 'navigation.html',
      controller: ['$scope', '$state'
        ($scope, $state)->
          $scope.title = ->
            $state.current.name
        ]
      }
  )