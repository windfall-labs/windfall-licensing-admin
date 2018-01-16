angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.receipt_debugging',
        url: '/receipt_debugging',
        template: '<div ui-view></div>'
        abstract: true

      .state 'admin.receipt_debugging.index',
        url: '',
        templateUrl: 'pages/receipt_debugging/index/index.html'
        controller: 'ReceiptDebuggingIndexCtrl'

]
