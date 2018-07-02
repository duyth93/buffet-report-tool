'use strict';

angular.module('app')
  .controller('ReportController', ['reportService', 'chatworkService', 'templateService', '$window', '$scope',
    function(reportService, chatworkService, templateService, $window, $scope) {
    var _this = this;
    _this.$scope = $scope;
    _this.report = $('#report').data('infos');
    _this.templates = $('#templates').data('infos') || [];

    if (!_.isEmpty(_this.report)) {
      _this.report.room_id = _this.report.room_id.toString();
      _this.report.report_template_id = _this.report.report_template_id.toString();
      _this.report_details = $('#report_details').data('infos') || [];
      _this.report.taskDetails = _this.report_details.map(function(details) {
        return [details.task, details.percent, details.actual].join(';');
      }).join('\n');
    }
    _this.$scope.$watch("$ctrl.report.room_id", function() {
      if (_this.report.room_id) {
        _this.members = [];
        chatworkService.room_members({room_id: _this.report.room_id}).then(function(res) {
          _this.members = res.data.data;
        });
      }
    });

    _this.$scope.$watchGroup(["$ctrl.report.to_id", "$ctrl.members"], function() {
      if (_this.report.to_id && _this.members.length > 0) {
        _this.report.to_name = _this.members.find(function(mem) {
          return mem.account_id == _this.report.to_id;
        }).name;
      }
    });

    _this.$scope.$watchGroup(["$ctrl.report.from_id", "$ctrl.members"], function() {
      if (_this.report.from_id && _this.members.length > 0) {
        _this.report.from_name = _this.members.find(function(mem) {
          return mem.account_id == _this.report.from_id;
        }).name;
      }
    });

    _this.toggleNavBar = function() {
      _this.isCollapsed = !_this.isCollapsed;
    };

    _this.sendReport = function() {
      _this.report.report_details_attributes = [];
      if (!_.isEmpty(_this.report.taskDetails)) {
        _this.report.taskDetails.split('\n').forEach(function(details) {
          var detailsArr = details.split(";");
          _this.report.report_details_attributes.push({
            task: detailsArr[0],
            percent: detailsArr[1],
            actual: detailsArr[2]
          });
        });
      }

      reportService.post({report: _this.report}).then(function(res) {
        if (res.data.status) {
          $window.location.href = res.data.redirect_path;
        }
      });
    };

    _this.editTemplate = function() {
      _this.editedTemplate = {};
      templateService.get(_this.report.report_template_id).then(function(res) {
        _this.editedTemplate = res.data.template;
        $("#edit-template-modal").modal("show");
      });
    };

    _this.saveAsTemplate = function() {
      templateService.create({report_template: _this.editedTemplate}).then(function(res) {
        _this.templates = res.data.templates;
        _this.report.report_template_id = res.data.template.id;
        $("#edit-template-modal").modal("hide");
      });
    };

    _this.saveTemplate = function() {
      templateService.update({report_template: _this.editedTemplate}, _this.editedTemplate.id)
        .then(function(res) {
        _this.templates = res.data.templates;
        _this.report.report_template_id = res.data.template.id;
        $("#edit-template-modal").modal("hide");
      });
    };

    _this.deleteTemplate = function() {
      templateService.delete(_this.editedTemplate.id).then(function(res) {
        _this.templates = res.data.templates;
        _this.report.report_template_id = null;
        $("#edit-template-modal").modal("hide");
      });
    };
  }]);
