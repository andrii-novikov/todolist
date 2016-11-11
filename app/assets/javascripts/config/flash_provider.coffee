app = angular.module('app')

app.config(['FlashProvider', (FlashProvider) ->
  FlashProvider.setTimeout(10000);
  FlashProvider.setShowClose(true);
]).run(['$rootScope','Flash', ($rootScope, Flash)->
  $rootScope.$on('$stateChangeStart', ()-> Flash.clear())
])
