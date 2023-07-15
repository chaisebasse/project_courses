puts "seeding..."
User.destroy_all
Course.destroy_all
Section.destory_all
User.create(first_name: "Ermanno", last_name: "di Giulio", email: "digiulioermanno@gmail.com", password: "123456", admin: true)
course = Course.create(title: "Wassap")
Section.create!(title: 'Section 1', course:)
puts "done"
