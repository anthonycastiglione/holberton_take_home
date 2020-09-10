class AddGenre < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :name
      t.timestamps
    end

    create_table :books_genres, id: false do |t|
      t.belongs_to :book
      t.belongs_to :genre
    end
  end
end
