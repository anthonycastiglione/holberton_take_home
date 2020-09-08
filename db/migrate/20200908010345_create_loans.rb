class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.datetime :due_date
      t.boolean :returned
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
