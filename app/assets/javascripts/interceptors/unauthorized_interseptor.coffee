app = angular.module('app')

app.factory('unauthorizedInterseptor', ['$q', '$injector', 'Flash'
  ($q, $injector, Flash) ->
    {
      'responseError': (rejection) ->
        defer = $q.defer()
        if rejection.status == 401
          $injector.get('$state').go('login').then ->
            Flash.create('danger', rejection.data.error) if rejection.data.error
        defer.reject rejection
        defer.promise
    }
])