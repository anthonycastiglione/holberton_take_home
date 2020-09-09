class HomeController < ApplicationController
  def index
    @loans_due_soon = Loan.due_soon(current_user)
  end
end
