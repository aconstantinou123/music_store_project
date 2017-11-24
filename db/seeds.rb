require('pry-byebug')
require_relative('../models/artist.rb')

Artist.delete_all()

artist1 = Artist.new('name' => 'Emperor')
artist1.save()

binding.pry
nil
