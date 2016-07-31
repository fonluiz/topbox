# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: 'Luiz', last_name: 'Fonseca', username: 'luizfo',
            email: 'luiz@gmail.com', password: 'luiz123')

User.create(first_name: 'Ítalo', last_name: 'Batista', username: 'italob',
            email: 'italo@gmail.com', password: 'italo123')

User.create(first_name: 'Jair', last_name: 'Neto', username: 'jairne',
            email: 'jair@gmail.com', password: 'jair123')

User.create(first_name: 'Laybson', last_name: 'Cunha', username: 'laybsonc',
            email: 'laybson@gmail.com', password: 'laybson123')

User.create(first_name: 'Gabriel', last_name: 'Morais', username: 'gabrielm',
            email: 'gabriel@gmail.com', password: 'gabriel123')