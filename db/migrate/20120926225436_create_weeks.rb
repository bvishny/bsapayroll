class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :user_id
      t.date :begins
      t.date :ends
      t.decimal :day_0, :default => 0.0
      t.decimal :day_1, :default => 0.0
      t.decimal :day_2, :default => 0.0
      t.decimal :day_3, :default => 0.0
      t.decimal :day_4, :default => 0.0
      t.decimal :day_5, :default => 0.0
      t.decimal :day_6, :default => 0.0
      t.decimal :hourly_rate, :default => 10.50
      t.boolean :approved, :default => true
      t.timestamps
    end
    
    add_index :weeks, :user_id
    add_index :weeks, :begins
    add_index :weeks, :ends
  end
end
