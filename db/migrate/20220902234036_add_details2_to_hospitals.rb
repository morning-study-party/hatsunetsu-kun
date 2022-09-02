class AddDetails2ToHospitals < ActiveRecord::Migration[6.1]
  def change
    add_column :hospitals, :latitude, :float
    add_column :hospitals, :longitude, :float
  end
end
