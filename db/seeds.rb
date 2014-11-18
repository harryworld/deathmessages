# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(firstname: "Kelvin", lastname: "Lo", activated: true, deceased: false, email: "kel@email.com", password: "password", password_confirmation: "password")
u2 = User.create(firstname: "Harry", lastname: "Ng", activated: true, deceased: false, email: "harry@email.com", password: "password", password_confirmation: "password")
u3 = User.create(firstname: "Fer", lastname: "Fer", activated: true, deceased: false, email: "fer@email.com", password: "password", password_confirmation: "password")
u4 = User.create(firstname: "Mark", lastname: "Wilson", activated: true, deceased: false, email: "mark@email.com", password: "password", password_confirmation: "password")

m1 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m2 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m3 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m4 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m5 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m6 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m7 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m8 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")
m9 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg")

