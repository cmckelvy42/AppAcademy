# == Schema Information
#
# Table name: taggings
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :integer          not null
#  tag_topic_id     :integer          not null
#
# Indexes
#
#  index_taggings_on_tag_topic_id_and_shortened_url_id  (tag_topic_id,shortened_url_id) UNIQUE
#
class Tagging < ApplicationRecord
    validates :shortened_url, :tag_topic, presence: true
    validates :shortened_url_id, uniqueness: { scope: :tag_topic_id }

    belongs_to :tag_topic
    belongs_to :shortened_url

end
