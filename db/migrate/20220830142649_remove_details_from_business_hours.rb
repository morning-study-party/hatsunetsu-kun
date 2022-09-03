class RemoveDetailsFromBusinessHours < ActiveRecord::Migration[6.1]
  def change
    remove_column :business_hours, :open_at, :string, null: false
    remove_column :business_hours, :close_at, :string, null: false
  end
end
