class AddUserToLoans < ActiveRecord::Migration[6.0]
  def change
    add_reference :loans, :user, foreign_key: true
  end
end
