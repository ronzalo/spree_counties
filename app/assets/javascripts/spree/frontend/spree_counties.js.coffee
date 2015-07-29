Spree.ready ($) ->
  if ($ '#checkout_form_address').is('*')
    getStateId = (region) ->
      $('#' + region + 'state select:visible').val()

    Spree.updateCounty = (region) ->
      stateId = getStateId(region)
      if stateId? and stateId
        unless Spree.Checkout[stateId]?
          $.get '/api/counties', {state_id: stateId}, (data) ->
            Spree.Checkout[stateId] =
              counties: data.counties
              counties_required: false #data.counties_required
            Spree.fillCounties(Spree.Checkout[stateId], region)
        else
          Spree.fillCounties(Spree.Checkout[stateId], region)

      else
        countyPara = ($ '#' + region + 'county')
        countySelect = countyPara.find('select')
        countyInput = countyPara.find('input')

        countyPara.hide()
        countySelect.hide().prop('disabled', true).val('')
        countyInput.hide().prop('disabled', true).val('')

    Spree.fillCounties = (data, region) ->
      countiesRequired = data.counties_required
      counties = data.counties

      countyPara = ($ '#' + region + 'county')
      countySelect = countyPara.find('select')
      countyInput = countyPara.find('input')
      countySpanRequired = countyPara.find('[id$="county-required"]')
      if counties.length > 0
        selected = parseInt countySelect.val()
        countySelect.html ''
        countyWithBlank = [{ name: '', id: ''}].concat(counties)
        $.each countyWithBlank, (idx, county) ->
          opt = ($ document.createElement('option')).attr('value', county.id).html(county.name)
          opt.prop 'selected', true if selected is county.id
          countySelect.append opt

        countySelect.prop('disabled', false).show()
        countyInput.hide().prop('disabled', true).val('')
        countyPara.show()
        countySpanRequired.show()
        countySelect.addClass('required') if countiesRequired
        countySelect.removeClass('hidden')
        countyInput.removeClass('required')
      else
        countySelect.hide().prop('disabled', true).val('')
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

    $(document).on 'change', '#bstate select', ->
      Spree.updateCounty 'b'

    $(document).on 'change', '#sstate select', ->
      Spree.updateCounty 's'

    $(document).on 'change', '#bcountry select', ->
      Spree.updateCounty 'b'

    $(document).on 'change', '#scountry select', ->
      Spree.updateCounty 's'

    Spree.updateCounty 'b'


    window.fillStatesOld = Spree.fillStates
    Spree.fillStates = (data, region) ->
      fillStatesOld(data, region)
      Spree.updateCounty(region)
