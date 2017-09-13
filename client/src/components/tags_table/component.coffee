Ctrl =($rootScope, $scope)->
  ctrl = this
  # ctrl.save =(obj, index)->
  #   ctrl.saveTag(obj: obj, index: index)
  return
Ctrl.$inject = ['$rootScope', '$scope']
angular.module('client').component 'tagsTable',
  templateUrl: 'components/tags_table/index.html'
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
    loading: "="
    loading: "="
    saveTag: "&"
    nextPage: "&"
    save: "&"
