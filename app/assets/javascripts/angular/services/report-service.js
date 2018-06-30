'use strict';

angular.module('app').service('reportService', ['common', function(common) {
  return {
    post: function (params) {
      return common.ajaxCall('POST', '/reports', params);
    }
  }
}]);
