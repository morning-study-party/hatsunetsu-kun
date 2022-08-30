class AddDetailsToBusinessHours < ActiveRecord::Migration[6.1]
  def change
    add_column :business_hours, :open_at, :time, null: false
    add_column :business_hours, :close_at, :time, null: false
  end
end
