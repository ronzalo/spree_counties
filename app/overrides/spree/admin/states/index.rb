Deface::Override.new(
  :virtual_path => "spree/admin/states/_state_list",
  :name => "add_state_counties_link",
  :insert_top => "td.actions",
  :text => "<%= link_to_with_icon('list', Spree.t(:counties), admin_state_counties_path(state.id), {class: 'btn btn-primary btn-sm', no_text: true}) %>"
)