class AddBranchToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :branch, foreign_key: false
  end
end
