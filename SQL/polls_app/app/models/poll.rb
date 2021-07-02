# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#
# Indexes
#
#  index_polls_on_author_id  (author_id)
#  index_polls_on_title      (title)
#
class Poll < ApplicationRecord
    validates :title, presence: true
    
    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id,
        primary_key: :id
    has_many :questions
end
