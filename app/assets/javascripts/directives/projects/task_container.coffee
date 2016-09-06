app = angular.module('app');

app.directive('taskContainer'
  ()->
    return {
      scope:
        'task':'=',
        'project': '='
      templateUrl: 'projects/task_container.html',
      controller: ['$scope', 'Task'
        ($scope, Task)->
          $scope.delete = ()->
            Task.remove({id:$scope.task.id}, (resp)->
              _.pull($scope.project.tasks, $scope.task)
            )
          $scope.save = ()->
            Task.save({id:$scope.task.id}, $scope.task)
          $scope.order = (direction)->
            Task.save({id:$scope.task.id}, {task:{order:'order_'+direction}}, (resp)->
              _.pull($scope.project.tasks, $scope.task)
              $scope.project.tasks = _.concat($scope.project.tasks, resp)
            )
      ]
    }
)