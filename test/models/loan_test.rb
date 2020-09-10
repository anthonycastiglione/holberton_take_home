require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  setup do
    @branch = Branch.create!(name: 'branch')
    @user = User.create!(email: 'test@example.com', password: '123fake')
    @user2 = User.create!(email: 'test2@example.com', password: '123fake')

    @book = Book.create!(title: 'title', genre: 'genre', author: 'author', branch: @branch)
    @book2 = Book.create!(title: 'title3', genre: 'genre3', author: 'author3', branch: @branch)
    @book3 = Book.create!(title: 'title4', genre: 'genre4', author: 'author4', branch: @branch)
    @book4 = Book.create!(title: 'title5', genre: 'genre5', author: 'author5', branch: @branch)
    @book5 = Book.create!(title: 'title6', genre: 'genre6', author: 'author6', branch: @branch)
    @book6 = Book.create!(title: 'title7', genre: 'genre7', author: 'author7', branch: @branch)
    @book7 = Book.create!(title: 'title7', genre: 'genre7', author: 'author7', branch: @branch)
    one_week_from_today = DateTime.now.beginning_of_day + 1.week

    @new_loan = Loan.create!(due_date: one_week_from_today, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)
    @near_due_loan1 = Loan.create!(due_date: 1.day.from_now, returned_date: nil, book_id: @book2.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @near_due_loan2 = Loan.create!(due_date: 1.day.from_now, returned_date: nil, book_id: @book3.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @overdue_loan1 = Loan.create!(due_date: 1.day.ago, returned_date: nil, book_id: @book4.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @overdue_loan2 = Loan.create!(due_date: 1.day.ago, returned_date: nil, book_id: @book5.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @overdue_loan3 = Loan.create!(due_date: 1.day.ago, returned_date: nil, book_id: @book6.id, user_id: @user2.id, branch_id: @branch.id, created_at: 1.week.ago)
    @returned_loan = Loan.create!(due_date: 1.day.ago, returned_date: 2.days.ago, book_id: @book7.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
  end

  test '.all_overdue_for_user returns all over due loans for the specified user' do
    assert Loan.all_due_soon_for_user(@user) == [@near_due_loan1, @near_due_loan2]
  end

  test '.all_due_soon_for_user returns all near-due loans for the specified user' do
    assert Loan.all_overdue_for_user(@user) == [@overdue_loan1, @overdue_loan2]
  end

  test '.all_overdue returns all overdue books for ALL users' do
    assert Loan.all_overdue == [@overdue_loan1, @overdue_loan2, @overdue_loan3]
  end

  test '#due soon tells you if the loan duration is 50% over' do
    assert @new_loan.due_soon? == false
    assert @near_due_loan1.due_soon? == true
    assert @near_due_loan2.due_soon? == true
  end

  test '#due soon tells you if the loan duration is 50% over but not if its overdue' do
    assert @overdue_loan1.due_soon? == false
  end

  test '#overdue tells you if the book is past its loan period' do
    assert @new_loan.due_soon? == false
    assert @new_loan.overdue? == false
    assert @overdue_loan1.due_soon? == false
    assert @overdue_loan1.overdue? == true
  end

  test '#returned checks if the book has been returned' do
    assert @returned_loan.returned? == true
  end
end
