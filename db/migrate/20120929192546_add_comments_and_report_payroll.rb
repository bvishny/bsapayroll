class AddCommentsAndReportPayroll < ActiveRecord::Migration
  def up
    add_column :weeks, :comments, :string
    add_column :users, :report_payroll, :boolean
  end

  def down
  end
end
