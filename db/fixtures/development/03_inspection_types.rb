require 'csv'

inspection_types_csv = CSV.readlines("db/fixtures/development/inspection_types_10.csv")
inspection_types_csv.shift
inspection_types_csv.each do |row|
  InspectionType.create(pcr: row[1].to_i, qualitative_antigen_test: row[2].to_i, quantitative_inspection: row[3].to_i, hospital_id: row[4].to_i)
end
