Ctrl =($rootScope)->
  ctrl = this

  ctrl.getBannerUrl =(data)=>
    "https://windfall-licensing.s3.amazonaws.com/uploads/receipt_image/image/" + data.id + "/" + data.image

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


  return

Ctrl.$inject = ['$rootScope']

angular.module('client').component 'receiptsGridTable',
  templateUrl: 'components/receipts_grid_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    searchText: "="
    page: "="
    incrementPage: "&"
