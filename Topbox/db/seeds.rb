# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
luiz = User.create(first_name: 'Luiz', last_name: 'Fonseca', username: 'luizfo',
            email: 'luiz@gmail.com', password: 'luiz123')

italo = User.create(first_name: 'Ítalo', last_name: 'Batista', username: 'italob',
            email: 'italo@gmail.com', password: 'italo123')

jair = User.create(first_name: 'Jair', last_name: 'Neto', username: 'jairne',
            email: 'jair@gmail.com', password: 'jair123')

laybson = User.create(first_name: 'Laybson', last_name: 'Cunha', username: 'laybsonc',
            email: 'laybson@gmail.com', password: 'laybson123')

gabriel = User.create(first_name: 'Gabriel', last_name: 'Morais', username: 'gabrielm',
            email: 'gabriel@gmail.com', password: 'gabriel123')

# Home Folders
homelu = Folder.create(name: 'Meu TopBox', parent: nil , user: luiz)
homelu.save(validate: false)
homeit = Folder.create(name: 'Meu TopBox', parent: nil , user: italo)
homeit.save(validate: false)
homeja = Folder.create(name: 'Meu TopBox', parent: nil , user: jair)
homeja.save(validate: false)
homela = Folder.create(name: 'Meu TopBox', parent: nil , user: laybson)
homela.save(validate: false)
homega = Folder.create(name: 'Meu TopBox', parent: nil , user: gabriel)
homega.save(validate: false)
