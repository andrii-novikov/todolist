app = angular.module('app')

app.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push('unauthorizedInterseptor')
]).run(['$rootScope', '$http','$cookieStore', ($rootScope, $http, $cookieStore) ->
  $rootScope.updateHeaders = ->
    $http.defaults.headers.common = _.merge($http.defaults.headers.common, $cookieStore.get('auth_headers'))
  $rootScope.updateHeaders()
])
