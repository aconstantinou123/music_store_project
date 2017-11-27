require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')
require_relative('models/sale.rb')

get '/artists' do
  @artists = Artist.list_all()
  @albums = Album.list_all()
  erb(:artists)
end

get '/result' do
  @result = params['search'].capitalize
  @result_artist = Artist.search_artist(@result)
  @result_album = Album.search_album(@result)
  erb(:result)
end

get '/albums' do
  @sale = Sale.new('percent' => 1.00)
  @artists = Artist.list_all()
  @albums = Album.list_all()
    erb(:albums)
end

get '/artists/:id/albums/new' do
  @artist = Artist.find(params[:id])
  erb(:new_album)
end

post '/albums/album_message' do
  @album = Album.new(params)
  @result = @album.check_name
  @album.save()
  erb (:album_message)
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
  @artists = Artist.list_all()
  erb(:new)
end

post '/artists/message' do
  @artist = Artist.new(params)
  @result = @artist.check_name
  @artist.save()
  erb(:message)
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

delete '/:album_id' do
  artist = Album.find(params[:album_id])
  artist.delete()
  redirect to '/albums'
end

delete '/artists/:id' do
  artist = Artist.find(params[:id])
  artist.delete()
  redirect to '/artists'
end

delete 'albums/:album_id' do
  artist = Album.find(params[:album_id])
  artist.delete()
  redirect to '/albums'
end
