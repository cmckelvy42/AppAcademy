# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_shortened_urls_on_short_url  (short_url) UNIQUE
#  index_shortened_urls_on_user_id    (user_id)
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, :submitter, presence: true
    validates :short_url, uniqueness: true
    validate :no_spamming

    belongs_to :submitter, class_name: :User, foreign_key: :user_id, primary_key: :id

    has_many :visits, dependent: :destroy
    has_many :taggings, dependent: :destroy

    has_many :tag_topics, through: :taggings
    has_many :visitors, ->{distinct}, through: :visits


    def num_clicks
        return visits.count
    end

    def num_uniques
        return visitors.count
    end

    def num_recent_uniques
        visits.select('user_id').where('created_at > ?', 10.minutes.ago).count
    end

    def self.random_code()
        tmp = ""
        while tmp.empty? || ShortenedUrl.exists?(short_url: tmp)
            tmp = SecureRandom::urlsafe_base64(6)
        end
        tmp
    end

    def self.create!(user, url)
        ShortenedUrl.create(long_url: url, user_id: user.id, short_url: ShortenedUrl.random_code)
    end

    def no_spamming
        last_minute = ShortenedUrl
        .where('created_at >= ?', 1.minute.ago)
        .where(user_id: user_id).count

        errors[:maximum] << "You can only submit 5 URLs in one minute" if last_minute >= 5
    end

    def self.prune(n)
        ShortenedUrl.left_joins(:visits)
            .where('visits.created_at < ? OR
            (visits.id IS NULL AND shortened_urls.created_at < ?)',
            n.hours.ago, n.hours.ago).distinct.destroy_all
    end
end
