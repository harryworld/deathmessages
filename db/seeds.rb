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

m1 = Message.create(user_id: 1, title: "test", content: "test", date: Time.now)
m2 = Message.create(user_id: 1, title: "test", content: "test", date: Time.now)
m3 = Message.create(user_id: 1, title: "test", content: "test", date: Time.now)
m4 = Message.create(user_id: 1, title: "test", content: "test", date: Time.now)
m5 = Message.create(user_id: 1, title: "test", content: "test", date: Time.now)
m6 = Message.create(user_id: 2, title: "test", content: "test", date: Time.now)
m7 = Message.create(user_id: 2, title: "test", content: "test", date: Time.now)
m8 = Message.create(user_id: 2, title: "test", content: "test", date: Time.now)
m9 = Message.create(user_id: 2, title: "test", content: "test", date: Time.now)
m0 = Message.create(user_id: 2, title: "test", content: "test", date: Time.now)

m1.recipients << u2
m2.recipients << u3
m3.recipients << u4
m4.recipients << u2
m4.recipients << u3
m5.recipients << u3
m5.recipients << u4
m6.recipients << u1
m7.recipients << u3
m8.recipients << u4
m9.recipients << u1
m9.recipients << u3
m0.recipients << u3
m0.recipients << u4