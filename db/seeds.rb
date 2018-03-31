User.create(name:"UNIQLO", password:"123456", password_confirmation:"123456", role: "supplier")
User.create(name:"ZARA", password:"123456", password_confirmation:"123456", role: "supplier")
User.create(name:"NET", password:"123456", password_confirmation:"123456", role: "supplier")
3.times do
	u = User.find(rand(1..3))
	u.cloths.create(supplier: u, code: rand(10000..99999), jancode: rand(1000000..99999))
end
3.times do
	Cloth.find(rand(1..3)).order_items.create(amount: rand(1..99))
end