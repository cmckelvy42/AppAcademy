# == Schema Information
#
# Table name: dogs
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  house_id   :integer          not null
#
class Dog < ApplicationRecord
    validates :name, presence: true
    validate :check_name_length

    def check_name_length
        unless self.name.length >= 4
            errors.add :name, "is too short, must be 4 or more characters"
        end
    end

    has_many :toys
    belongs_to :house
end
