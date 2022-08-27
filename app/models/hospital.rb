class Hospital < ApplicationRecord
    has_many :business_hours
    has_one :target_groups
    has_one :inspection_types
end
