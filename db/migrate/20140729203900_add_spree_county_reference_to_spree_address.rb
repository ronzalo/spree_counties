class AddSpreeCountyReferenceToSpreeAddress < ActiveRecord::Migration
  def change
    add_reference :spree_addresses, :county, index: true
  end
end
