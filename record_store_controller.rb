require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')

get '/artists' do
  @artists = Artist.list_all()
  @albums = Album.list_all()
  erb(:artists)
end

get '/albums' do
  @artists = Artist.list_all()
  @albums = Album.list_all()
  erb(:albums)
end

get '/artists/:id/albums/new' do
  @artist = Artist.find(params[:id])
  erb(:new_album)
end

post '/albums' do
  @album = Album.new(params)
  @album.save()
  redirect to '/albums'
end

get '/albums/:id/edit' do
  @album = Album.find(params[:id])
  erb(:edit_album)
end

put '/albums/:id' do
  Album.new(params).update
  redirect to '/albums'
end

get '/artists/new' do
  erb(:new)
end

post '/artists' do
  @artist = Artist.new(params)
  @artist.save()
  redirect to '/artists'
end

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  @albums = Album.list_all
  erb(:show_artists)
end

get '/artists/:id/edit' do
  @artist = Artist.find(params[:id])
  erb(:edit)
end

put '/artists/:id' do
  Artist.new(params).update
  redirect to '/artists'
end

delete '/artists/:id' do
  artist = Artist.find(params[:id])
  artist.delete()
  redirect to '/artists'
end

delete '/:album_id' do
  artist = Album.find(params[:album_id])
  artist.delete()
  redirect to '/albums'
end
