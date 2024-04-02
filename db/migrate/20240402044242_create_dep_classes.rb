class CreateDepClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :dep_classes do |t|
      t.string :name
      t.references :room, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :strength

      t.timestamps
    end
  end
end
