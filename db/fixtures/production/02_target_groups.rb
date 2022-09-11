require 'csv'

target_groups_csv = CSV.readlines("db/fixtures/production/target_groups.csv")
target_groups_csv.shift
target_groups_csv.each do |row|
  TargetGroup.create(someone_who_has_had_close_contact: row[1].to_i, child: row[2].to_i, pregnant: row[3].to_i, hospital_id: row[4].to_i)
end
