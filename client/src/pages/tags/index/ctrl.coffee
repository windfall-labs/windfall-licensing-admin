Ctrl = ($scope, Tags, growl)->
  $scope.collection = []
  $scope.uiState =
    # loading: true
    scrollLoading: false
    page: 1
  $scope.getRsds =->
    if !$scope.scrollLoading
      $scope.uiState.scrollLoading = true
      Tags.getList({page: $scope.uiState.page}).$promise
        .then (data)->
          if $scope.uiState.page == 1
            $scope.collection = data.collection || []
          else
            angular.forEach data.collection, (product)->
              $scope.collection.push(product)
        .finally ->
          $scope.uiState.scrollLoading = false
          return
  $scope.nextPage =->
    if !$scope.uiState.scrollLoading
      $scope.uiState.page = $scope.uiState.page + 1
      $scope.getRsds()
  $scope.saveTag =(obj,index)->
    $scope.uiState.loading = true
    Tags.createTag({tag: obj}).$promise
      .then (data)->
        growl.success(MESSAGES.TAGS_SUCESS)
      .finally ->
        $scope.uiState.loading = false
  $scope.getRsds()
  return
Ctrl.$inject = ['$scope', 'Tags', 'growl']
angular.module('client').controller('TagsIndexCtrl', Ctrl)
