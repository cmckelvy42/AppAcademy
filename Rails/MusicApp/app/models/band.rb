# == Schema Information
#
# Table name: bands
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bands_on_name  (name) UNIQUE
#
class Band < ApplicationRecord
    validates :name, presence:true, uniqueness:true
    has_many :albums, dependent: :destroy
end
