module = ($resource)->

  RsdProduct = $resource "/api/rsd_products/:id", {id: "@id"},
    {
      getList:
        url: "/api/rsd_products"
        method: 'get'
        isArray: false

      updateNeverProduct:
        url: "/api/rsd_products/:id/never_product"
        method: 'put'
        isArray: false

      updateAlwaysAProduct:
        url: "/api/rsd_products/:id/always_a_product"
        method: 'put'
        isArray: false

      updateCoupon:
        url: "/api/rsd_products/:id/coupon"
        method: 'put'
        isArray: false

      # getPreviewImages:
      #   url: "/api/rsd_products/:id/preview_images"
      #   method: 'get'
      #   isArray: false
    }

module.$inject = ['$resource']
angular.module('client').factory('RsdProduct', module)
