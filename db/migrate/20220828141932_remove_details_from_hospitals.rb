class RemoveDetailsFromHospitals < ActiveRecord::Migration[6.1]
  def change
    remove_column :hospitals, :phone_number, :integer
    remove_column :hospitals, :url, :string
  end
end
