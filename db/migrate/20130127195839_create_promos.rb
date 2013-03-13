class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :code
      t.integer :available
      t.datetime :expires
      t.float :amount

      t.timestamps
    end
  end
end
