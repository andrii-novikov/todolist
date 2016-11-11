app = angular.module('app')

app.config(['$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->

    unregisterAccess =
      access: ['$auth', '$state', ($auth, $state) ->
        $auth.validateUser().then(
          -> $state.go('home')
          -> true
        )
      ]

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
      resolve: unregisterAccess

    })
    .state('register', {
      url: '/register'
      templateUrl: 'users/register.html'
      controller: 'AuthController'
      resolve: unregisterAccess
    })

])