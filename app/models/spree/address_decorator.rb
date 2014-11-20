module Spree
  Address.class_eval do
    belongs_to :county, class_name: "Spree::County"
    Spree::PermittedAttributes.address_attributes << :county_id
    Spree::PermittedAttributes.address_attributes << :county_name
  end
end