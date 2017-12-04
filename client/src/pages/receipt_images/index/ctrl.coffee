Ctrl = ($scope,$state,ReceiptImage)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 10
  $scope.searchText = ""
  $scope.cacheSearchText = ""
  $scope.cachePage = 1
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.collection = []
  $scope.listType = 'list'
  $scope.confidenceLevel =
    min: 0
    max: 1
  $scope.sliderSettings =
    value: 0.9
    options:
      floor: 0
      ceil: 1
      step: 0.1
      precision: 1
  $scope.createdAt =
    min: null
    max: null
  $scope.sort = "created_at DESC"
  # $scope.preview_images = []

  $scope.getData =(page, limit)->


    ReceiptImage.getList(page: page, limit: limit, filter: $scope.searchText, sort: $scope.sort, date_filter: $scope.createdAt, confidence_filter: $scope.confidenceLevel).$promise
      .then (data)->
        if $scope.cacheSearchText == $scope.searchText && $scope.cachePage != page
          angular.forEach data.collection, (receipt_image) ->
            $scope.collection.push(receipt_image)
        else
          $scope.collection = data.collection

        $scope.cacheSearchText = $scope.searchText
        $scope.cachePage = page
        $scope.uiState.count = data.count

  $scope.clearData =(page, limit)->
    if $scope.searchText == ""
      $scope.getData($scope.page, $scope.limit)

  $scope.incrementPage =(page)->
    $scope.getData(page, $scope.limit)
  # $scope.getPrev =(receipt_image_id)->
  #   debugger;
  #   ReceiptImage.getPreviewImages(receiptiage_id_id: receipt_image_id).$promise
  #     .then (data)->
  #       debugger

  $scope.getData($scope.page, $scope.limit)

Ctrl.$inject = ['$scope','$state','ReceiptImage']
angular.module('client').controller('ReceiptImagesIndexCtrl', Ctrl)
