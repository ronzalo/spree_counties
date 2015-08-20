$ ->
  ($ '#country_based').click ->
    show_country()

  ($ '#state_based').click ->
    show_state()

  ($ '#county_based').click ->
    show_county()

  if ($ '#country_based').is(':checked')
    show_country()
  else if ($ '#state_based').is(':checked')
    show_state()
  else if ($ '#county_based').is(':checked')
    show_county()
  else
    show_state()
    ($ '#state_based').click()


show_country = ->
  ($ '#state_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#state_members').hide()

  ($ '#county_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#county_members').hide()

  ($ '#zone_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#zone_members').hide()

  ($ '#country_members :input').each ->
    ($ this).prop 'disabled', false

  ($ '#country_members').show()


show_state = ->
  ($ '#country_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#country_members').hide()

  ($ '#county_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#county_members').hide()

  ($ '#zone_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#zone_members').hide()

  ($ '#state_members :input').each ->
    ($ this).prop 'disabled', false

  ($ '#state_members').show()


show_county = ->
  ($ '#country_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#country_members').hide()

  ($ '#state_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#state_members').hide()

  ($ '#zone_members :input').each ->
    ($ this).prop 'disabled', true
  ($ '#zone_members').hide()

  ($ '#county_members :input').each ->
    ($ this).prop 'disabled', false

  ($ '#county_members').show()
