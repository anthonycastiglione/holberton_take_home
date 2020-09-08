branch1 = Branch.create!(name: "Austin Branch")
branch2 = Branch.create!(name: "Chicago Branch")
Address.create!(street: "211 E William Cannon Dr", city: "Austin", state: "Texas", zip: 78745, branch_id: branch1.id)
Address.create!(street: "400 S. State Street", city: "Chicago", state: "Illinois", zip: 60605, branch_id: branch2.id)

Book.create!(title: "The Fellowship of the Ring", genre: "Fantasy", author: "J. R. R. Tolkien", branch: branch1)
Book.create!(title: "The Two Towers", genre: "Fantasy", author: "J. R. R. Tolkien", branch: branch1)
Book.create!(title: "The Return of the King", genre: "Fantasy", author: "J. R. R. Tolkien", branch: branch2)
Book.create!(title: "The Hobbit", genre: "Fantasy", author: "J. R. R. Tolkien", branch: branch2)
