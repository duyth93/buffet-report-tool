'use strict';

angular.module('app')
  .controller('ReportController', ['reportService', '$window', function(reportService, $window) {
    var _this = this;
    _this.report = $('#report').data('infos');
    if (_this.report) {
      _this.report.room_id = _this.report.room_id.toString();
      _this.report.template_id = _this.report.template_id.toString();
      _this.report_details = $('#report_details').data('infos') || [];
      _this.report.taskDetails = _this.report_details.map(function(details) {
        return [details.task, details.percent, details.actual].join(';');
      }).join('\n');
    }

    _this.toggleNavBar = function() {
      _this.isCollapsed = !_this.isCollapsed;
    };

    _this.sendReport = function() {
      _this.report.report_details_attributes = [];
      _this.report.taskDetails.split('\n').forEach(function(details) {
        var detailsArr = details.split(";");
        _this.report.report_details_attributes.push({
          task: detailsArr[0],
          percent: detailsArr[1],
          actual: detailsArr[2]
        });
      });

      reportService.post({report: _this.report}).then(function(res) {
        if (res.data.status) {
          $window.location.href = res.data.redirect_path;
        }
      });
    };
  }]);
