app = angular.module('app');

app.factory('Project', ['$resource', ($resource)->
  return $resource('/projects/:id.json', { id:'@id'}, {
    save: { method: 'PUT' }
    create: {method:'POST'},
    query:
      isArray: true
      transformResponse: (data) ->
        response = angular.fromJson(data)

        if _.isArray(response)
          response
        else
          [response]
  });
])