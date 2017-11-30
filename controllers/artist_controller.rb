require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')
require_relative('../models/sale.rb')
require_relative('album_controller.rb')
require_relative('all_controller.rb')

get '/artists' do
  @albums = Album.list_all()
if params[:order] == "artist"
  @artists = Artist.list_all()
elsif params[:order] == "genre"
  @artists = Artist.list_by_genre()
elsif params[:order] == "stock"
  @artists = Artist.list_by_albums_quant()
else
  @artists = Artist.list_all()
end
  erb(:"artist/artists")
end

get '/artists/:id/albums/new' do
  @sale = Sale.new('percent' => 100)
  @sale.save
  @artist = Artist.find(params[:id])
  erb(:"album/new_album")
end

get '/artists/new' do
  @artists = Artist.list_all()
  erb(:"artist/new")
end

post '/artists/message' do
  @artist = Artist.new(params)
  @result = @artist.check_name
  @artist.save()
  erb(:"artist/message")
end

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  @albums = Album.list_all
  erb(:"artist/show_artists")
end

post '/artists/:id' do
  @artist = Artist.find(params[:id])
  @sale = Sale.new(params)
  @sale.save()
  @albums = Album.selective_sale_price(params, @sale)
    redirect to '/albums'
end

get '/artists/:id/edit' do
  @artist = Artist.find(params[:id])
  erb(:"artist/edit")
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
