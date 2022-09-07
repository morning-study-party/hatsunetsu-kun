require 'csv'

# ファイルを1行ずつ読み込んでコンマ区切りの配列で取得する
target_groups_csv = CSV.readlines("db/fixtures/production/target_groups.csv")
# 一番上の行はカラムの説明なので削除
target_groups_csv.shift
target_groups_csv.each do |row|
  TargetGroup.create(someone_who_has_had_close_contact: row[1], child: row[2], pregnant: row[3], hospital_id: row[4])
end
