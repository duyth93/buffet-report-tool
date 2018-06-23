'use strict';

angular.module('app')
  .controller('ReportController', [function() {
    var _this = this;

    _this.toggleNavBar = function() {
      _this.isCollapsed = !_this.isCollapsed;
    };
  }]);
