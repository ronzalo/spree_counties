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