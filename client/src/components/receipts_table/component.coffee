Ctrl =($rootScope)->
  ctrl = this

  @.receiptImage = null
  @.toggleModal = false

  ctrl.getBannerUrl =(data)->
    S3_IMAGE_URL + data.id + "/" + data.image

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

  return

Ctrl.$inject = ['$rootScope']

angular.module('client').component 'receiptsTable',
  templateUrl: 'components/receipts_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    searchText: "="
