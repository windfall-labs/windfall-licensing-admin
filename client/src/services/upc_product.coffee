module = ($resource)->

  UpcProduct = $resource "/api/upc_products/:id", {id: "@id"},
    {
      getList:
        url: "/api/upc_products"
        method: 'get'
        isArray: false

      updateUpcProduct:
        url: "/api/upc_products/:id/update_field"
        method: 'put'
        isArray: false
    }

module.$inject = ['$resource']
angular.module('client').factory('UpcProduct', module)
