angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.tags',
        url: '/tags',
        template: '<div ui-view></div>'
        abstract: true

      .state 'admin.tags.index',
        url: '',
        templateUrl: 'pages/tags/index/index.html'
        controller: 'TagsIndexCtrl'

]
