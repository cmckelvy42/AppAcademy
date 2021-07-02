# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  poll_id    :integer          not null
#
# Indexes
#
#  index_questions_on_poll_id  (poll_id)
#
class Question < ApplicationRecord
    validates :text, presence: true
    
    has_many :answer_choices
    has_many :responses, through: :answer_choices, source: :responses
    belongs_to :poll

    def results
        ret = {}
        choices = answer_choices.select("answer_choices.text, COUNT(responses.id) AS num_responses").left_joins(:responses).group("answer_choices.id")
        choices.each{|e| ret[e.text] = e.num_responses}
        ret
    end
end
