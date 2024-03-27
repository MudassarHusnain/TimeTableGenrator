class RenameRoleColumnToRolesInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :role, :roles
  end
end
