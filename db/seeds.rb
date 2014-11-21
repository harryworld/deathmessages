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
u5 = User.create(firstname: "Dead", lastname: "Guy", activated: true, deceased: true, email: "deadguy@email.com", password: "password", password_confirmation: "password")
u6 = User.create(firstname: "Dead", lastname: "Girl", activated: true, deceased: true, email: "deadgirl@email.com", password: "password", password_confirmation: "password")

m1 = Message.create(user_id: 1, title: "hi", content: "byee", date: Time.now)
m2 = Message.create(user_id: 1, title: "yo", content: "see you", date: Time.now)
m3 = Message.create(user_id: 1, title: "hey", content: "good bye", date: Time.now)
m4 = Message.create(user_id: 1, title: "long time no see", content: "waaaa", date: Time.now)
m5 = Message.create(user_id: 1, title: "hi", content: "hahahhaa", date: Time.now)
m6 = Message.create(user_id: 2, title: "hello", content: "test", date: Time.now)
m7 = Message.create(user_id: 2, title: "wei", content: "test", date: Time.now)
m8 = Message.create(user_id: 2, title: "whats up", content: "test", date: Time.now)
m9 = Message.create(user_id: 3, title: "duudeeee", content: "test", date: Time.now)
m10 = Message.create(user_id: 5, title: "doood", content: "test", date: Time.now)
m11 = Message.create(user_id: 5, title: "im dying", content: "test", date: Time.now)
m12 = Message.create(user_id: 6, title: "im dead", content: "test", date: Time.now)
m13 = Message.create(user_id: 6, title: "murdered", content: "test", date: Time.now)

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
m9.recipients << u2
m10.recipients << u1
m10.recipients << u2
m11.recipients << u1
m11.recipients << u3
m12.recipients << u1
m12.recipients << u4
m13.recipients << u1
m13.recipients << u2