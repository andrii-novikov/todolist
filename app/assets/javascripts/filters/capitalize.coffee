app = angular.module('app');

app.filter('capitalize', ()->
  return (text) ->
    if (text)
      return text.charAt(0).toUpperCase() + text.slice(1)
)