# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movie.destroy_all

require 'json'
require 'open-uri'

url = 'http://tmdb.lewagon.com/movie/top_rated'
top_rated_movies = URI.open(url).read
movies = JSON.parse(top_rated_movies)

movie_images = movies['results']
movie_images.each do |movie|
  puts 'creating movie'
  Movie.create!(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  puts 'completed'
end
