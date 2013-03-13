class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :picture_uri
      t.boolean :active, :default => true
      t.float :price, :default => 0.0

      t.timestamps
    end
  end
end
