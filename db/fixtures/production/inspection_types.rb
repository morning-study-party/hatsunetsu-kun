require 'csv'

# ファイルを1行ずつ読み込んでコンマ区切りの配列で取得する
inspection_types_csv = CSV.readlines("db/fixtures/production/inspection_types.csv")
# 一番上の行はカラムの説明なので削除
inspection_types_csv.shift
inspection_types_csv.each do |row|
  InspectionType.create(pcr: row[1], qualitative_antigen_test: row[2], quantitative_inspection: row[3], hospital_id: row[4])
end
