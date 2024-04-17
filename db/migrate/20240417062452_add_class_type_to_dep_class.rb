class AddClassTypeToDepClass < ActiveRecord::Migration[7.0]
  def change
    add_column :dep_classes, :class_type, :string
  end
end
