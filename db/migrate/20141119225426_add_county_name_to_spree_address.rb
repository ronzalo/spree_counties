class AddCountyNameToSpreeAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :county_name, :string
  end
end
