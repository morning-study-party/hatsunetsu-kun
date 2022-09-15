# == Schema Information
#
# Table name: line_users
#
#  id           :bigint           not null, primary key
#  select_type  :integer          default(5), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  line_user_id :string           not null
#
class LineUser < ApplicationRecord
end
