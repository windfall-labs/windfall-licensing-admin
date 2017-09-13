module = ($resource)->

  Tags = $resource "/api/tags/:id", {id: "@id"},
    {
      getList:
        url: "/api/tags.json"
        method: 'get'
        isArray: false

      # createTag:
      #   url: "/api/tags.json"
      #   method: 'post'
      #   isArray: false
      createTags:
        url: "/api/tags.json"
        method: 'post'
        isArray: false
    }

module.$inject = ['$resource']
angular.module('client').factory('Tags', module)
