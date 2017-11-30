require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')
require_relative('../models/sale.rb')
require_relative('album_controller.rb')
require_relative('all_controller.rb')


get '/result' do
  @result = params['search'].capitalize
  @result_artist = Artist.search_artist(@result)
  @result_album = Album.search_album(@result)
  @result_genre = Artist.search_genre(@result)
  erb(:"all/result")
end
