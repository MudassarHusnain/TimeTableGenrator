class AddReasonToLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :reason, :string
  end
end
