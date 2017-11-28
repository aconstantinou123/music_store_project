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
  @result_genre = Artist.search_genre(@result)
  erb(:result)
end

get '/albums' do
  @artists = Artist.list_all()
  @albums = Album.list_all()
    erb(:albums)
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
    erb(:albums)
end

get '/artists/:id/albums/new' do
  @sale = Sale.new('percent' => 100)
  @sale.save
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

post '/artists/:id' do
  @sale = Sale.new(params)
  @sale.save()
  @albums = params.map{|k, v| v}
  @albums.shift
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
