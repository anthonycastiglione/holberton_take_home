class HomeController < ApplicationController
  def index
    @branch = current_user.branch
    @loans_due_soon = Loan.all_due_soon_for_user(current_user)
    @overdue_loans = Loan.all_overdue_for_user(current_user)
  end
end
