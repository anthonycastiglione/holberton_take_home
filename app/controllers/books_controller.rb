class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def return
    begin
      @book = Book.find(params[:id])
      @book.return_book

      flash[:success] = "Successfully returned your copy of #{@book.title}"
    rescue Exception
      flash[:error] = "Sorry, something went wrong. Please try again."
    end

    redirect_to action: 'index'
  end

  def borrow
    begin
      book = Book.find(params[:id])
      @loan = nil

      book.with_lock do
        break if !book.available? # Bail out if this book is not available
        one_week_from_today = DateTime.now.beginning_of_day + 1.week
        @loan = Loan.create!(due_date: one_week_from_today, book_id: book.id, user_id: current_user.id, branch_id: book.branch.id)
      end

      flash[:success] = "Success, your loan of #{@loan.book.title} is due back on #{@loan.due_date}."
    rescue Exception
      flash[:error] = "Sorry, something went wrong. Please try again."
    end

    redirect_to action: 'index'
  end
end
