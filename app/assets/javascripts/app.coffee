app = angular.module('app', [
  'ui.router'
  'templates'
  'ngResource'
  'ui.bootstrap'
  'flow'
  'ngFlash'
  'facebook'
  'ng-token-auth'
]).config(['$stateProvider', '$urlRouterProvider', 'FlashProvider', 'FacebookProvider', '$authProvider'
  ($stateProvider, $urlRouterProvider, FlashProvider, FacebookProvider, $authProvider)->
    $urlRouterProvider.otherwise("/");

    $stateProvider
    .state('home', {
      url: '/'
      templateUrl: "home.html"
      controller: 'ProjectsController'
      resolve:
        projects: [ 'Project', '$auth', (Project, $auth)->
          $auth.validateUser().then(
            ->
              Project.query().$promise
            -> [];
          )
        ]
    })
    .state('task', {
      url: '/task/:id'
      resolve:
        task: ['$stateParams', 'Task', ($stateParams, Task)->
          return Task.get({id:$stateParams.id}).$promise
        ]
      templateUrl: 'tasks/show.html'
      controller: 'TasksController'
    })
    .state('login', {
      url: '/login'
      templateUrl: 'users/login.html'
      controller: 'AuthController'
    })
    .state('register', {
      url: '/register'
      templateUrl: 'users/register.html'
      controller: 'AuthController'
    })

    $authProvider.configure({
      apiUrl: 'http://localhost:3000'
    });

    FlashProvider.setTimeout(10000);
    FlashProvider.setShowClose(true);

    FacebookProvider.init('1091922357559241')
]).run(['$rootScope', 'Flash', ($rootScope, Flash)->
  $rootScope.$on('$stateChangeStart', ()->
    Flash.clear()
  )
])
