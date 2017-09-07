Ctrl = ($scope, $state,UpcProduct) ->
  $scope.search =
    sort: "receipt_product_number"
    dir: "ASC"
  $scope.pageParams =
    page: 1
    limit: 30
  $scope.uiState =
    loading: false
  $scope.collection = []
  $scope.cachedSearch = angular.copy($scope.search)
  $scope.cachedPageParams = angular.copy($scope.pageParams)
  $scope.getData =->
    $scope.uiState.loading = true
    UpcProduct.getList(Object.assign($scope.search, $scope.pageParams)).$promise
      .then (data)->
        if JSON.stringify($scope.search) == JSON.stringify($scope.cachedSearch) && JSON.stringify($scope.pageParams) != JSON.stringify($scope.cachedPageParams)
          $scope.collection.push(data.collection)
        else
          $scope.collection = data.collection
        $scope.cachedSearch = angular.copy($scope.search)
        $scope.cachedPageParams = angular.copy($scope.pageParams)
      .finally ->
        $scope.uiState.loading = false
  $scope.getData()
  return

Ctrl.$inject = ['$scope', '$state', 'UpcProduct']
angular.module('client').controller('UpcProductsIndexCtrl', Ctrl)
