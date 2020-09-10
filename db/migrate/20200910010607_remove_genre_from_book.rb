class RemoveGenreFromBook < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :genre
  end
end
