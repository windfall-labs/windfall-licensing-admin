angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.receipt_images',
        url: '/receipt_images',
        template: '<div ui-view></div>'
        abstract: true

      .state 'admin.receipt_images.index',
        url: '',
        templateUrl: 'pages/receipt_images/index/index.html'
        controller: 'ReceiptImagesIndexCtrl'


]
