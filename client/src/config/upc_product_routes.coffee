angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.upc_products',
        url: '/upc_products',
        template: '<div ui-view></div>'
        abstract: true

      .state 'admin.upc_products.index',
        url: '',
        templateUrl: 'pages/upc_products/index/index.html'
        controller: 'UpcProductsIndexCtrl'

]
