object false

child(@counties => :counties) do
  attributes :id, :name
end

if @counties.respond_to?(:num_pages)
  node(:count) { @counties.count }
  node(:current_page) { params[:page] || 1 }
  node(:pages) { @counties.num_pages }
end
