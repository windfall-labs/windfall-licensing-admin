module = ($resource)->

  ReceiptImage = $resource "/api/receipt_images/:id", {id: "@id"},
    {
      getList:
        url: "/api/receipt_images"
        method: 'get'
        isArray: false

      getPreviewImages:
        url: "/api/receipt_images/:id/preview_images"
        method: 'get'
        isArray: false
    }

module.$inject = ['$resource']
angular.module('client').factory('ReceiptImage', module)
