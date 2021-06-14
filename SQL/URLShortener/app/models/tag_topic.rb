# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  tag        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tag_topics_on_tag  (tag) UNIQUE
#
class TagTopic < ApplicationRecord
    validates :tag, presence: true, uniqueness: true

    has_many :taggings, dependent: :destroy
    has_many :shortened_urls, through: :taggings

    def popular_links
        shortened_urls.select('long_url, short_url, COUNT(visits.id) AS num_visits')
        .joins(:visits)
        .group(:short_url, :long_url)
        .order('num_visits DESC')
        .limit(5)
    end

end
