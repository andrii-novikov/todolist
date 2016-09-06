app = angular.module('app', [
  'ui.router'
  'templates'
  'ngResource'
  'ui.bootstrap'
  'flow'
  'ngFlash'
  'facebook'
  'ng-token-auth'
  'ngCookies'
]).config(['$stateProvider', '$urlRouterProvider', 'FlashProvider', 'FacebookProvider', '$authProvider'
  ($stateProvider, $urlRouterProvider, FlashProvider, FacebookProvider, $authProvider)->
    $urlRouterProvider.otherwise("/");

    unregisterAccess = access: ['$auth', '$state', ($auth, $state) ->
      $auth.validateUser().then(
        -> $state.go('home')
        -> true
      )
    ]

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

    $authProvider.configure({
      apiUrl: 'http://localhost:3000'
      omniauthWindowType: 'newWindow'
    });

    FlashProvider.setTimeout(10000);
    FlashProvider.setShowClose(true);

    FacebookProvider.init('1091922357559241')

]).run(['$rootScope', 'Flash', '$http', '$cookieStore', ($rootScope, Flash, $http, $cookieStore)->
  $rootScope.$on('$stateChangeStart', ()-> Flash.clear())
  $rootScope.updateHeaders = ->
    $http.defaults.headers.common = _.merge($http.defaults.headers.common, $cookieStore.get('auth_headers'))
  $rootScope.updateHeaders()
])
