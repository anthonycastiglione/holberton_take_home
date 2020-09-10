branch1 = Branch.create!(name: "Austin Branch")
branch2 = Branch.create!(name: "Chicago Branch")
genre1 = Genre.create!(name: 'Fantasty')
genre2 = Genre.create!(name: 'Adventure')

Address.create!(street: "211 E William Cannon Dr", city: "Austin", state: "Texas", zip: 78745, branch_id: branch1.id)
Address.create!(street: "400 S. State Street", city: "Chicago", state: "Illinois", zip: 60605, branch_id: branch2.id)

book1 = Book.create!(title: "The Fellowship of the Ring", author: "J. R. R. Tolkien", branch: branch1)
book2 = Book.create!(title: "The Two Towers", author: "J. R. R. Tolkien", branch: branch1)
book3 = Book.create!(title: "The Return of the King", author: "J. R. R. Tolkien", branch: branch2)
book4 = Book.create!(title: "The Hobbit", author: "J. R. R. Tolkien", branch: branch2)

book1.genres << genre1
book1.genres << genre2
book2.genres << genre1
book2.genres << genre2
book3.genres << genre1
book3.genres << genre2
book4.genres << genre1
book4.genres << genre2
