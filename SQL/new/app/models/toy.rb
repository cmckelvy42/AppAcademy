# == Schema Information
#
# Table name: toys
#
#  id         :bigint           not null, primary key
#  color      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dog_id     :integer          not null
#
class Toy < ApplicationRecord

    belongs_to :dog
    has_one :house, through: :dog
end
