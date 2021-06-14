# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_visits_on_shortened_url_id  (shortened_url_id)
#  index_visits_on_user_id           (user_id)
#
class Visit < ApplicationRecord
    validates :visitor, :shortened_url, presence: true
    belongs_to :shortened_url
    belongs_to :visitor, class_name: :User, foreign_key: :user_id, primary_key: :id

    def self.record_visit!(visitor, url)
        create(shortened_url_id: url.id, user_id: visitor.id)
    end
end
