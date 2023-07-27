puts "seeding..."
Order.destroy_all if Rails.env.development?
Video.destroy_all if Rails.env.development?
Section.destroy_all if Rails.env.development?
Course.destroy_all if Rails.env.development?
User.destroy_all if Rails.env.development?
User.create(first_name: "Ermanno", last_name: "di Giulio", email: "digiulioermanno@gmail.com", password: "123456", admin: true)
User.create(first_name: "Hadrien", last_name: "Lecanuet", email: "hadrien@gmail.com", password: "654321", admin: false)
course1 = Course.create(title: "Formation 1", price_cents: 1499)
Course.create(title: "Formation 2", price_cents: 1999)
section1 = Section.create!(title: 'Section 1', course: course1, price_cents: 1499)
Section.create!(title: 'Section 2', course: course1, price_cents: 1999)
Video.create!(name: "Video 2", section: section1)
puts "done"
