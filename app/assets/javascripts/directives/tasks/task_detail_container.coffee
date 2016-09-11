app = angular.module('app');

app.directive('taskDetailContainer'
  ()->
    return {
      scope: {
        'task': '='
      }
      templateUrl: 'tasks/task_detail_container.html',
      controller: ['$scope', 'Task', '$cookieStore'
        ($scope, Task, $cookieStore)->
          $scope.statuses = Task.statuses();
          $scope.newDeadline = if $scope.task.deadline then new Date($scope.task.deadline);
          $scope.format = 'dd MMMM yyyy'
          $scope.dateOptions =
            formatYear: 'yy'
            maxDate: new Date(2020, 5, 22)
            minDate: new Date
            startingDay: 1

          $scope.popup = opened: false
          $scope.open = ->
            $scope.popup.opened = true

          $scope.delete = ()->
            Task.remove({id:$scope.task.id}, (resp)->
              window.location = '/'
            )

          $scope.deadlineChange = ->
            $scope.task.deadline = $scope.newDeadline
            $scope.save()

          $scope.save = ()->
            Task.save({id:$scope.task.id}, $scope.task)

          $scope.completedClass = ->
            if $scope.task.done then 'glyphicon-ok' else 'glyphicon-ban-circle'

          $scope.toggleCompleted = ->
            $scope.task.done = !$scope.task.done
            $scope.save()

          $scope.flowOptions =
            uploadMethod: 'PUT'
            fileParameterName: 'attachment'
            testChunks:false
            singleFile: true
            attributes: {id:'fileInput'}
            headers: $cookieStore.get('auth_headers')
      ]
    }
)