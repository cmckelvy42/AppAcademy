# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  image_url  :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer          not null
#
# Indexes
#
#  index_artworks_on_artist_id            (artist_id)
#  index_artworks_on_image_url            (image_url) UNIQUE
#  index_artworks_on_title_and_artist_id  (title,artist_id) UNIQUE
#
class Artwork < ApplicationRecord
    validates :title, :image_url, presence: true
    validates :image_url, uniqueness: true
    validates :title, uniqueness: {scope: :artist_id}

    belongs_to :artist, foreign_key: :artist_id, class_name: 'User'
    has_many :artwork_shares, dependent: :destroy
    has_many :comments, dependent: :destroy

    def self.artworks_for_user_id(id)
        Artwork.left_joins(:artwork_shares)
        .where('(artworks.artist_id = :id) OR (artwork_shares.viewer_id = :id)', id:id)
        .distinct
    end

end
