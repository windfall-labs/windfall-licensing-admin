Ctrl = ($scope,$state,StoreLocation,$timeout)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 10
  $scope.searchText = ""
  $scope.cacheSearchText = ""
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.lastImportStatus = false
  
  $scope.importStoreLocations = () ->
    $scope.lastImportStatus = false

    $scope.kabute()

    StoreLocation.createImportedStore().$promise
      .then (data)->
        StoreLocation.importStoreLocations(imported_id: data.id).$promise
          .then (data)->

  $scope.checkLastImportStatus = () ->
    StoreLocation.checkLastImport().$promise
      .then (data)->
        $scope.lastImportStatus = data.imported

  $scope.kabute = () ->
    $timeout (->
      $scope.checkLastImportStatus()

      if $scope.lastImportStatus == false
        $scope.kabute()
        
      return
    ), 10000

  $scope.checkLastImportStatus()

Ctrl.$inject = ['$scope','$state', 'StoreLocation', '$timeout']
angular.module('client').controller('ConfigsIndexCtrl', Ctrl)
