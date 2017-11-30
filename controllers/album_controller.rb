require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')
require_relative('../models/sale.rb')
require_relative('artist_controller.rb')
require_relative('all_controller.rb')

get '/albums' do
  @artists = Artist.list_all()
  if params[:order] == "stock"
    @albums = Album.list_all
  elsif params[:order] == "title"
    @albums = Album.list_by_quantity
  elsif params[:order] == "sell"
    @albums = Album.list_by_sell_price
  elsif params[:order] == "buy"
    @albums = Album.list_by_buy_price
  elsif params[:order] == "artist"
    @albums = Album.list_by_artist_name
  else
    @albums = Album.list_all()
  end
  erb(:"album/albums")
end

post '/albums' do
    @sale = Sale.new(params)
    @sale.save()
    @artists = Artist.list_all()
    @albums = Album.list_all()
    @albums.map do |album|
      album.sale_id = @sale.id
      album.update()
  end
    erb(:"album/albums")
end

post '/albums/album_message' do
  @album = Album.new(params)
  @result = @album.check_name
  @album.save()
  erb (:"album/album_message")
end

get '/albums/:id/edit' do
  @album = Album.find(params[:id])
  erb(:"album/edit_album")
end

put '/albums/:id' do
  Album.new(params).update
  redirect to '/albums'
end

delete '/:album_id' do
  artist = Album.find(params[:album_id])
  artist.delete()
  redirect to '/albums'
end

delete 'albums/:album_id' do
  artist = Album.find(params[:album_id])
  artist.delete()
  redirect to '/albums'
end
