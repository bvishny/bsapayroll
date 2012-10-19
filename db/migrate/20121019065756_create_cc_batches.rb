class CreateCcBatches < ActiveRecord::Migration
  def change
    create_table :cc_batches do |t|
      t.date :batch_date
      t.string :batch_number
      t.string :customer_code
      t.integer :user_id
      t.string :gl_account_number
      t.float :vs_total, :default => 0.0
      t.float :mc_total, :default => 0.0
      t.float :dis_total, :default => 0.0
      t.float :amex_total, :default => 0.0
      t.timestamps
    end
    
    add_index :cc_batches, :batch_number
    add_index :cc_batches, :user_id
  end
end
