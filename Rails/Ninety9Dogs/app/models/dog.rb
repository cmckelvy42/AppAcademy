# == Schema Information
#
# Table name: dogs
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  description :text
#  name        :string           not null
#  sex         :string(1)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'action_view'
class Dog < ApplicationRecord
    include ActionView::Helpers::DateHelper
    DOG_COLORS = %w(black white golden brown).freeze
    validates :color, inclusion: DOG_COLORS
    validates :sex, inclusion: %w(M F)
    validates :birth_date, :color, :name, :sex, presence:true
    validate :not_born_in_future

    has_many :rental_requests,
    class_name: :DogRentalRequest,
    dependent: :destroy
    

    def age
        time_ago_in_words(birth_date)
    end

    def not_born_in_future
        if birth_date > Date.today
            errors.add(:birth_date, "Dog cannot be born in the future!")
        end
    end
end
