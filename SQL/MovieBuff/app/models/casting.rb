# == Schema Information
#
# Table name: castings
#
#  id       :bigint           not null, primary key
#  ord      :integer          not null
#  actor_id :integer          not null
#  movie_id :integer          not null
#
# Indexes
#
#  index_castings_on_actor_id               (actor_id)
#  index_castings_on_actor_id_and_movie_id  (actor_id,movie_id) UNIQUE
#  index_castings_on_movie_id               (movie_id)
#
class Casting < ApplicationRecord
  belongs_to :actor,
    class_name: :Actor,
    foreign_key: :actor_id,
    primary_key: :id

  belongs_to :movie,
    class_name: :Movie,
    foreign_key: :movie_id,
    primary_key: :id

end
