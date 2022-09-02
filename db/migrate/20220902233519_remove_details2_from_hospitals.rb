class RemoveDetails2FromHospitals < ActiveRecord::Migration[6.1]
  def change
    remove_column :hospitals, :latitude, :float, null: false
    remove_column :hospitals, :longitud, :float, null: false
  end
end
