# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
House.destroy_all
house1 = House.create(name:"My House")

Dog.destroy_all
dog1 = Dog.create(name:"Cubby", house_id:house1.id)
dog2 = Dog.create(name:"Lucky", house_id:house1.id)

Toy.destroy_all
toy1 = Toy.create(name:"big bone", color:"white", dog_id: dog1.id)
toy2 = Toy.create(name:"Kong", color:"red", dog_id: dog1.id)
toy3 = Toy.create(name:"Tennis Ball", color:"green", dog_id:dog2.id)