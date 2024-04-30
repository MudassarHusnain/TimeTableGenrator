class RenameSlotToSlotIdInMakeups < ActiveRecord::Migration[7.0]
  def change
    rename_column :makeups, :slot, :slot_id
  end
end
