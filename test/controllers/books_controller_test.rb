require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create!(email: 'test@example.com', password: '123fake')
    @book = Book.create!(title: 'title', genre: 'genre', author: 'author')
    sign_in @user
  end

  test '#borrow creates a loan if the book is available' do
    assert @book.loans.last == nil

    get borrow_book_url(@book)

    assert @book.loans.last.user == @user
  end

  test '#borrow returns and renders an error if the book is not available' do
    user2 = User.create!(email: 'another_test@example.com', password: '123fake')
    one_week_from_today = DateTime.now.beginning_of_day + 1.week
    @loan = Loan.create!(due_date: one_week_from_today, returned: false, book_id: @book.id, user_id: user2.id) # already checked out

    get borrow_book_url(@book)

    assert @response.body.include?("Sorry, something went wrong. Please try again.")
  end
end
