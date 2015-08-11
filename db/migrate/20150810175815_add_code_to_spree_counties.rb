class AddCodeToSpreeCounties < ActiveRecord::Migration
  def change
    add_column :spree_counties, :code, :string
  end
end
