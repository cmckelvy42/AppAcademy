# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    has_many :visits
    has_many :submitted_urls, class_name: :ShortenedUrl, foreign_key: :user_id, primary_key: :id
    has_many :visited_urls, through: :visits, source: :shortened_url

end
