//= require jquery
//= require moment

$(function() {
  var today = moment().format("YYYY");
  $('footer').html('©' + today);
});
