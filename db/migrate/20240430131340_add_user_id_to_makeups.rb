class AddUserIdToMakeups < ActiveRecord::Migration[7.0]
  def change
    add_reference :makeups, :user, null: false, foreign_key: true
  end
end
