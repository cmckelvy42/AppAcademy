# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  score       :float            not null
#  title       :string           not null
#  votes       :integer          not null
#  yr          :integer          not null
#  director_id :integer          not null
#
# Indexes
#
#  index_movies_on_director_id  (director_id)
#  index_movies_on_title        (title)
#
class Movie < ApplicationRecord
  belongs_to :director,
    class_name: :Actor,
    foreign_key: :director_id,
    primary_key: :id

  has_many :castings,
    class_name: :Casting,
    foreign_key: :movie_id,
    primary_key: :id

  has_many :actors,
    through: :castings,
    source: :actor
end
