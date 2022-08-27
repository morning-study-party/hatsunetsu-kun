class CreateHospitals < ActiveRecord::Migration[6.1]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      t.integer :phone_number, null: false
      t.string :url
      t.text :notification
      t.integer :primary_care_doctor, default: 0, null: false
      t.string :address, null: false
      t.integer :holiday_support, default: 0, null: false
      t.float :latitude, null: false
      t.float :longitud, null: false

      t.timestamps
    end
  end
end
