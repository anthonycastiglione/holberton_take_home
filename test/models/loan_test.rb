require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  setup do
    @branch = Branch.create!(name: 'branch')
    @user = User.create!(email: 'test@example.com', password: '123fake')
    @book = Book.create!(title: 'title', genre: 'genre', author: 'author', branch: @branch)
    @book2 = Book.create!(title: 'title2', genre: 'genre2', author: 'author2', branch: @branch)
    one_week_from_today = DateTime.now.beginning_of_day + 1.week

    @new_loan = Loan.create!(due_date: one_week_from_today, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id)
    @near_due_loan1 = Loan.create!(due_date: 1.day.from_now, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @near_due_loan2 = Loan.create!(due_date: 1.day.from_now, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @overdue_loan = Loan.create!(due_date: 1.day.ago, returned_date: nil, book_id: @book.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)
    @returned_loan = Loan.create!(due_date: 1.day.ago, returned_date: 2.days.ago, book_id: @book.id, user_id: @user.id, branch_id: @branch.id, created_at: 1.week.ago)

  end

  test '.all_due_soon returns near-due loans' do
    assert Loan.all_due_soon(@user) == [@near_due_loan1, @near_due_loan2]
  end

  test '#due soon tells you if the loan duration is 50% over' do
    assert @new_loan.due_soon? == false
    assert @near_due_loan1.due_soon? == true
    assert @near_due_loan2.due_soon? == true
  end

  test '#due soon tells you if the loan duration is 50% over but not if its overdue' do
    assert @overdue_loan.due_soon? == false
  end

  test '#overdue tells you if the book is past its loan period' do
    assert @new_loan.due_soon? == false
    assert @new_loan.overdue? == false
    assert @overdue_loan.due_soon? == false
    assert @overdue_loan.overdue? == true
  end

  test '#returned checks if the book has been returned' do
    assert @returned_loan.returned? == true
  end
end
