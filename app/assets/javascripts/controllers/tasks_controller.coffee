app = angular.module('app');

app.controller("TasksController", [ '$scope', 'task'
  ($scope, task)->
    $scope.task = task
])