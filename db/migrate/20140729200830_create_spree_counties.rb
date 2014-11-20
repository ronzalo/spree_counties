class CreateSpreeCounties < ActiveRecord::Migration
  def change
    create_table :spree_counties do |t|
      t.string :name
      t.references :state, index: true

      t.timestamps
    end
  end
end
