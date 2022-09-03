class RemoveDetails1FromHospitals < ActiveRecord::Migration[6.1]
  def change
    remove_column :hospitals, :phone_number, :string
    remove_column :hospitals, :url, :text
  end
end
