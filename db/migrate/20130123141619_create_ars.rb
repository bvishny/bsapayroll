class CreateArs < ActiveRecord::Migration
  def change
    create_table :ars do |t|
      t.float :amount # plus or minus
      t.string :method # "CASH", "VS", "MC", "DIS", "AMEX"
      t.string :action # "SALE", "REFUND", "SETTLE", "ADJUST"
      t.integer :user_id
      t.timestamps
    end
    add_index :ars, :user_id
  end
end
