puts "seeding..."
User.destroy_all
Course.destroy_all
Section.destroy_all
User.create(first_name: "Ermanno", last_name: "di Giulio", email: "digiulioermanno@gmail.com", password: "123456", admin: true)
User.create(first_name: "Hadrien", last_name: "Lecanuet", email: "hadrien@gmail.com", password: "654321", admin: false)
course = Course.create(title: "Wassap")
Section.create!(title: 'Section 1', course:)
puts "done"
