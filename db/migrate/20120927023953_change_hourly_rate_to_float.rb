class ChangeHourlyRateToFloat < ActiveRecord::Migration
  def up
    change_column :users, :hourly_rate, :float
    change_column :weeks, :hourly_rate, :float
  end

  def down
  end
end
