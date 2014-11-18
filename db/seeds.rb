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

m1 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m2 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m3 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m4 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m5 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m6 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m7 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m8 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)
m9 = Message.create(user_id: 1, title: "test", content: "test", photo: "photo.jpg", send_date: Time.now)

