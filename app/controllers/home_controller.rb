class HomeController < ApplicationController
  def index
    @loans_due_soon = Loan.all_due_soon(current_user)
    @overdue_loans = Loan.all_overdue(current_user)
  end
end
