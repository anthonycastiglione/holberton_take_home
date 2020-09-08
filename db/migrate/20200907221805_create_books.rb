class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :genre, null: false
      t.string :author, null: false

      t.timestamps null: false
    end

    add_index :books, :title
    add_index :books, :genre
    add_index :books, :author
  end
end
