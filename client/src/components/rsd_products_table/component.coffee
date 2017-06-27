Ctrl =($rootScope, $scope, RsdProduct)->
  ctrl = this

  ctrl.updateRsdProduct =(obj, field)=>
    obj.never_product = false
    obj.coupon = false
    obj.always_a_product = false

    obj[field] = true
    RsdProduct.updateRsdProduct {id: obj.id, field: field}, (data) ->
      obj.never_product = data.never_product
      obj.coupon = data.coupon
      obj.always_a_product = data.always_a_product

  ctrl.determineRsdProductStatus =(obj)=>
    return obj.never_product == true

  ctrl.determineRsdProductCouponStatus =(obj)=>
    return obj.coupon == true

  ctrl.determineRsdProductAlwaysAProductStatus =(obj)=>
    return obj.always_a_product == true

  ctrl.myPagingFunction =()->
    console.log ">>>>>" + @.page
    @.incrementPage({page: @.page})
    @.page = @.page + 1

  ctrl.getDataP = (page, limit, sort, dir) ->
    @page = page
    @limit = limit
    @sort = sort
    if dir == 'asc'
      dir = 'desc'
    else
      dir = 'asc'
    @dir = dir
    @getData()

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
    limit: "="
    sort: "="
    dir: "="
    incrementPage: "&"
