app = angular.module('app');

app.controller("ProjectsController", [ '$scope', 'Project', '$uibModal', 'projects'
  ($scope, Project, $uibModal, projects)->
    $scope.projects = projects
    $scope.delete = (project)->
      Project.remove({ id:project.id }, () ->
        $scope.projects = _.without($scope.projects, project)
      )

    $scope.add = () ->
      $scope.modalInstance = $uibModal.open({
        animation: true
        ariaLabelledBy: 'modal-title',
        ariaDescribedBy: 'modal-body',
        templateUrl: 'projects/modal.html',
        size: 'sm'
        controller: ['$scope', '$uibModalInstance', ($scope, $uibModalInstance)->
          $scope.ok = ()->
            $uibModalInstance.close($scope.title);
          $scope.cancel = ()->
            $uibModalInstance.dismiss('cancel');
          $scope.isValid = -> !_.isUndefined($scope.title) && $scope.title.length > 0
        ]
      });

      $scope.modalInstance.result.then( (title)->
        Project.create({ title: title }, (project)->
            $scope.projects.push(project)
        )
      )
])
