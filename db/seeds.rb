# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  admin_name: 'admin',
  email: 'admin@login',
  password: '111111'
  )

guest = Member.create!(
  member_name: 'guest',
  email: 'guest@example.com',
  is_active: 'true',
  is_guest: 'true',
  password: '111111'
  )

  guest.member_image.attach(io: File.open(Rails.root.join('app/assets/images/GeorgiaO’Keeffe.jpg')), filename: 'GeorgiaO’Keeffe.jpg')

member1 =  Member.create!(
  member_name: 'John Doe',
  email: 'john@example.com',
  is_active: 'true',
  is_guest: 'false',
  password: '111111'
  )

  member1.member_image.attach(io: File.open(Rails.root.join('app/assets/images/ClaudeMonet.jpg')), filename: 'ClaudeMonet.jpg')

 member2 = Member.create!(
  member_name: 'Robert Johnson',
  email: 'robert@example.com',
  is_active: 'false',
  is_guest: 'false',
  password: '111111'
  )

  member2.member_image.attach(io: File.open(Rails.root.join('app/assets/images/StanleyTigerman.png')), filename: 'StanleyTigerman.png')

member3 = Member.create!(
  member_name: 'sample',
  email: 'sample@com',
  is_active: 'true',
  is_guest: 'false',
  password: '111111'
  )

  member3.member_image.attach(io: File.open(Rails.root.join('app/assets/images/AlmaThomas.jpg')), filename: 'AlmaThomas.jpg')