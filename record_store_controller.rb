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

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  @albums = Album.list_all
  erb(:show_artists)
end
