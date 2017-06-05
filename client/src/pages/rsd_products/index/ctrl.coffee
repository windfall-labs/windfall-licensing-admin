Ctrl = ($scope,$state,RsdProduct)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 30
  $scope.searchText = ""
  $scope.uniqueAcceptedCount = ""
  $scope.uniqueRejectedCount = ""
  $scope.receiptAcceptedCount = ""
  $scope.acceptedCount = ""
  $scope.rejectedCount = ""
  $scope.altProduct = ""
  $scope.altProductAcceptedCount = ""
  $scope.cacheSearchText = ""
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.collection = []
  $scope.listType = 'list'

  $scope.getData =(page, limit)->
    # debugger
    RsdProduct.getList(page: page, limit: limit, filter: $scope.searchText, unique_accepted_count: $scope.uniqueAcceptedCount, unique_rejected_count: $scope.uniqueRejectedCount, receipt_accepted_count: $scope.receiptAcceptedCount, accepted_count: $scope.acceptedCount, rejected_count: $scope.rejectedCount, alt_product: $scope.altProduct, alt_product_accepted_count: $scope.altProductAcceptedCount).$promise
      .then (data)->
        if  $scope.cacheSearchText == $scope.searchText
          angular.forEach data.collection, (rsd_product) ->
            $scope.collection.push(rsd_product)
        else
          $scope.collection = data.collection

        $scope.cacheSearchText = $scope.searchText
        $scope.uiState.count = data.count

  $scope.clearData =(page, limit)->
    if $scope.searchText == ""
      $scope.getData($scope.page, $scope.limit)

  $scope.incrementPage =(page)->
    $scope.getData(page, $scope.limit)

  $scope.getData($scope.page, $scope.limit)

Ctrl.$inject = ['$scope','$state','RsdProduct']
angular.module('client').controller('RsdProductsIndexCtrl', Ctrl)
