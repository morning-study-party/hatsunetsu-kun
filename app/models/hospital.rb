# == Schema Information
#
# Table name: hospitals
#
#  id                  :bigint           not null, primary key
#  address             :string           not null
#  holiday_support     :integer          default(0), not null
#  latitude            :float
#  longitude           :float
#  name                :string           not null
#  notification        :text
#  phone_number        :string           not null
#  primary_care_doctor :integer          default(0), not null
#  url                 :text             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Hospital < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :business_hours, dependent: :destroy
  has_one :target_group, dependent: :destroy
  has_one :inspection_type, dependent: :destroy
  enum primary_care_doctor: { only_regular: 0, all_patients: 1 }
  enum holiday_support: { closed: 0, open: 1, no_information: 2 }
end
