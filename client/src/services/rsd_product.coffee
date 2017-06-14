module = ($resource)->

  RsdProduct = $resource "/api/rsd_products/:id", {id: "@id"},
    {
      getList:
        url: "/api/rsd_products"
        method: 'get'
        isArray: false

      updateRsdProduct:
        url: "/api/rsd_products/:id/update_field"
        method: 'put'
        isArray: false
    }

module.$inject = ['$resource']
angular.module('client').factory('RsdProduct', module)
