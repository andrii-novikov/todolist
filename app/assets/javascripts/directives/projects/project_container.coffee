app = angular.module('app');

app.directive('projectContainer',
  ()->
    return {
      scope:
        'project': '='
        'delete': '='
      templateUrl: 'projects/project_container.html',
      controller: ['$scope', 'Project'
        ($scope, Project)->
          $scope.save = ()->
            $scope.input && $scope.input.css('pointer-events','none')
            Project.save({ id: $scope.project.id }, $scope.project)
          $scope.edit = ()->
            $scope.input = $('#' + $scope.project.id + ' input.title')
            $scope.input.css('pointer-events','auto')
            val = $scope.input.val()
            $scope.input.focus().val('').val(val)
            true

      ]
    }
)