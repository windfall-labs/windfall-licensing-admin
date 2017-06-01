Ctrl =($rootScope, $scope, RsdProduct)->
  ctrl = this

  ctrl.updateNeverProduct =(obj)=>
    RsdProduct.updateNeverProduct(id: obj.id)

  ctrl.determineRsdProductStatus =(obj)=>
    return obj.never_product == true

  ctrl.myPagingFunction =()->
    console.log ">>>>>" + @.page
    @.incrementPage({page: @.page})
    @.page = @.page + 1

  return

Ctrl.$inject = ['$rootScope', '$scope', 'RsdProduct']

angular.module('client').component 'rsdProductsTable',
  templateUrl: 'components/rsd_products_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    getData: "&"
    searchText: "="
    page: "="
    incrementPage: "&"
