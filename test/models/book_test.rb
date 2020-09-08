require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: 'test@example.com', password: '123fake')
    @book = Book.create!(title: 'title', genre: 'genre', author: 'author')
    @one_week_from_today = DateTime.now.beginning_of_day + 1.week
  end

  test 'available? is true if there was never a loan' do
    assert @book.available? == true
  end

  test 'available? is true if there are loans but the most recent is returned' do
    Loan.create!(due_date: @one_week_from_today, returned: true, book_id: @book.id, user_id: @user.id)
    assert @book.available? == true
  end

  test 'available? is ifalse if there are loans but the most recent is not returned' do
    Loan.create!(due_date: @one_week_from_today, returned: false, book_id: @book.id, user_id: @user.id)
    assert @book.available? == false
  end

  test 'checked_out_by_current_user is false if the last loan user does not match the current user' do
    user2 = User.create!(email: 'another_test@example.com', password: '123fake')
    Loan.create!(due_date: @one_week_from_today, returned: true, book_id: @book.id, user_id: user2.id)
    assert @book.checked_out_by_current_user(@user) == false
  end

  test 'checked_out_by_current_user is false if the last loan user matches and the book is returned' do
    Loan.create!(due_date: @one_week_from_today, returned: true, book_id: @book.id, user_id: @user.id)
    assert @book.checked_out_by_current_user(@user) == false
  end

  test 'checked_out_by_current_user is true if the last loan user matches and the book is not returned' do
    Loan.create!(due_date: @one_week_from_today, returned: false, book_id: @book.id, user_id: @user.id)
    assert @book.checked_out_by_current_user(@user) == true
  end
end
