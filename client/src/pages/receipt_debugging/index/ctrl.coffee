Ctrl = ($scope,$state,ReceiptImage,Debug,$http)->

  $scope.currentUser = null
  $scope.page = 1
  $scope.limit = 10
  $scope.total = 0
  $scope.searchText = ""
  $scope.cacheSearchText = ""
  $scope.cacheConfidenceLevel =
    min: 0.00
    max: 1.00
  $scope.cacheCreatedAt =
    min: null
    max: null
  $scope.cacheSort = "created_at DESC"
  $scope.cachePage = 1
  $scope.uiState =
    loading: false
    count: 0
    userModal: false
  $scope.collection = []
  $scope.listType = 'list'
  $scope.confidenceLevel =
    min: 0.000
    max: 1.000
  $scope.sliderSettings =
    value: 0.9
    options:
      floor: 0.000
      ceil: 1.000
      step: 0.001
      precision: 3
  $scope.createdAt =
    min: null
    max: null
  $scope.sort = "created_at DESC"
  $scope.max_page = 20
  $scope.missing_fields = ["total", "date", "time", "merchant"]
  $scope.field_filters =
    page: 1
    blink_receipt_id: ""
    sort: "created_at DESC"
    dollar_difference: null
    percent_difference: null
    device_type: ""
    sdk_version: ""

  $scope.base_url = "https://staging-licensing.windfall.me/api/debugs/receipt_list?"
  # $scope.base_url = "http://localhost:3001/api/debugs/receipt_list?"
  $scope.page = 1
  $scope.data =
    results: []
    count: 0

  # $scope.preview_images = []

  $scope.search =->
    $scope.field_filters.page = 1
    $scope.getData()
  $scope.getData =->
    $scope.http_config =
      'uid': 1
      'Api-Token': 'KDzmRrzfy9TzZscnBan9'
      'Accept': 'application/vnd.windfall+json;version=1'
    # $scope.http_config =
    #   'uid': 5
    #   'Api-Token': 'PsGXQC3b-HN4LVBsqQ2r'
    #   'Accept': 'application/vnd.windfall+json;version=1'
    $scope.req =
      headers: $scope.http_config
    $scope.url = $scope.base_url
    $scope.link = []
    for key, value of $scope.field_filters
      unless ((key != "page" || key != "blink_receipt_id") && value == false) || (key == "blink_receipt_id" && value == "") || value == null
        true_value = (key != "page" || key != "blink_receipt_id") ? !value : value
        $scope.link.push "receipt%5B#{key}%5D=#{value}"
    # debugger
    $scope.uiState.loading = true
    $http.get("#{$scope.base_url}#{$scope.link.join('&')}", {headers: $scope.http_config}).then (data)->
      $scope.data = data.data
      $scope.uiState.loading = false
  $scope.pageChange =->
    # $scope.field_filters.page = this.page
    # debugger
    $scope.getData()

  $scope.search()


Ctrl.$inject = ['$scope','$state','ReceiptImage', 'Debug', '$http']
angular.module('client').controller('ReceiptDebuggingIndexCtrl', Ctrl)
