require 'csv'

# ファイルを1行ずつ読み込んでコンマ区切りの配列で取得する
business_hours_csv = CSV.readlines("db/fixtures/production/business_hours.csv")
# 一番上の行はカラムの説明なので削除
business_hours_csv.shift
business_hours_csv.each do |row|
  BusinessHour.create(open_at: row[1], close_at: row[2], meridian: row[3], day_of_week: row[4], hospital_id: row[5])
end
