Ctrl =($scope, $rootScope, ReceiptImage) ->
  ctrl = this

  $rootScope.bodyClass = "modal-open"

  $scope.prevCollection = []
  $scope.nextCollection = []

  $scope.receipt_image = @.obj
  ctrl.onSubmit =(form)->
    form.$submitted = true
    if form.$valid
      this.submit({obj: @.obj})

  ctrl.getBannerUrl =(receipt_image)->
    S3_IMAGE_URL + receipt_image.banner_id + "/" + receipt_image.image

  ctrl.selectPreview =(obj)->
    ReceiptImage.getPreviewImages({id: obj.id}).$promise
      .then (data)->
        $scope.prevCollection = data.prev_receipts
        $scope.nextCollection = data.next_images
        $scope.receipt_image = obj

  ctrl.goPrevImage =(collection)->
    ctrl.selectPreview(collection[collection.length-1])

  ctrl.goNextImage =(collection)->
    ctrl.selectPreview(collection[0])

  ctrl.goNextImage =(collection)->
    ctrl.selectPreview(collection[0])

  ctrl.selectPreview(@obj)
  return


Ctrl.$inject = ['$scope', '$rootScope', 'ReceiptImage']

angular.module('client').component 'receiptImageModal',
  templateUrl: 'components/receipt_image_modal/index.html'
  controller: Ctrl
  bindings:
    submit: "&"
    loading: "="
    toggle: "&"
    obj: "="
    closeModal: "&"
