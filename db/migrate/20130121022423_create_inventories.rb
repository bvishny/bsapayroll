class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :product_id
      t.string :size, :default => "M"
      t.integer :quantity, :default => 0 # Can be +, -
      t.string :location, :default => "DESK"
      t.string :action, :default => "SALE" # SHIPMENT, SALE, TRASH, RETURN, MOVE, VOID
      t.integer :user_id
      t.float :avg_cost, :default => 0.0
      t.float :sale_price, :default => 0.0 # = AVG COST + PROFIT - DISCOUNT
      t.float :profit, :default => 0.0
      t.float :discount, :default => 0.0
      t.string :discount_code
      t.float :total, :default => 0.0
      t.string :comments
      t.timestamps
    end
    add_index :inventories, :product_id
    add_index :inventories, :user_id
  end
end
