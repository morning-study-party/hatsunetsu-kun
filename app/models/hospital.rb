class Hospital < ApplicationRecord
    has_many :business_hours
    has_one :target_group
    has_one :inspection_type
end
