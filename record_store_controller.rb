require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')
require_relative('models/sale.rb')

get '/' do
  erb(:index)
end

get '/artists' do
  @artists = Artist.list_all()
  @albums = Album.list_all()
  erb(:"artist/artists")
end

get '/result' do
  @result = params['search'].capitalize
  @result_artist = Artist.search_artist(@result)
  @result_album = Album.search_album(@result)
  @result_genre = Artist.search_genre(@result)
  erb(:"all/result")
end


get '/albums' do
  @artists = Artist.list_all()
  if params[:order] == "stock"
    @albums = Album.list_all
  elsif params[:order] == "title"
    @albums = Album.list_by_quantity
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

get '/artists/:id/albums/new' do
  @sale = Sale.new('percent' => 100)
  @sale.save
  @artist = Artist.find(params[:id])
  erb(:"album/new_album")
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
  @album = Album.find(params[:id])
  @sale = Sale.new(params)
  @sale.save()
  @albums = params.map{|k, v| v}
  @albums.shift(2)
  @albums.pop
  @results = []
  for album in @albums
    @results.push(Album.find(album))
  end
    for result in @results
      result.sale_id = @sale.id
      result.update
    end
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
