# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  bonus      :boolean          default(FALSE), not null
#  lyrics     :text
#  ord        :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer          not null
#
# Indexes
#
#  index_tracks_on_album_id_and_ord  (album_id,ord) UNIQUE
#
class Track < ApplicationRecord
    validates :ord, :title, :album_id, presence:true
    validates_inclusion_of :bonus, :in => [true, false]
    belongs_to :album
    has_many :notes
end
