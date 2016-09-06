app = angular.module('app');

app.directive('newTaskForm'
  ()->
    return {
      scope:
        'project':'='
      templateUrl: 'projects/new_task_form.html'
      controller: ['$scope', 'Task'
        ($scope, Task)->
          $scope.newTask = {};
          $scope.isValid = ->
            !_.isUndefined($scope.newTask.title) && $scope.newTask.title.length > 0
          $scope.createTask = (newTask) ->
            $scope.newTask.project_id = $scope.project.id;
            Task.create(newTask
              (task)->
                $scope.project.tasks.push(task);
                $scope.newTask = {}
            )

      ]
    }
)