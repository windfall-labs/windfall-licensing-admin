Ctrl = ->
  ctrl = this

  ctrl.getBannerUrl =(data)=>
    "https://windfall-licensing.s3.amazonaws.com/uploads/receipt_image/image/" + data.id + "/" + data.image

  ctrl.openImage =(url)=>
    window.open url

  return

angular.module('client').component 'receiptsGridTable',
  templateUrl: 'components/receipts_grid_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    searchText: "="
