Ctrl = ($scope,$state,ReceiptImage)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 20
  $scope.searchText = ""
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.collection = []
  $scope.listType = 'list'
  # $scope.preview_images = []

  $scope.getData =(page, limit)->
    ReceiptImage.getList(page: page, limit: limit, filter: $scope.searchText).$promise
      .then (data)->
        $scope.collection = data.collection
        $scope.uiState.count = data.count

  $scope.clearData =(page, limit)->
    if $scope.searchText == ""
      $scope.getData($scope.page, $scope.limit)

  # $scope.getPrev =(receipt_image_id)->
  #   debugger;
  #   ReceiptImage.getPreviewImages(receiptiage_id_id: receipt_image_id).$promise
  #     .then (data)->
  #       debugger

  $scope.getData($scope.page, $scope.limit)

Ctrl.$inject = ['$scope','$state','ReceiptImage']
angular.module('client').controller('ReceiptImagesIndexCtrl', Ctrl)
