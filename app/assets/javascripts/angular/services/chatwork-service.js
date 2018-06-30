'use strict';

angular.module('app').service('chatworkService', ['common', function(common) {
  return {
    room_members: function (params) {
      return common.ajaxCall('GET', '/chatwork_apis/room_members', params);
    }
  }
}]);
