app = angular.module('app');

app.directive('taskComments'
  ()->
    return {
      scope: {
        'task': '='
        '$flow': '='
      }
      templateUrl: 'tasks/task_comments.html',
      controller: ['$scope', 'Task'
        ($scope, Task)->
          $scope.newComment = {}
          $scope.canAdd = -> $scope.newComment.text && $scope.newComment.text.length > 0
          $scope.add = ->
            Task.createComment(task_id:$scope.task.id, $scope.newComment, (comment)->
              if _.some($scope.$flow.files)
                $scope.$flow.opts.target = "/tasks/#{$scope.task.id}/comments/#{comment.id}.json"
                $scope.$flow.upload()
              else
                $scope.push(comment)
            )
          $scope.$on('flow::fileSuccess', (event, $flow, $file, $message) ->
            $scope.push(JSON.parse($message))
          );
          $scope.push = (comment)->
            $scope.task.comments.push(comment)
            $scope.newComment = {}
            $scope.$flow.cancel()
          $scope.delete = (comment)->
            Task.deleteComment({task_id:$scope.task.id, id:comment.id}, (msg)->
              _.pull($scope.task.comments, comment)
            )
      ]
    }
)