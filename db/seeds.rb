# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.create!(title: "The Fellowship of the Ring", genre: "Fantasy", author: "J. R. R. Tolkien")
Book.create!(title: "The Two Towers", genre: "Fantasy", author: "J. R. R. Tolkien")
Book.create!(title: "The Return of the King", genre: "Fantasy", author: "J. R. R. Tolkien")
Book.create!(title: "The Hobbit", genre: "Fantasy", author: "J. R. R. Tolkien")

Branch.create!(name: "Austin Branch")
Branch.create!(name: "Chicago Branch")
