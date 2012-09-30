class SwitchHoursToFloats < ActiveRecord::Migration
  def up
    change_column :weeks, :day_0, :float
    change_column :weeks, :day_1, :float
    change_column :weeks, :day_2, :float
    change_column :weeks, :day_3, :float
    change_column :weeks, :day_4, :float
    change_column :weeks, :day_5, :float
    change_column :weeks, :day_6, :float
  end

  def down
  end
end
