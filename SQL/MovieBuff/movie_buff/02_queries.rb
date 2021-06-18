def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.where(yr: 1980..1989).where(score: 3.0..5.0).select("id, title, yr, score")

end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie
  .where
  .not(
    yr: Movie.select(:yr).where('score > ?', 8.0)
  )
  .distinct
  .pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor
  .joins(:castings)
  .where(castings: {movie_id: 
    Movie.where(title: title)})
  .order("castings.ord ASC")
  .select("actors.id, actors.name")
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie
  .joins(:actors)
  .where("director_id = actors.id")
  .where("ord = 1")
  .select("movies.id, movies.title, actors.name")
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor
  .joins(:castings)
  .where.not(castings: {ord: 1})
  .group(:id)
  .order("COUNT(ord) DESC")
  .select("actors.name, actors.id, COUNT(ord) as roles")
  .limit(2)
end
