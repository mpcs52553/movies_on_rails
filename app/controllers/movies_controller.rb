class MoviesController < ApplicationController

  def index
    if params[:category] == 'now_playing'
      @movies = retrieve_movies(url_for_movies('now_playing'))
    elsif params[:search]
      @movies = retrieve_movies(url_for_search(params[:search]))
    else
      @movies = retrieve_movies(url_for_movies('top_rated'))
    end

    render 'index'
  end

private

  def retrieve_movies(url)
    response = HTTP.get(url)
    movie_data = JSON.parse(response.body)['results']
    good_movie_data = movie_data.select { |data| data['vote_average'].to_f > 7.0 }
    movies = good_movie_data.map do |movie_data| 
      Movie.new(title: movie_data['title'], year: movie_data['release_date']&.first(4), 
                tmdb_id: movie_data['id'], vote_average: movie_data['vote_average'], 
                poster_path: movie_data['poster_path'])
    end
    return movies
  end
  
  def url_for_search(keyword)
    apiKey = "api_key=bde024f3eb43f597aafe01ed9c9098c6"
    language = "language=en-US"
    region = "region=US"
    filter = "include_adult=false"
    query = "query=" + keyword
    base_url = "https://api.themoviedb.org/3/search/movie"
    return "#{base_url}?#{apiKey}&#{language}&#{region}&#{filter}&#{query}"
  end

  def url_for_movies(resource) 
    apiKey = "api_key=bde024f3eb43f597aafe01ed9c9098c6"
    language = "language=en-US"
    region = "region=US"
    filter = "include_adult=false"
    base_url = "https://api.themoviedb.org/3/movie/#{resource}"
    return "#{base_url}?#{apiKey}&#{language}&#{region}&#{filter}"
  end
end