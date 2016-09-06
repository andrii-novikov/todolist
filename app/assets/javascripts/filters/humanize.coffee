app = angular.module('app');

app.filter('humanize', ['capitalizeFilter', (capitalizeFilter)->
  return (text) ->
    if (text)
      string = text.split('_').join(' ').toLocaleLowerCase()
      return capitalizeFilter(string)
])