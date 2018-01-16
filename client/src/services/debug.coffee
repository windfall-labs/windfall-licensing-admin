module = ($resource)->

  Debug = $resource "https://staging-licensing.windfall.me/api/debugs/:id", {id: "@id"},
    {
      get_list:
        url: "/receipt_list"
        method: 'get'
        isArray: false
    }

module.$inject = ['$resource']
angular.module('client').factory('Debug', module)
