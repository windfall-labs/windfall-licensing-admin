angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.rsd_products',
        url: '/rsd_products',
        template: '<div ui-view></div>'
        abstract: true

      .state 'admin.rsd_products.index',
        url: '',
        templateUrl: 'pages/rsd_products/index/index.html'
        controller: 'RsdProductsIndexCtrl'

]
