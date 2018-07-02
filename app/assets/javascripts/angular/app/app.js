(function() {
  angular.module('app', ['ngAnimate', 'commonLib', 'toaster'])
    .config(['$httpProvider', '$locationProvider', '$qProvider', defaultConfig])
})();
