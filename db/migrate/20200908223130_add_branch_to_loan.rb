class AddBranchToLoan < ActiveRecord::Migration[6.0]
  def change
    add_reference :loans, :branch, foreign_key: true
  end
end
