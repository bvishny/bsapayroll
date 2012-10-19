class AddBatchSubmissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_submit_batches, :boolean, :default => false
  end
end
