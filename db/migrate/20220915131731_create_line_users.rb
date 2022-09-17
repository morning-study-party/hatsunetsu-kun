class CreateLineUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :line_users do |t|
      t.string :line_user_id, null: false
      t.integer :select_type, default: 5, null: false

      t.timestamps
    end
  end
end
