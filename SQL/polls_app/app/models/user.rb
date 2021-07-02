# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name)
#
class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :responses
    has_many :answer_choices, through: :responses
    has_many :authored_polls,
      class_name: :Poll,
      foreign_key: :author_id,
      primary_key: :id
end
