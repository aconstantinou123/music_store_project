require('pry-byebug')
require_relative('../models/artist.rb')
require_relative('../models/album.rb')

Artist.delete_all()

artist1 = Artist.new('name' => 'Emperor', 'logo' => 'http://www.spirit-of-metal.com/les%20goupes/E/Emperor/pics/logo.jpg')
artist1.save()
artist2 = Artist.new('name' => 'Darkthrone' , 'logo' => 'http://symmetal.com/wp-content/uploads/2011/10/darkthrone-logo11.jpeg')
artist2.save()
artist3 = Artist.new('name' => 'Mayhem', 'logo' => 'http://thehowardtheatre.com/assets/mayhem-logo-652x367.jpg')
artist3.save()
artist4 = Artist.new('name' => 'Enslaved', 'logo' =>'https://i.pinimg.com/originals/cf/89/1d/cf891d66bd42234bc32e386f3abc382f.jpg')
artist4.save()
artist5 = Artist.new('name' => 'Burzum', 'logo' =>'http://4.bp.blogspot.com/-z1SjE_V6kN0/UqpmQwalXUI/AAAAAAAABAM/HgG5T_BgXOo/s1600/Burzum+Logo.jpg')
artist5.save()
artist6 = Artist.new('name' => 'Emperor', 'logo' =>'https://www.metal-archives.com/images/3/5/4/0/3540303310_logo.gif?2931')
Artist.list_all()

album1 = Album.new('title' => 'In the Nightside Eclipse', 'artist_id' => artist1.id, 'buy_price' => 7.49, 'sell_price' => 12.99, 'quantity' => 7)
album1.save()
album2 = Album.new('title' => 'Anthems to the Welkin at Dusk', 'artist_id' => artist1.id, 'buy_price' => 6.49, 'sell_price' => 10.99,'quantity' => 10)
album2.save()
album3 = Album.new('title' => 'Wrath of the Tyrant', 'artist_id' => artist1.id, 'buy_price' => 5.25, 'sell_price' => 10.25, 'quantity' => 15)
album3.save()
album4 = Album.new('title' => 'De Mysteriis Dom Sathanas', 'artist_id' => artist3.id, 'buy_price' => 10.49, 'sell_price' => 11.99, 'quantity' => 2)
album4.save()
album5 = Album.new('title' => 'A Blaze in the Northern Sky', 'artist_id' => artist2.id, 'buy_price' => 2.99, 'sell_price' => 6.99,'quantity' => 5)
album5.save()
album6 = Album.new('title' => 'Under a Funeral Moon', 'artist_id' => artist2.id, 'buy_price' => 6.49, 'sell_price' => 15.99,'quantity' => 0)
album6.save()
album7 = Album.new('title' => 'Ruun', 'artist_id' => artist4.id, 'buy_price' => 12.49, 'sell_price' => 12.99,'quantity' => 3)
album7.save()
album8 = Album.new('title' => 'Isa', 'artist_id' => artist4.id, 'buy_price' => 5.49, 'sell_price' => 10.99,'quantity' => 7)
album8.save()
album9 = Album.new('title' => 'Hvis Lyset Tar Oss', 'artist_id' => artist5.id, 'buy_price' => 8.99, 'sell_price' => 12.99,'quantity' => 17)
album9.save()
album10 = Album.new('title' => 'Filosofem', 'artist_id' => artist5.id, 'buy_price' => 3.49, 'sell_price' => 5.99, 'quantity' => 12)
album10.save()
album11 = Album.new('title' => 'The Work Which Transforms God', 'artist_id' => artist5.id, 'buy_price' => 7.49, 'sell_price' => 12.99, 'quantity' => 12)
album12 = Album.new('title' => 'Filosofem', 'artist_id' => artist5.id, 'buy_price' => 7.49, 'sell_price' => 12.99, 'quantity' => 12)




binding.pry
nil
