Ctrl =($rootScope, $scope)->
  ctrl = this

  @.receiptImage = null
  @.toggleModal = false

  ctrl.getBannerUrl =(data)->
    S3_IMAGE_URL + data.banner_id + "/" + data.image

  ctrl.openImage =(url)=>
    window.open url

  ctrl.openModal =(obj)=>
    # debugger
    @.receiptImage = obj
    @.toggleModal = true

  ctrl.closeModal =(toggle)=>
    console.log toggle

    if toggle == false
      @.toggleModal = toggle
      $rootScope.bodyClass = ""

  ctrl.myPagingFunction =()->
    console.log ">>>>>" + @.page
    @.incrementPage({page: @.page})
    @.page = @.page + 1
  ctrl.getDate =(obj)->
    created_at = moment(new Date(obj.created_at))
    created_at.format('MM-DD-YYYY')

  # $scope.$on 'endlessScroll:next', ->
  #   debugger

  return

Ctrl.$inject = ['$rootScope', '$scope']

angular.module('client').component 'receiptsTable',
  templateUrl: 'components/receipts_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    getData: "&"
    searchText: "="
    page: "="
    incrementPage: "&"
