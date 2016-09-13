app = angular.module('app')

app.config(['$authProvider', ($authProvider) ->
  $authProvider.configure({
    apiUrl: ''
    omniauthWindowType: 'newWindow'
  });
])