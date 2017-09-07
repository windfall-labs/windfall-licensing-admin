Ctrl =($rootScope, $scope, UpcProduct)->
  ctrl = this
  return
Ctrl.$inject = ['$rootScope', '$scope', 'UpcProduct']
angular.module('client').component 'upcProductsTable',
  templateUrl: 'components/upc_products_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    getData: "&"
    searchText: "="
    page: "="
    limit: "="
    sort: "="
    dir: "="
    incrementPage: "&"
    scrollLoading: "="
    loading: "="
