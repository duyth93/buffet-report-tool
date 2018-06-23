'use strict';

angular.module('commonLib', []);

angular.module('commonLib')
  .factory('common', ['$http', '$q', function($http, $q){
    return {
      ajaxCall: function(method, url, params, cache) {
        var def = $q.defer();
        var formData = {method: method, url: url, cache: cache};
        var dataParam = {params: params};
        if (_.includes(HIDDEN_PARAM_METHODS, method)) {
          dataParam = {data: params};
        }
        formData = _.merge(formData, dataParam);
        $http(formData)
          .then(function(res) {
            def.resolve(res);
          }, function(err) {
            def.reject(err);
          })
        return def.promise;
      }
    }}
  ])

window.defaultConfig = function($httpProvider, $locationProvider, $qProvider) {
  var csrfTokenElm = document.getElementsByName('csrf-token'),
      csrfToken = csrfTokenElm[0] ? csrfTokenElm[0].content : '';
  $httpProvider.defaults.headers.common.Accept = 'application/json';
  $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
  $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrfToken;
  $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrfToken;
  $httpProvider.defaults.headers.delete = {'X-CSRF-Token': csrfToken};

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false,
    rewriteLinks: false //disables url rewriting for relative links
  });

  $qProvider.errorOnUnhandledRejections(false);
}
