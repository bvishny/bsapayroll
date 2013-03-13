class AddArIdToInventories < ActiveRecord::Migration
  def change
  	add_column :inventories, :ar_id, :integer, :default => 0.0
  end
end
