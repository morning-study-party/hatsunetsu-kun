class CreateBusinessHours < ActiveRecord::Migration[6.1]
  def change
    create_table :business_hours do |t|
      t.string :open_at, null: false
      t.string :close_at, null: false
      t.integer :meridian, default: 0, null: false
      t.integer :day_of_week, default: 0, null: false
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
  end
end
