// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require spree/backend/zone
//= require jquery
//= require jquery_ujs

var update_county = function (region, done) {
  'use strict';

  var state = $('span#' + region + 'state .select2').select2('val');
  var county_select = $('span#' + region + 'county select.select2');

  $.get('/api/counties?state_id=' + state, function (data) {
    var counties = data.counties;
    if (counties.length > 0) {
      county_select.html('');
      var counties_with_blank = [{
        name: '',
        id: ''
      }].concat(counties);
      $.each(counties_with_blank, function (pos, county) {
        var opt = $(document.createElement('option'))
          .prop('value', state.id)
          .html(county.name);
        county_select.append(opt);
      });
      county_select.prop('disabled', false).show();
      county_select.select2();

    } else {
      county_select.select2('destroy').hide();
    }

    if(done) done();
  });
};

// Fix precompile spree/backend/zone override. https://groups.google.com/forum/#!topic/spree-user/RyWmAWevTyk
$(document).ready(function(){
  if ($('#county_based').parent().parent().data('selected')) {
    $('#county_based').click();
  };
});
