class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :action
      t.float :amount, :default => 0.0
      t.string :location, :default => "DESK"
      t.integer :user_id
      t.string :comments, :default => 0
      t.timestamps
    end

    add_index :events, :user_id
  end
end
