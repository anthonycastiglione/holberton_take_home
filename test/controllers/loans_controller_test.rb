require 'test_helper'

class LoansControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @branch = Branch.create!(name: 'branch')
    @branch2 = Branch.create!(name: 'branch2')
    @user = User.create!(email: 'test@example.com', password: '123fake', branch_id: @branch.id)

    sign_in @user
   end


  test '#update_branch sets the current users branch to the specified branch' do
    assert @user.branch == @branch

    get update_branch_branch_url(@branch2)

    @user.reload
    assert @user.branch == @branch2
  end
end
