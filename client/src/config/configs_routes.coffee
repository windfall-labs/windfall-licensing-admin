angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.configs',
        url: '/configs',
        template: '<div ui-view></div>'
        abstract: true

      .state 'admin.configs.index',
        url: '',
        templateUrl: 'pages/configs/index/index.html'
        controller: 'ConfigsIndexCtrl'

]
