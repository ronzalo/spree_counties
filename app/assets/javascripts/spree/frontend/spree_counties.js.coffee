Spree.ready ($) ->
  ($ '#bstate select').change ->
    updateCounty 'b'

  ($ '#sstate select').change ->
    updateCounty 's'

  updateCounty = (region) ->
    stateId = getStateId(region)
    if stateId?
      $.get '/api/counties', {state_id: stateId}, (data) ->
        Spree.Checkout[stateId] =
          counties: data.counties
        fillCounties(Spree.Checkout[stateId], region)

  getStateId = (region) ->
      $('#' + region + 'state select').val()

  fillCounties = (data, region) ->
    countiesRequired = false
    counties = data.counties

    countyPara = ($ '#' + region + 'county')
    countySelect = countyPara.find('select')
    countyInput = countyPara.find('input')
    countySpanRequired = countyPara.find('county-required')
    if counties.length > 0
      selected = parseInt countySelect.val()
      countySelect.html ''
      countyWithBlank = [{ name: '', id: ''}].concat(counties)
      $.each countyWithBlank, (idx, county) ->
        opt = ($ document.createElement('option')).attr('value', county.id).html(county.name)
        opt.prop 'selected', true if selected is county.id
        countySelect.append opt

      countySelect.prop('disabled', false).show()
      countyInput.hide().prop 'disabled', true
      countyPara.show()
      countySpanRequired.show()
      countySelect.addClass('required') if countiesRequired
      countySelect.removeClass('hidden')
      countyInput.removeClass('required')
    else
      countySelect.hide().prop 'disabled', true
      countyInput.show()
      if countiesRequired
        countySpanRequired.show()
        countyInput.addClass('required')
      else
        countyInput.val ''
        countySpanRequired.hide()
        countyInput.removeClass('required')
      countyPara.toggle(!!countiesRequired)
      countyInput.prop('disabled', !countiesRequired)
      countyInput.removeClass('hidden')
      countySelect.removeClass('required')

  updateCounty 'b'