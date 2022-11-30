class Movie

  attr_accessor :title
  attr_accessor :year
  attr_accessor :tmdb_id
  attr_accessor :vote_average
  attr_accessor :likes
  attr_accessor :poster_path

  def initialize(title:, year:, tmdb_id:, vote_average:, poster_path:)
    @title = title
    @year = year
    @tmdb_id = tmdb_id
    @vote_average = vote_average
    @poster_path = poster_path
  end

  def poster_url
    "http://image.tmdb.org/t/p/w185/#{poster_path}"
  end

end