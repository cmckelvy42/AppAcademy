# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_responses_on_answer_choice_id  (answer_choice_id)
#  index_responses_on_user_id           (user_id)
#
class Response < ApplicationRecord
    validate :not_duplicate_response, unless: -> { answer_choice.nil? }
    belongs_to :respondent, class_name: :User, foreign_key: :user_id, primary_key: :id
    belongs_to :answer_choice
    has_one :question, through: :answer_choice, source: :question

    def sibling_responses
        self.question.responses.where.not(id:self.id)
    end

    def respondent_already_answered?
        sibling_responses.exists?(user_id: self.user_id)
    end

    def not_duplicate_response
        errors[:respondent_id] << 'Cannot vote twice on same question' if respondent_already_answered?
    end

    def respondent_not_author
        error[:respondent_id] << 'Cannot vote on your own poll' if self.question.poll.author_id == user_id
    end
end
