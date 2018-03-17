// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require_tree .

$(function(){
  $(document).on('click', '.btn-delete-report-detail', function(e){
    e.preventDefault();
    $(this).parent().remove();
  });

  $(document).on('click', '#btn-add-report-detail', function(e){
    e.preventDefault();
    var newId = new Date().getTime();
    var regexp = new RegExp("new_report_details", "g")
    var content = $(this).parent().find('#report-detail-template').clone().html();
    $(this).parent().append(content.replace(regexp, newId));
  });

  $(document).on('click', '#btn-submit', function(e) {
    e.preventDefault();
    $('#report-detail-template').remove();
    $('form#new_report').submit();
  });
});
