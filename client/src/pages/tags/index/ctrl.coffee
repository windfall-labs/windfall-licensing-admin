Ctrl = ($scope, Tags, growl)->
  $scope.collection = []
  $scope.uiState =
    # loading: true
    scrollLoading: false
    page: 1
    excluded_ids: []
    banner_id: null
  $scope.getRsds =->
    # if !$scope.scrollLoading
    $scope.uiState.loading = true
    Tags.getList({page: $scope.uiState.page, excluded_ids: JSON.stringify($scope.uiState.excluded_ids), banner_id: $scope.uiState.banner_id}).$promise
      .then (data)->
        $scope.collection = []
        angular.forEach data.collection, (rsd_product)->
          rsd_product.selected = true
          $scope.collection.push(rsd_product)
      .finally ->
        $scope.uiState.loading = false
        return
  # $scope.save =->
  #   # params = []
  #   # angular.forEach $scope.collection, (product)->
  #   #   if product.selected
  #   #     params.push(product)
  #   #   else
  #   #     $scope.uiState.excluded_ids.push(product.rsd_product_id)
  #   $scope.saveRsd(params)

  $scope.saveRsd =->
    $scope.uiState.loading = true
    Tags.createTags({tags: $scope.collection}).$promise
      .then (data)->
        growl.success(MESSAGES.TAGS_SUCESS)
        $scope.getRsds()
      .finally ->
        $scope.uiState.loading = false
        return
  $scope.saveTag =(obj,index)->
    $scope.uiState.loading = true
    Tags.createTag({tag: obj}).$promise
      .then (data)->
        growl.success(MESSAGES.TAGS_SUCESS)
        $scope.collection.splice(index, 1)
      .finally ->
        $scope.uiState.loading = false
  $scope.getRsds()
  return
Ctrl.$inject = ['$scope', 'Tags', 'growl']
angular.module('client').controller('TagsIndexCtrl', Ctrl)
