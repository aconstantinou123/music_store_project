require('pry-byebug')
require_relative('../models/artist.rb')
require_relative('../models/album.rb')

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

album1 = Album.new('title' => 'In the Nightside Eclipse', 'artist_id' => artist1.id, 'quantity' => 7)
album1.save()

binding.pry
nil
