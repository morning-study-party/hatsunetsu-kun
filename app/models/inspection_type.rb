# == Schema Information
#
# Table name: inspection_types
#
#  id                       :bigint           not null, primary key
#  pcr                      :integer          default(0), not null
#  qualitative_antigen_test :integer          default(0), not null
#  quantitative_inspection  :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  hospital_id              :bigint
#
# Indexes
#
#  index_inspection_types_on_hospital_id  (hospital_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#
class InspectionType < ApplicationRecord
  belongs_to :hospital
  enum pcr: { unavailable: 0, available: 1 }, _prefix: true
  enum qualitative_antigen_test: { unavailable: 0, available: 1 }, _prefix: true
  enum quantitative_inspection: { unavailable: 0, available: 1 }, _prefix: true
end
