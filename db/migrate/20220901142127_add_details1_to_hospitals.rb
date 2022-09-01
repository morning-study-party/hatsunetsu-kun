class AddDetails1ToHospitals < ActiveRecord::Migration[6.1]
  def change
    add_column :hospitals, :phone_number, :string, null: false
    add_column :hospitals, :url, :text, null: false
  end
end
