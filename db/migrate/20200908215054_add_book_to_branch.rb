class AddBookToBranch < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :branch, foreign_key: true
  end
end
