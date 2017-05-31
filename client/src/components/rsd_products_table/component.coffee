Ctrl =($rootScope, $scope, RsdProduct)->
  ctrl = this

  # @.receiptImage = null
  # @.toggleModal = false

  # ctrl.getBannerUrl =(data)->
  #   S3_IMAGE_URL + data.banner_id + "/" + data.image

  # ctrl.openImage =(url)=>
  #   window.open url
  #
  # ctrl.openModal =(obj)=>
  #   # debugger
  #   @.receiptImage = obj
  #   @.toggleModal = true
  #
  # ctrl.closeModal =(toggle)=>
  #   console.log toggle
  #
  #   if toggle == false
  #     @.toggleModal = toggle
  #     $rootScope.bodyClass = ""

  ctrl.updateNeverProduct =(obj)=>
    RsdProduct.updateNeverProduct(obj)
    # alert(id)

  ctrl.determineRsdProductStatus =(obj)=>
    # console.log(obj.rsd)
    return obj.rsd != ''

  ctrl.myPagingFunction =()->
    console.log ">>>>>" + @.page
    @.incrementPage({page: @.page})
    @.page = @.page + 1


  # $scope.$on 'endlessScroll:next', ->
  #   debugger

  return

Ctrl.$inject = ['$rootScope', '$scope', 'RsdProduct']

angular.module('client').component 'rsdProductsTable',
  templateUrl: 'components/rsd_products_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    getData: "&"
    searchText: "="
    page: "="
    incrementPage: "&"
