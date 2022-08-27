class CreateTargetGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :target_groups do |t|
      t.integer :pregnant, default: 0, null: false
      t.integer :someone_who_has_had_close_contact, default: 0, null: false
      t.integer :child, default: 0, null: false
      t.belongs_to :hospital, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
