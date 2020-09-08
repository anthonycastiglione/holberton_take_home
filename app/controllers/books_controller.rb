class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    book = Book.find(params[:id])
    @loan = nil
    book.with_lock do
      return if !book.available? # Bail out if this book is not available
      one_week_from_today = DateTime.now.beginning_of_day + 1.week
      @loan = Loan.create!(due_date: one_week_from_today, returned: false, book_id: book.id, user_id: current_user.id)
    end
  end
end
