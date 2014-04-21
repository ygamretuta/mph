# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all

Category.create([
  {name:'Computers'},
  {name:'Automobile'},
  {name:'Video Gaming'},
  {name:'Sports'},
  {name:'Pets'},
  {name:'Appliances'},
  {name:'Mobile Phones'},
  {name:'Photography'},
  {name:'Clothing'}
])

User.delete_all

u = User.create(username:'admin', email:'mbb@gmail.com', password:'mbbadmin', password_confirmation:'mbbadmin')
u.remove_role :muggle
u.add_role :admin
u.add_role :master_wizard