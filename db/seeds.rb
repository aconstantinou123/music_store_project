require('pry-byebug')
require_relative('../models/artist.rb')

Artist.delete_all()

artist1 = Artist.new('name' => 'Emperor')
artist1.save()
artist2 = Artist.new('name' => 'Darkthrone')
artist2.save()
artist3 = Artist.new('name' => 'Mayhem')
artist3.save()
artist4 = Artist.new('name' => 'Enslaved')
artist4.save()
artist5 = Artist.new('name' => 'Burzum')
artist5.save()

Artist.list_all()

binding.pry
nil
