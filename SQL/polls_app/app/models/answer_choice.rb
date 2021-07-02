# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#
# Indexes
#
#  index_answer_choices_on_question_id  (question_id)
#
class AnswerChoice < ApplicationRecord
    validates :text, presence: true
    belongs_to :question
    has_many :responses
end
