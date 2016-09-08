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
      if user
        for fieldname, message of reason.errors
          field = $(".form-group.#{fieldname}")
          field.addClass('has-error')
          field.find('.help-block').html("#{_.capitalize(fieldname)} #{message}")
    );
])
