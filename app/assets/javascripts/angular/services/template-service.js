'use strict';

angular.module('app').service('templateService', ['common', function(common) {
  return {
    get: function (id) {
      return common.ajaxCall('GET', '/report_templates/' + id);
    },
    create: function (params) {
      return common.ajaxCall('POST', '/report_templates', params);
    },
    update: function (params, id) {
      return common.ajaxCall('PUT', '/report_templates/' + id, params);
    },
    delete: function (id) {
      return common.ajaxCall('DELETE', '/report_templates/' + id);
    }
  }
}]);
