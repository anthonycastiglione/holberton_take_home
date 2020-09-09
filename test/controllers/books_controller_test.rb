require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @branch = Branch.create!(name: 'branch')
    @user = User.create!(email: 'test@example.com', password: '123fake')
    @book = Book.create!(title: 'title', genre: 'genre', author: 'author', branch: @branch)
    sign_in @user
  end

  test "#return returns the book" do
    one_week_from_today = DateTime.now.beginning_of_day + 1.week
    @loan = Loan.create!(due_date: one_week_from_today, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)

    assert @book.available? == false

    get return_book_url(@book)
    @loan.reload

    assert @book.available? == true
    assert @loan.returned_date != nil
    assert flash[:success].include?("Success")
  end

  test '#borrow creates a loan if the book is available' do
    assert @book.loans.last == nil

    get borrow_book_url(@book)

    assert @book.loans.last.user == @user
    assert flash[:success].include?("Success")
  end

  test '#borrow returns and renders an error if the book is not available' do
    user2 = User.create!(email: 'another_test@example.com', password: '123fake')
    one_week_from_today = DateTime.now.beginning_of_day + 1.week
    Loan.create!(due_date: one_week_from_today, returned_date: nil, book_id: @book.id, user_id: user2.id, branch_id: @branch.id) # already checked out

    get borrow_book_url(@book)

    assert flash[:error].include?("Sorry, something went wrong. Please try again.")
  end
end
