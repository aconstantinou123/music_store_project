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
album2 = Album.new('title' => 'Anthems to the Welkin at Dusk', 'artist_id' => artist1.id, 'quantity' => 10)
album2.save()
album3 = Album.new('title' => 'Wrath of the Tyrant', 'artist_id' => artist1.id, 'quantity' => 15)
album3.save()
album4 = Album.new('title' => 'De Mysteriis Dom Sathanas', 'artist_id' => artist3.id, 'quantity' => 2)
album4.save()
album5 = Album.new('title' => 'A Blaze in the Northern Sky', 'artist_id' => artist2.id, 'quantity' => 5)
album5.save()
album6 = Album.new('title' => 'Under a Funeral Moon', 'artist_id' => artist2.id, 'quantity' => 0)
album6.save()
album7 = Album.new('title' => 'Ruun', 'artist_id' => artist4.id, 'quantity' => 3)
album7.save()
album8 = Album.new('title' => 'Isa', 'artist_id' => artist4.id, 'quantity' => 7)
album8.save()
album9 = Album.new('title' => 'Hvis Lyset Tar Oss', 'artist_id' => artist5.id, 'quantity' => 17)
album9.save()
album10 = Album.new('title' => 'Filosofem', 'artist_id' => artist5.id, 'quantity' => 12)
album10.save()



binding.pry
nil
