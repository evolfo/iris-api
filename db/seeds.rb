# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Purchase.destroy_all

User.create(first_name: 'Ang', last_name: 'Spam', email: 'ang@spa.com', phone: '(919)919-9191', billing_address: '123 moooten lane', zip_code: '11111')
User.create(first_name: 'Aaron', last_name: 'Meow', email: 'aakron@ohio.com', phone: '(111)111-1111', billing_address: '111 main st', zip_code: '22222')

Purchase.create(amount: 100, bundle_name: "starter pack", user_id: 2)
Purchase.create(amount: 100, bundle_name: "pro pack", user_id: 1)
