app = angular.module('app');

app.controller("AuthController", [ '$scope', '$auth', '$state','Flash', '$rootScope'
  ($scope, $auth, $state, Flash, $rootScope)->

    $scope.$on('auth:login-success', ->
      $rootScope.updateHeaders()
      $state.go('home')
    );

    $scope.$on('auth:registration-email-success', (ev, user) ->
      $auth.submitLogin(user)
    );

    $scope.$on('auth:login-error', (ev, user) ->
      Flash.create('danger', user.errors[0]) if user && user.errors
    );

    $scope.$on('auth:registration-email-error', (ev, reason) ->
      if reason
        Flash.create('danger', reason.errors[0]) if reason && reason.errors && reason.errors[0]
        $scope.errors = reason.errors
    );

    $scope.error = (field) ->
      if $scope.errors && $scope.errors[field]
        "#{_.capitalize(field)} #{$scope.errors[field][0]}"
])
