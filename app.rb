require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')
require_relative('models/sale.rb')
require_relative('controllers/artist_controller.rb')
require_relative('controllers/album_controller.rb')
require_relative('controllers/all_controller.rb')

get '/' do
  erb(:index)
end
