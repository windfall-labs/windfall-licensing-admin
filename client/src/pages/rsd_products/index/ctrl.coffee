Ctrl = ($scope,$state,RsdProduct)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 30
  $scope.searchText = ""
  $scope.cacheSearchText = ""
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.collection = []
  $scope.listType = 'list'
  # $scope.preview_images = []

  $scope.getData =(page, limit)->


    RsdProduct.getList(page: page, limit: limit, filter: $scope.searchText).$promise
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
  # $scope.getPrev =(rsd_product_id)->
  #   debugger;
  #   RsdProduct.getPreviewImages(receiptiage_id_id: rsd_product_id).$promise
  #     .then (data)->
  #       debugger

  $scope.getData($scope.page, $scope.limit)

Ctrl.$inject = ['$scope','$state','RsdProduct']
angular.module('client').controller('RsdProductsIndexCtrl', Ctrl)
