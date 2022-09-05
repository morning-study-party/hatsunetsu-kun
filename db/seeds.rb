require "csv"

hospitals_csv = CSV.readlines("db/hospitals_test.csv")
hospitals_csv.shift
hospitals_csv.each do |row|
  Hospital.create(name: row[1], phone_number: row[2], url: row[3], notification: row[4], primary_care_doctor: row[5], address: row[6], holiday_support: row[7])
end