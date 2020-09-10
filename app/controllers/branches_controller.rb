class BranchesController < ApplicationController
  def index
    @branches = Branch.all
  end

  def update_branch
    current_user.branch_id = params[:id]
    current_user.save!

    redirect_to branches_url
  end
end
