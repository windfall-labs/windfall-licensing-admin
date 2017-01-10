module = ($resource)->

  StoreLocation = $resource "/api/stores/import_stores/:id", {id: "@id", imported_id: "@imported_id"},
    {
      importStoreLocations:
        url: "https://licensing.windfall.me/api/stores/import_stores"
        method: 'post'
        headers: {
          'Accept': 'application/vnd.windfall+json;version=1'
          'uid': '1'
          'Api-Token': 'KDzmRrzfy9TzZscnBan9'
        }
        params: {
          imported_id: "@imported_id"
        }

      createImportedStore:
        url: "/api/imported_stores"
        method: 'post'

      checkLastImport:
        url: "/api/imported_stores/last_import_status"
        method: 'get'
    }

module.$inject = ['$resource']
angular.module('client').factory('StoreLocation', module)
