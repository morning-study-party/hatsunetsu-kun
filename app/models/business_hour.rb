# == Schema Information
#
# Table name: business_hours
#
#  id          :bigint           not null, primary key
#  close_at    :time             not null
#  day_of_week :integer          default(0), not null
#  meridian    :integer          default(0), not null
#  open_at     :time             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hospital_id :bigint           not null
#
# Indexes
#
#  index_business_hours_on_hospital_id  (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#
class BusinessHour < ApplicationRecord
  belongs_to :hospital
end
