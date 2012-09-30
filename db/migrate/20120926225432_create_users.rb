class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :auth_key
      t.string :employee_id
      t.string :position_id
      t.string :password_digest
      t.decimal :hourly_rate, :default => 10.50
      t.string :work_unit, :default => "MANAGEMENT"
      t.boolean :is_admin, :default => false
      t.boolean :active, :default => true
      t.timestamps
    end
    
    add_index :users, :email
  end
end
