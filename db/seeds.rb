# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = []
users.each { |u|
  user = User.new
  u.keys.each { |k| user[k] = u[k] }
  user.password = u["auth_key"]
  user.save!
}