(function() {
  angular.module('app', ['ngAnimate', 'commonLib'])
    .config(['$httpProvider', '$locationProvider', '$qProvider', defaultConfig])
})();
