class AddDetailsToHospitals < ActiveRecord::Migration[6.1]
  def change
    add_column :hospitals, :phone_number, :string
    add_column :hospitals, :url, :text
  end
end
