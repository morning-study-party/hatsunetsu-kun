class AddContactToHospitals < ActiveRecord::Migration[6.1]
  def change
    add_column :hospitals, :contact, :string, null: false
  end
end
