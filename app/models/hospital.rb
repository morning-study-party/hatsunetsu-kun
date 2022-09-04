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
  has_many :business_hours
  has_one :target_group
  has_one :inspection_type
end
