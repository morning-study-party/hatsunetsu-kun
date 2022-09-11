# == Schema Information
#
# Table name: target_groups
#
#  id                                :bigint           not null, primary key
#  child                             :integer          default(0), not null
#  pregnant                          :integer          default(0), not null
#  someone_who_has_had_close_contact :integer          default(0), not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  hospital_id                       :bigint
#
# Indexes
#
#  index_target_groups_on_hospital_id  (hospital_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#
class TargetGroup < ApplicationRecord
  belongs_to :hospital
  enum pregnant: { unavailable: 0, available: 1 }, _prefix: true
  enum someone_who_has_had_close_contact: { unavailable: 0, available: 1 }, _prefix: true
  enum child: { unavailable: 0, available: 1 }, _prefix: true
end
