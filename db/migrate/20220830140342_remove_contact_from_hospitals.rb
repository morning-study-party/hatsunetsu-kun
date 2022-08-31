class RemoveContactFromHospitals < ActiveRecord::Migration[6.1]
  def change
    remove_column :hospitals, :contact, :string, null: false
  end
end
