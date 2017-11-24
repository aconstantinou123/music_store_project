require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')

get '/artists' do
  @artists = Artist.list_all
  @albums = Album.list_all
  erb(:artists)
end
