class CreateInspectionTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :inspection_types do |t|
      t.integer :pcr, default: 0, null: false
      t.integer :qualitative_antigen_test, default: 0, null: false
      t.integer :quantitative_inspection, default: 0, null: false
      t.belongs_to :hospital, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
