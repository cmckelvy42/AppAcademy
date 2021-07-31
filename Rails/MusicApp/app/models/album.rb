# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  live       :boolean          default(FALSE), not null
#  title      :string           not null
#  year       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer          not null
#
# Indexes
#
#  index_albums_on_band_id  (band_id)
#  index_albums_on_title    (title)
#
class Album < ApplicationRecord
    validates :title, :year, :band_id, presence:true
    validates_inclusion_of :live, :in => [true, false]

    belongs_to :band
    has_many :tracks, dependent: :destroy
end
