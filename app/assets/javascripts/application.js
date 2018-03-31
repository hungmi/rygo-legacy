//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery.min
//= require popper
//= require bootstrap
//= require jquery.timeago

$(document).on("turbolinks:load", function() {
  $("time.timeago").timeago();
})