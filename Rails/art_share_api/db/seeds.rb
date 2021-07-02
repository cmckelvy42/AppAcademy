# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{username: "test1"}, {username: "test2"}])
artworks = Artwork.create([{image_url: "https://i.imgur.com/3febqZx.png", title:"Buttface", artist_id: 1}, {image_url: "https://i.imgur.com/umBBtsB.png", title:"Rear End Visage", artist_id: 2}])
artwork_shares = ArtworkShare.create artwork_id:2, viewer_id: 1