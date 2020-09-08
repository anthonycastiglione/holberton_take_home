class LoansController < ApplicationController

  def index
    @current_loans = Loan.where(user: current_user).where(returned: false)
    @previous_loans = Loan.where(user: current_user).where(returned: true)
  end
end
