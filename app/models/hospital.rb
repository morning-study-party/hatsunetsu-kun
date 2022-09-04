class Hospital < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :business_hours
  has_one :target_group
  has_one :inspection_type
end
