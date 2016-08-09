Ctrl = ->
  ctrl = this

  return



angular.module('client').component 'receiptsTable',
  templateUrl: 'components/receipts_table/index.html'
  controller: Ctrl
  bindings:
    collection: "="
    searchText: "="
