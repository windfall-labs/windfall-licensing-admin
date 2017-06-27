Ctrl = ($scope,$state,RsdProduct)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 30
  $scope.searchText = ""
  $scope.uniqueAcceptedCount = ""
  $scope.uniqueRejectedCount = ""
  $scope.receiptAcceptedCount = ""
  $scope.receiptRejectedCount = ""
  $scope.acceptedCount = ""
  $scope.rejectedCount = ""
  $scope.altProduct = ""
  $scope.sort = ""
  $scope.dir = "ASC"
  $scope.altProductAcceptedCount = ""
  $scope.cacheSearchText = ""
  $scope.cacheSearchText = ""
  $scope.cacheuniqueAcceptedCount = ""
  $scope.cacheuniqueRejectedCount = ""
  $scope.cachereceiptAcceptedCount = ""
  $scope.cacheacceptedCount = ""
  $scope.cacherejectedCount = ""
  $scope.cachealtProduct = ""
  $scope.cachealtProductAcceptedCount = ""
  $scope.cachereceiptRejectedCount = ""
  $scope.cachesort = ""
  $scope.cachedir = ""
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.collection = []
  $scope.listType = 'list'

  $scope.getData =(page, limit, sort, dir)->
    RsdProduct.getList(page: page, limit: limit, dir: dir, sort: sort, filter: $scope.searchText, unique_accepted_count: $scope.uniqueAcceptedCount, unique_rejected_count: $scope.uniqueRejectedCount, receipt_accepted_count: $scope.receiptAcceptedCount, accepted_count: $scope.acceptedCount, rejected_count: $scope.rejectedCount, alt_product: $scope.altProduct, alt_product_accepted_count: $scope.altProductAcceptedCount, receipt_rejected_count: $scope.receiptRejectedCount).$promise

      .then (data)->
        if ($scope.cachesort == $scope.sort) && ($scope.cacheSearchText == $scope.searchText) && ($scope.cacheuniqueAcceptedCount == $scope.uniqueAcceptedCount) && ($scope.cacheuniqueRejectedCount == $scope.uniqueRejectedCount) && ($scope.cachereceiptAcceptedCount == $scope.receiptAcceptedCount) && ($scope.cacheacceptedCount == $scope.acceptedCount) && ($scope.cacherejectedCount == $scope.rejectedCount) && ($scope.cachealtProduct == $scope.altProduct) && ($scope.cachealtProductAcceptedCount == $scope.altProductAcceptedCount) && ($scope.cachereceiptRejectedCount == $scope.receiptRejectedCount)

          angular.forEach data.collection, (rsd_product) ->
            $scope.collection.push(rsd_product)
        else
          $scope.collection = data.collection

        $scope.cacheSearchText = $scope.searchText
        $scope.cacheuniqueAcceptedCount = $scope.uniqueAcceptedCount
        $scope.cacheuniqueRejectedCount = $scope.uniqueRejectedCount
        $scope.cachereceiptAcceptedCount = $scope.receiptAcceptedCount
        $scope.cacheacceptedCount = $scope.acceptedCount
        $scope.cacherejectedCount = $scope.rejectedCount
        $scope.cachealtProduct = $scope.altProduct
        $scope.cachealtProductAcceptedCount = $scope.altProductAcceptedCount
        $scope.cachereceiptRejectedCount = $scope.receiptRejectedCount
        $scope.cachesort = $scope.sort
        $scope.cachedir = $scope.dir
        $scope.uiState.count = data.count

  $scope.clearData =(page, limit)->
    if $scope.searchText == ""
      $scope.getData($scope.page, $scope.limit)

  $scope.incrementPage =(page)->
    $scope.getData(page, $scope.limit)

  $scope.getData($scope.page, $scope.limit)

Ctrl.$inject = ['$scope','$state','RsdProduct']
angular.module('client').controller('RsdProductsIndexCtrl', Ctrl)
