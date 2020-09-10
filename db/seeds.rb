branch1 = Branch.create!(name: "Austin Branch")
branch2 = Branch.create!(name: "Chicago Branch")
user = User.create!(email: 'test@example.com', password: '123secret', branch: branch1)
genre1 = Genre.create!(name: 'Fantasy')
genre2 = Genre.create!(name: 'Adventure')
genre3 = Genre.create!(name: 'Epic')

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
book4.genres << genre3

one_week_from_today = DateTime.now.beginning_of_day + 1.week
new_loan = Loan.create!(due_date: one_week_from_today, returned_date: nil, book_id: book1.id, user_id: user.id, branch_id: branch1.id)
near_due_loan = Loan.create!(due_date: 1.day.from_now, returned_date: nil, book_id: book2.id, user_id: user.id, branch_id: branch1.id, created_at: 1.week.ago)
overdue_loan = Loan.create!(due_date: 1.day.ago, returned_date: nil, book_id: book3.id, user_id: user.id, branch_id: branch2.id, created_at: 1.week.ago)
returned_loan = Loan.create!(due_date: 1.day.ago, returned_date: 2.days.ago, book_id: book4.id, user_id: user.id, branch_id: branch2.id, created_at: 1.week.ago)
