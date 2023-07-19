puts "seeding..."
Video.destroy_all
Section.destroy_all
Course.destroy_all
User.destroy_all
User.create(first_name: "Ermanno", last_name: "di Giulio", email: "digiulioermanno@gmail.com", password: "123456", admin: true)
User.create(first_name: "Hadrien", last_name: "Lecanuet", email: "hadrien@gmail.com", password: "654321", admin: false)
course1 = Course.create(title: "Formation 1")
Course.create(title: "Formation 2")
section1 = Section.create!(title: 'Section 1', course: course1)
Section.create!(title: 'Section 2', course: course1)
Video.create!(name: "Video 1", section: section1)
Video.create!(name: "Video 2", section: section1)
puts "done"
 