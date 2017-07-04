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
  $scope.bannerId = ""
  $scope.isProduct = ""
  $scope.neverProduct = ""
  $scope.wrongProduct = ""
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
  $scope.cacheBannerId = ""
  $scope.cacheIsProduct = ""
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
    scrollLoading: false
  $scope.collection = []
  $scope.listType = 'list'


  $scope.triggerSearch =->
    params =
      page: 1
      limit: 30
    $scope.uiState.loading = true
    $scope.getData(params)
  $scope.getData =(params)->
    RsdProduct.getList(page: params.page, limit: params.limit, dir: params.dir, sort: params.column, filter: $scope.searchText, unique_accepted_count: $scope.uniqueAcceptedCount, unique_rejected_count: $scope.uniqueRejectedCount, receipt_accepted_count: $scope.receiptAcceptedCount, accepted_count: $scope.acceptedCount, rejected_count: $scope.rejectedCount, alt_product: $scope.altProduct, alt_product_accepted_count: $scope.altProductAcceptedCount, receipt_rejected_count: $scope.receiptRejectedCount, banner_id: $scope.bannerId, is_product: $scope.isProduct, wrong_product: $scope.wrongProduct, never_product: $scope.neverProduct).$promise

      .then (data)->
        if ($scope.cacheIsProduct == $scope.isProduct) && ($scope.cacheBannerId == $scope.bannerId) && ($scope.cachedir == $scope.dir) && ($scope.cachesort == $scope.sort) && ($scope.cacheSearchText == $scope.searchText) && ($scope.cacheuniqueAcceptedCount == $scope.uniqueAcceptedCount) && ($scope.cacheuniqueRejectedCount == $scope.uniqueRejectedCount) && ($scope.cachereceiptAcceptedCount == $scope.receiptAcceptedCount) && ($scope.cacheacceptedCount == $scope.acceptedCount) && ($scope.cacherejectedCount == $scope.rejectedCount) && ($scope.cachealtProduct == $scope.altProduct) && ($scope.cachealtProductAcceptedCount == $scope.altProductAcceptedCount) && ($scope.cachereceiptRejectedCount == $scope.receiptRejectedCount) && ($scope.cacheIsNeverProduct == $scope.neverProduct) && ($scope.cacheIsWrongProduct == $scope.wrongProduct) && $scope.page != params.page
          angular.forEach data.collection, (rsd_product) ->
            $scope.collection.push(rsd_product)
        else
          $scope.collection = data.collection

        $scope.sort = params.sort
        $scope.dir = params.dir
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
        $scope.cacheBannerId = $scope.bannerId
        $scope.cacheIsProduct = $scope.isProduct
        $scope.cacheIsNeverProduct = $scope.neverProduct
        $scope.cacheIsWrongProduct = $scope.wrongProduct
        $scope.uiState.count = data.count
        $scope.page = params.page
      .finally ->
        $scope.uiState.scrollLoading = false
        $scope.uiState.loading = false


  $scope.clearData =(page, limit)->
    if $scope.searchText == ""
      $scope.getData({page:$scope.page, limit: $scope.limit})

  $scope.incrementPage =(page)->
    unless $scope.uiState.scrollLoading
      page = page+1
      $scope.uiState.scrollLoading = true
      $scope.getData({page:page, limit: $scope.limit})
      # $scope.getData(page, $scope.limit)

  # $scope.getData($scope.page, $scope.limit)
  $scope.triggerSearch()

Ctrl.$inject = ['$scope','$state','RsdProduct']
angular.module('client').controller('RsdProductsIndexCtrl', Ctrl)
