require 'csv'

business_hours_csv = CSV.readlines("db/fixtures/development/business_hours_10.csv")
business_hours_csv.shift
business_hours_csv.each do |row|
  BusinessHour.create(open_at: row[1], close_at: row[2], meridian: row[3].to_i, day_of_week: row[4].to_i, hospital_id: row[5].to_i)
end
