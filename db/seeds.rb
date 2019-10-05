Purchase.destroy_all
Message.destroy_all
User.destroy_all

user1 = User.create(first_name: 'Ang', last_name: 'Spam', email: 'ang@spa.com', phone: '(919)919-9191', billing_address: '123 moooten lane', zip_code: '11111')
user2 = User.create(first_name: 'Aaron', last_name: 'Meow', email: 'aakron@ohio.com', phone: '(111)111-1111', billing_address: '111 main st', zip_code: '22222')
user3 = User.create(first_name: 'Stackajawea', last_name: 'Wasawomanonacoin', email: 'jack@duda.com', phone: '(101)101-1001', billing_address: '101 side st', zip_code: '20002')

Purchase.create(amount: 100, bundle_name: "starter pack", user_id: user1.id)
Purchase.create(amount: 100, bundle_name: "pro pack", user_id: user2.id)
Purchase.create(amount: 500, bundle_name: "ultra uber pack", user_id: user1.id)

Message.create(content: "hey this is the first message, i really like your music lol haha rofl", user_id: user1.id)
Message.create(content: "hey this is the second message, i really hate your music omg wow", user_id: user2.id)
