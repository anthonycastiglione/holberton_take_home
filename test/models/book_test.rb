require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @branch = Branch.create!(name: 'branch')
    @user = User.create!(email: 'test@example.com', password: '123fake', branch: @branch)
    @book = Book.create!(title: 'title', author: 'author', branch: @branch)
    @genre = Genre.create!(name: "Fantasy")
    @book.genres << @genre
    @one_week_from_today = DateTime.now.beginning_of_day + 1.week
  end

  test '#genre_search finds a book by genre' do
    results = Book.genre_search(@genre.name, @user)

    assert results == [@book]
  end

  test '#genre_search finds a book case insensitively' do
    results = Book.genre_search('fantasy', @user)

    assert results == [@book]
  end

  test '#genre_search finds a book by partial match' do
    results = Book.genre_search('fanta', @user)

    assert results == [@book]
  end

  test '#genre_search finds a book at the users branch' do
    branch2 = Branch.create!(name: 'branch2')
    book2 = Book.create!(title: 'title', author: 'author', branch: branch2)
    book2.genres << @genre

    results = Book.genre_search(@genre.name, @user)

    assert results == [@book]
  end

  test 'available? is true if there was never a loan' do
    assert @book.available? == true
  end

  test 'available? is true if there are loans but the most recent is returned' do
    Loan.create!(due_date: @one_week_from_today, returned_date: DateTime.now, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)
    assert @book.available? == true
  end

  test 'available? is ifalse if there are loans but the most recent is not returned' do
    Loan.create!(due_date: @one_week_from_today, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)
    assert @book.available? == false
  end

  test 'checked_out_by_current_user is false if the last loan user does not match the current user' do
    user2 = User.create!(email: 'another_test@example.com', password: '123fake')
    Loan.create!(due_date: @one_week_from_today, returned_date: DateTime.now, book_id: @book.id, user_id: user2.id, branch_id: @branch.id)
    assert @book.checked_out_by_current_user(@user) == false
  end

  test 'checked_out_by_current_user is false if the last loan user matches and the book is returned' do
    Loan.create!(due_date: @one_week_from_today, returned_date: DateTime.now, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)
    assert @book.checked_out_by_current_user(@user) == false
  end

  test 'checked_out_by_current_user is true if the last loan user matches and the book is not returned' do
    Loan.create!(due_date: @one_week_from_today, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)
    assert @book.checked_out_by_current_user(@user) == true
  end
end
