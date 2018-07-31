# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ethan = User.create(email: 'e.ozelius@gmail.com', password: 'asdfasdf', first_name: 'ethan',
					description: 'just a gonza hacker trying to get more sunshine')

ethan.driftmap = Driftmap.create(lat: 75, lng: 75, zoom: 5)
