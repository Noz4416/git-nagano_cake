# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'admin@admin',
  password: 'adminadmin'
)

Customer.create!(
  first_name: 'test',
  last_name: 'customer',
  kana_first_name: 'テスト',
  kana_last_name: 'カスタマー',
  postal_code: 1234567,
  address: '愛知県名古屋市',
  email: 'test@test.com',
  telephone_number: '09088887777',
  encrypted_password: 'customer'
)

