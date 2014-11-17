# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(firstname: "Kelvin", lastname: "Lo", activated: true, deceased: false, email: "kel@email.com", password: "password", password_confirmation: "password")
User.create(firstname: "Harry", lastname: "Ng", activated: true, deceased: false, email: "harry@email.com", password: "password", password_confirmation: "password")
User.create(firstname: "Fer", lastname: "Fer", activated: true, deceased: false, email: "fer@email.com", password: "password", password_confirmation: "password")
User.create(firstname: "Mark", lastname: "Wilson", activated: true, deceased: false, email: "mark@email.com", password: "password", password_confirmation: "password")

Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")