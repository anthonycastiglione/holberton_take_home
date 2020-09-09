class LoansController < ApplicationController

  def index
    @current_loans = Loan.current_loans(current_user)
    @previous_loans = Loan.previous_loans(current_user)
  end
end
