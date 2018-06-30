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
//= require angular/lib/angular.min
//= require angular/common
//= require angular/lib/angular-animate.min
//= require angular/lib/angular-cookies.min
//= require angular/lib/angular-messages.min
//= require angular/lib/angular-sanitize.min
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require popper
//= require popper
//= require lodash.min
//= require_tree ./angular/app
//= require_tree ./angular/controllers
//= require_tree ./angular/services
//= require bootstrap_sb_admin_base_v2

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

  // Toggle the side navigation
  $(document).on('click', "#sidenavToggler", function(e) {
    e.preventDefault();
    $("body").toggleClass("sidenav-toggled");
    $(".navbar-sidenav .nav-link-collapse").addClass("collapsed");
    $(".navbar-sidenav .sidenav-second-level, .navbar-sidenav .sidenav-third-level").removeClass("show");
  });
  // Force the toggled class to be removed when a collapsible nav link is clicked
  $(document).on("click", ".navbar-sidenav .nav-link-collapse", function(e) {
    e.preventDefault();
    $("body").removeClass("sidenav-toggled");
  });

  $(document).on("click", "#toggle-nav", function(e) {
    $("#navbar").toggleClass("hide-nav-bar", "show");
  });
});
