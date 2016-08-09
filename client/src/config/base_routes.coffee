angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/login')

    $stateProvider
      .state 'login',
        url: '/login',
        templateUrl: 'pages/login/index.html'
        controller: 'LoginCtrl'
        data:
          unauthenticated: true

      .state 'admin',
        url: '/admin',
        templateUrl: 'pages/admin/index.html'
        controller: 'AdminCtrl'
        abstract: true
        data:
          authenticated: true

      .state 'admin.dashboard',
        url: '/dashboard',
        templateUrl: 'pages/dashboard/index.html'
        controller: 'DashboardCtrl'

      # .state 'admin.receipts',
      #   url: '/login',
      #   templateUrl: 'pages/login/index.html'
      #   controller: 'LoginCtrl'
      #   data:
      #     unauthenticated: true
]
