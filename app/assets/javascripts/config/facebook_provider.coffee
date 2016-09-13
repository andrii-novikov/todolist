app = angular.module('app')

app.config(['FacebookProvider', (FacebookProvider) ->
  FacebookProvider.init('1091922357559241')
])