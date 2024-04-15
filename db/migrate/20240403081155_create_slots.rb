class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.time :start_time
      t.time :end_time
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
